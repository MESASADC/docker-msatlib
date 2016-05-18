Meteosatlib and xrit2pic
========================

This docker image contains the necessary libraries to use Meteosatlib and xrit2pic for converting EUMETCast (Meteosat) HRIT images into image formats commonly supported on web browsers.

- meteosatlib instructions: http://sourceforge.net/projects/meteosatlib/files/
- meteosatlib home: http://sourceforge.net/p/meteosatlib/wiki/Home/
- usage examples: http://sourceforge.net/p/meteosatlib/wiki/Examples/

It requires EUMETCast Wavelet Decompression library:

- fill the software license request form at http://oiswww.eumetsat.int/WEBOPS-cgi/wavelet/register to obtain the source code
- download link given to clai@csir.co.za on 3 Jul 2014, http://oiswww.eumetsat.org/wavelet/html/1404297436/PublicDecompWT.zip 

The **docker build** process includes downloading the required libraries, compiling and installing (to */usr/local* by default). The main utility program from Meteosatlib is *msat* which relies on GDAL library. In order to enhanced GDAL with additional custom drivers, the environment variable **GDAL_DRIVER_PATH** must be set to the Meteosatlib GDAL plugin directory, e.g. */usr/local/lib/gdalplugins/1.11* (the final bit depends on the exact version of GDAL).

In a successful installation, **gdalinfo --formats | grep -i msat** will output:

```
  MsatXRIT (ro): Meteosat xRIT (via Meteosatlib)
  MsatSAFH5 (ro): SAF HDF5 (via Meteosatlib)
  MsatNetCDF (rw): Meteosatlib NetCDF
  MsatNetCDF24 (rw): Meteosatlib NetCDF24
  MsatGRIB (rw): Meteosatlib GRIB via grib_api
```

Note: in some cases it is neccersary to specify the GDAL_DRIVER_PATH explicitly:

```
  GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins/1.11 gdalinfo --formats | grep -i msat
```

# Directory structure

## main
Scripts and files used to build and run the Docker image

The user (e.g. eouser) who builds and runs the docker image must have 'docker' as one of his supplementary group, i.e.
```
  sudo usermod -a -G docker eouser
```

### Values baked into the Docker image. If changed, the image must be re*build*.
- REPO_NAME=meteosatlib
- REPO_TAG=1.3
- APPUSER=*username in container*
- APPUID=${SUDO_UID}
- APPPASS=*crypt hash for password, not used usually*
- HOME_DIR=*directory outside container to be mounted as /home/$APPUSER*

To build the Docker image:
```
  main/build
```

Examples, assuming raw XRIT files are in */data/tellicast/eumetcast/*:

```
# Convert to PNG and crop to South Africa bounding box
# in_dir will be mounted as /tmp/in/ in the container
env in_dir=/mnt/eumetcast/EUMETSAT_Data_Channel_2 main/run bash
msat --Area=-35,-22,14,33 --png /tmp/in/H-000-MSG3__-MSG3________-IR_108___-000008___-201407020830-C_
# Output in current directory
MSG3_Seviri_1_5_IR_108_20140702_0830.png

# To run non-interactively:
env in_dir=/mnt/eumetcast/EUMETSAT_Data_Channel_2 out_dir=/tmp/out MSAT_INPUT_FILE=H-000-MSG3__-MSG3________-IR_108___-000008___-201407020830-C_ main/run
```



