docker build -t kubia .
docker run --name kubia-container -p 8080:8080 -d kubia
docker inspect kubia-container
docker stop kubia-container
docker rm kubia-container
docker tag kubia beno333/kubia
docker push beno333/kubia
docker run -p 8080:8080 -d beno333/kubia

# connect to docker daemon on Windows
wsl -d docker-desktop

# create k8s cluster and connect to it
minikube start
kubectl cluster-info
minikube ssh


# K8S
kubectl get nodes
kubectl describe node <nodeName>
# kubectl run kubia --image=beno333/kubia --port=8080 
k create deploy kubia-deploy --image=beno333/kubia

k scale deploy kubia-deploy --replicas=3

# Minikube doesn’t support LoadBalancer services => instead use minikube service kubia-http
k expose deployment kubia-deploy --type=LoadBalancer --name=kubia-http --port=8080 --target-port=8080

# get all k8s resources
kubectl api-resources

k get pods -o wide

k explain cronjob.spec => get list of all fields

k create -f kubia-manual.yaml

k logs kubia-manual
k logs kubia-manual -c kubia

k port-forward kubia-manual 8888:8080

k create -f kubia-manual-with-labels.yaml

k get pods --show-labels

k get pods -L creation_method,env

kubectl label po kubia-manual creation_method=manual
kubectl label po kubia-manual-v2 env=debug --overwrite

kubectl get pods -l creation_method=manual
kubectl get pods -l env

k get nodes
k label node minikube gpu=true

k annotate pod kubia-manual semperis.com/my-annotation="foo bar"
k create -f custom-namespace.yaml

k delete po kubia-gpu
k delete po -l creation_method=manual

kubectl delete po --all  -> --all means all instances
k delete ns custom-namespace
k delete all --all

kubectl logs mypod --previous  // in case of crash

k get rc

kubectl label pod kubia-dmdck type=special
kubectl get pods --show-labels

kubectl label pod kubia-dmdck app=foo --overwrite

k get pods -L app // show App column

kubectl scale rc kubia --replicas=3

kubectl delete rc kubia --cascade=false // delete rc but keep pods created by rc

kubectl delete rc kubia --cascade=false (or --cascade=orphan)

kubectl create -f ssd-monitor-daemonset.yaml
kubectl label node minikube disk=ssd
kubectl label node minikube disk=hdd --overwrite