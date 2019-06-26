This project provides a Dockerfile capable of running https://github.com/ENCODE-DCC/long-read-rna-pipeline.

This Dockerfile has been run to create an image called `ccdl/long_read_rnaseq`.
You can retrieve this image with:

```
docker pull ccdl/long_read_rnaseq
```

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
