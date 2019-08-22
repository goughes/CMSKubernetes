FROM cmssw/cmsweb:20190710

ENV WDIR=/data

# Install oracle client
ADD install.sh $WDIR/install.sh
RUN sh $WDIR/install.sh
RUN rm -f $WDIR/install.sh

#Finished
