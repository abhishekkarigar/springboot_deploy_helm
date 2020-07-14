##  local testing  

minikube start --bootstrapper=localkube  
eval $(minikube docker-env)  

##  

make docker-build  
make docker-push

## 

curl -k http://$(minikube ip):5002/v2/_catalog  
curl -k http://192.168.99.x:5002/v2/_catalog  


## Default values for springboot-demoweb.  
### This is a YAML-formatted file.  
## Declare variables to be passed into your templates.  

replicaCount: 1

service:
  name: docker-spring-boot
  type: NodePort
  externalPort: 8085
  internalPort: 8085

ingress:
  enabled: false
  annotations:
  tls:

resources: {}

image:
  repository: 192.168.99.105:5002/karigartest
  tag: latest
  pullPolicy: IfNotPresent
imagePullSecret: karigar  

##  

helm install --dry-run springboot-demoweb/  
helm template springboot-demoweb  
helm install springboot-demoweb/  
helm history <helmlistname>  
helm history springboot

##  

kubectl get pods  
minikube service list  
minikube service <service_name> --url  

##  

curl -k <service_url>/rest/docker/hello  

##  references  

https://www.baeldung.com/spring-boot-minikube  

## packaging  

$ helm package springboot-demoweb  
Successfully packaged chart and saved it to: D:\OCEAN_EXPLORER\STUDY\docker-spring-boot\charts\springboot-demoweb-0.1.0.tgz  

## share your chart with others , create helm repo and publish your chart  

Helm Repo is an HTTP server that has file index.yaml and all your chart files  
you can do it with any http-server (python also is fine ) , but we will use GitHub pages  

first create a GitHub repo ,  
abhishekkarigar/helm-private-repo  

clone it and change the branch  
$ git clone https://github.com/abhishekkarigar/helm-private-repo.git  
$ cd helm-private-repo  
$ git checkout -b gh-pages  

$ touch index.yaml  
$ git add index.yaml  
$ git commit -a -m "first commit"  
$ git push --set-upstream origin gh-pages  

go to your repo https://github.com/abhishekkarigar/helm-private-repo/settings  
scroll down to github pages  section  , then choose gh-pages branch for the source  
copy the link https://abhishekkarigar.github.io/helm-private-repo/  

## now add our chart to the above repo  

$ helm package springboot-demoweb  
$ mv springboot-demoweb-0.1.0.tgz helm-private-repo/  
$ helm repo index helm-private-repo/ --url https://abhishekkarigar.github.io/helm-private-repo/  

this command generates index.yaml  

$ cat helm-private-repo/index.yaml  

apiVersion: v1
entries:
  springboot-demoweb:
  - apiVersion: v1
    appVersion: "1.0"
    created: "2020-07-14T02:48:07.8799939+05:30"
    description: A Helm chart for Kubernetes
    digest: fdec761e7724fe5900874026f0f28007ba20005971a80e79c11595ef60cd3ee8
    name: springboot-demoweb
    urls:
    - https://github.com/abhishekkarigar/helm-private-repo/springboot-demoweb-0.1.0.tgz
    version: 0.1.0
generated: "2020-07-14T02:48:07.8790172+05:30"  

$ git commit -a -m "finally"  
$ git push origin  

$ curl https://abhishekkarigar.github.io/helm-private-repo/index.yaml  

## now share it with others  

$ helm repo add helm-private-repo https://abhishekkarigar.github.io/helm-private-repo/  
$ helm repo list  
NAME					URL
helm-private-repo       https://abhishekkarigar.github.io/helm-private-repo/



## testing it by deploying  

$ helm install helm-private-repo/springboot-demoweb --name=springbootdemo  

if values need to be overriden then follow helm install --help  
ex:
$ helm install helm-private-repo/springboot-demoweb -f new_values.yaml --name=springbootdemo  

$ helm install helm-private-repo/springboot-demoweb --set image.repository=192.168.99.106:5002/karigartest --name=springbootdemo  

$ helm install helm-private-repo/springboot-demoweb --set image.repository=$(minikube ip):5002/karigartest --name=springbootdemo  

## verify  

$ kubectl get pods  

$ kubectl get svc  

# references  

https://medium.com/containerum/how-to-make-and-share-your-own-helm-package-50ae40f6c221  
https://github.com/abhishekkarigar/helm-private-repo/settings  = my github  

