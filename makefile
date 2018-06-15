all: 1 2

1:
	ruby ./src/make_cv.rb -i ./data/data.yaml -s ./data/style.txt -o ./out/output.pdf

2:
	ruby ./src/make_cv.rb -i ./data/data.yaml -s ./data/academic.txt -o ./out/academic.pdf

clean:
	rm -f ./out/output.pdf ./out/academic.pdf
