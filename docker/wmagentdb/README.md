This image contains both the oracle client and mariadb packages needed by WMAgent


If we have a separate oracle client container and a mariadb container we set a dependency chain of cmsweb -> oracleclient -> mariadb -> wmagent. If there is any need for another image to use the mariadb image, then you get oracle client as well which might not be the best method. Having a single wmagentdb image might help in this case.
