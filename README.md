### Long Read RNA Pipeline

This project provides a Dockerfile capable of running https://github.com/ENCODE-DCC/long-read-rna-pipeline.

This Dockerfile has been run to create an image called `ccdl/long_read_rnaseq`.
You can retrieve this image with:

```
docker pull ccdl/long_read_rnaseq
```


### What this Docker image contains

This Docker image is based on the ubuntu:16.04 Docker image, so it contains a slim version of Ubuntu version 16.04.

All of the software listed [here](https://github.com/ENCODE-DCC/long-read-rna-pipeline/blob/master/docs/reference.md#software) has been installed on the Docker image including:
    * Python versions 2.7 and 3.7
    * Minimap2 2.17
    * Transcriptclean
    * TALON

In addition softare which those tools are dependent on has also been installed:
    * Bedtools v2.28.0
    * pybedtools
    * pyfasta
    * R version 3.4.2

### How to use this Docker image

Because of the way Docker works, you will need to mount a volume onto your Docker container in order to be able to pass it data.
Therefore it is recommended that you create a `data` directory somewhere on your host machine and mount it onto your docker container.
The docker --volume argument requires full paths, not relative paths.
So, if you have created a data directory in `/home/myname/data`, you can run the Docker container and mount the volume onto it with:

```
docker run --volume /home/myname/data:/home/user/data ccdl/long_read_rnaseq --interactive --tty /bin/bash
```

(If you're using Windows, this command might instead look like:

```
docker run --volume C:\Users\myname\data:/home/user/data ccdl/long_read_rnaseq --interactive --tty /bin/bash
```

Once you do so you will have a bash shell within the running Docker container.
For example, you can run the command `ls` and expect to see:
```
TALON-master  TranscriptClean-master  data
```

or the command `pwd` and expect to see:
```
/home/user
```

This `data` directory is now on BOTH your host machine (or as you might know it, your computer) and the running Docker container.
Therefore any data you want to use in your Docker container will need to be put into that directory on your host machine.
Correspondingly, any data you produce within your Docker container that you want to keep once your Docker container exits will also need to be put into that Docker container.

WARNING: when a Docker container exits all data that was within it is lost forever!!!
(With the exception of data that resides within a mounted volume.)

Note that this data directory can be located anywhere on your system as long as you supply the full path to it when running the Docker container.

### How to update this Docker image

Note that packages you install or changes you make to your environment while running the Docker container will not persist across runs.
If you would like to make changes of this nature you should instead modify the Dockerfile and rebuild the image.

The Dockerfile is simply called `Dockerfile`.
If you open that file you will a number of commands.
Depending on what kind of change you'd like to make you'll need to add new commands or modify existing ones.

The [Dockerfile reference](https://docs.docker.com/engine/reference/builder/) is fairly comprehensive.

Once you've modified the Dockerfile you can rebuild the image with:

```
docker build -t ccdl/long_read_rnaseq .
```

You will not be able to push this to Dockerhub, however you can use your new image locally.
If your changes seem like they would be generally helpful please open a Pull Request against this repository.
Once your Pull Request has been accepted we will rebuild and push the new image.
