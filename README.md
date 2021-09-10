### Zodiacs Club.

---

---

#### Zodiacs.club Documentation

You can change the values in the `.env` file

> > ##### Running the project

---

---

#### `Login to the GitHub container Registry`

---

---

> > Export the `PAT` variable shared with you as follows

```
$ export PAT=<Personal-Access-Token>
```

> > Authenticate Docker using the following command

```
$ echo $PAT | docker login docker.pkg.github.com -u USERNAME --password-stdin
```

---

---

---

> > To show usage commands

```
$ make help
```

> > To start the containers verbosely

```
$ make start-verbose
```

> > To start the containers in the background

```
$ make start
```

> > To stop the app containers

```
$ make stop
```

---

Access the frontend from the url `http://localhost`

Access the backend from the url `http://localhost/api/v1/docs`
