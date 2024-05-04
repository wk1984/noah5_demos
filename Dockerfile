# Dockerfile for binder
# Reference: https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html

FROM wk1984/hrldas500_2023:latest

USER root

# Create user alice with uid 1000
ARG NB_USER=alice
ARG NB_UID=1000
ENV NB_USER wk1984
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
RUN adduser --disabled-password --gecos "Default user" --uid ${NB_UID} ${NB_USER}

# Make sure the contents of the notebooks directory are in ${HOME}
# 
COPY case01/namelist.hrldas ${HOME}/
COPY case01/namelist.met ${HOME}/
COPY case01/NoahmpTable.TBL ${HOME}/
COPY case01/soil_thickness.dat ${HOME}/
COPY case01/create_point_data.exe ${HOME}/

RUN chown -R ${NB_USER}:${NB_USER} ${HOME}
 
# Switch to the user
USER ${NB_USER}
 
# Start in the home directory of the user
WORKDIR /home/${NB_USER}
# 
# CMD ["jupyter-lab" ,  "--ip=0.0.0.0"]