# UCL-certs
Add UCL Certs to linux / python environment

## Export cert chain from browser
![image](https://github.com/ACED-IDP/UCL-certs/assets/47808/24cc3c01-fc86-4c03-aa35-c04a147b088e)

> Note: Make sure you select the `idp-dev.cs.ucl.ac.uk` host in the Certificate Hierarchy and `Export` as Base64 certificate chain

This will create ~/Downloads/idp-dev.cs.ucl.ac.uk.cer, there should be 3 certificates in that file.

```
grep 'END CERT' ~/Downloads/idp-dev.cs.ucl.ac.uk.cer
-----END CERTIFICATE-----
-----END CERTIFICATE-----
-----END CERTIFICATE-----
```

## Update script with those certs
> See `add-ucl-to-ca-certs.sh`

## Build docker file

For example:

```
docker build -t ucl-certs . --progress=plain
```

## Test

```
docker run -it  ucl-certs bash

root@54fe5912c222:/# curl -s https://idp-dev.cs.ucl.ac.uk > /dev/null && echo curl works!
curl works!
root@54fe5912c222:/# python3 -c 'import requests ; requests.get("https://idp-dev.cs.ucl.ac.uk"); print("python works!")'
python works!

```

## Notes

* The `python` solution relies on setting [REQUESTS_CA_BUNDLE](https://requests.readthedocs.io/en/latest/user/advanced/#ssl-cert-verification).  The attached docker file sets this via docker's [ENV](https://docs.docker.com/engine/reference/builder/#env).  Similar steps should be taken in k8s/helm.


