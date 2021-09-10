reload_nginx() {
    docker-compose restart web
}

redeploy_app() {
    network="${PWD##*/}_back-end"
    service_name=api
    old_container_id=$(docker ps -f name=$service_name -q | tail -n1)

    echo "old container id: $old_container_id"
    echo ""
    echo ">>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
    echo ""
    echo "bring a new container online, running new code"
    echo "(nginx continues routing to the old container only)"
    echo ""
    echo ">>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
    echo ""

    docker-compose up -d --no-deps --scale $service_name=2 --no-recreate $service_name

    echo "wait for new container to be available"
    echo ""
    echo ">>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
    echo ""
    new_container_id=$(docker ps -f name=$service_name -q | head -n1)
    echo "new container id: $new_container_id"
    echo ""
    echo ">>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
    echo ""

    new_container_ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $new_container_id)
    docker run --rm --net $network curlimages/curl:7.78.0 curl --silent --include --retry-connrefused --retry 30 --retry-delay 5 --fail http://$new_container_ip:8000/healthz/ || exit 1

    echo ""
    echo "start routing requests to the new container (as well as the old)"
    echo ""
    echo ">>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
    echo ""
    reload_nginx

    echo "take the old container offline"
    echo ""
    echo ">>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
    echo ""

    docker stop $old_container_id
    docker rm $old_container_id

    docker-compose up -d --no-deps --scale $service_name=1 --no-recreate $service_name

    echo "stop routing requests to the old container"
    echo ""
    echo ">>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<"
    echo ""
    reload_nginx
}

main() {
    redeploy_app
}

main
