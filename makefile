all: 1 2

1:
	ruby ./src/make_cv.rb -i ./data/data.yaml -s ./data/style.txt -o ./out/output.pdf

2:
	ruby ./src/make_cv.rb -i ./data/data.yaml -s ./data/academic.txt -o ./out/academic.pdf

clean:
	rm -f ./out/output.pdf ./out/academic.pdf

build:
	docker build -t resume:latest .

run:
	docker stop resume
	docker rm resume
	docker run -d --name resume resume:latest

exec:
	docker cp ./makefile resume:/makefile
	docker cp ./data resume:/data
	docker exec resume make all
	docker cp resume:/out .
