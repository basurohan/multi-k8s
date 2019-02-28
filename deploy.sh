docker build -t basurohan/multi-client:latest -t basurohan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t basurohan/multi-server:latest -t basurohan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t basurohan/multi-worker:latest -t basurohan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push basurohan/multi-client:latest
docker push basurohan/multi-client:$SHA
docker push basurohan/multi-server:latest
docker push basurohan/multi-server$SHA
docker push basurohan/multi-worker:latest
docker push basurohan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=basurohan/multi-server:$SHA
kubectl set image deployments/client-deployment client=basurohan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=basurohan/multi-worker:$SHA