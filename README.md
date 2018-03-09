[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)
# ci-miniconda
Docker image for building Python packages in Jenkins

Featuring:
* [Miniconda](https://conda.io/miniconda.html)
* [Pipenv](https://docs.pipenv.org/)
* [Twine](http://twine.readthedocs.io/en/latest/)

# Development
## Building the image
```
docker build -t ci-miniconda .
```
## Running the image (for troubleshooting)
```
docker run -it -d --rm --name cm ci-miniconda:latest
```

Then:
```
docker exec -it cm sh
```
