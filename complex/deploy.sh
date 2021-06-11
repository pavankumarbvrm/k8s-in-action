GIT_SHA=$(git rev-parse --short HEAD)

docker build -t pavankumarbvrm/multi-clients:latest -t pavankumarbvrm/multi-clients:$GIT_SHA -f ./clients/Dockerfile ./clients
docker build -t pavankumarbvrm/multi-server:latest -t pavankumarbvrm/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t pavankumarbvrm/multi-worker:latest -t pavankumarbvrm/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker


docker push pavankumarbvrm/multi-clients:$GIT_SHA
docker push pavankumarbvrm/multi-worker:$GIT_SHA
docker push pavankumarbvrm/multi-server:$GIT_SHA

docker push pavankumarbvrm/multi-clients:latest
docker push pavankumarbvrm/multi-worker:latest
docker push pavankumarbvrm/multi-server:latest

kubectl apply -f k8s/

kubectl set image deployments/server-deployment server=pavankumarbvrm/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=pavankumarbvrm/multi-clients:$GIT_SHA
kubectl set image deployments/worker-deployment worker=pavankumarbvrm/multi-worker:$GIT_SHA
