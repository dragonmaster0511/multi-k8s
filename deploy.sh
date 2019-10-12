docker build -t dragonmaster0511/multi-client:latest -t dragonmaster0511/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dragonmaster0511/multi-server:latest -t dragonmaster0511/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dragonmaster0511/multi-worker:latest -t dragonmaster0511/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dragonmaster0511/multi-client:latest
docker push dragonmaster0511/multi-server:latest
docker push dragonmaster0511/multi-worker:latest

docker push dragonmaster0511/multi-client:$SHA
docker push dragonmaster0511/multi-server:$SHA
docker push dragonmaster0511/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dragonmaster0511/multi-server:$SHA
kubectl set image deployments/client-deployment client=dragonmaster0511/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dragonmaster0511/multi-worker:$SHA