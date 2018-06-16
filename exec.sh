#!/bin/sh

function all() {
	echo 初期化
	init

	echo 起動
	run
}

function all_docker() {
	echo 初期化
	init

	echo dockerイメージ作成
	docker build -t resume .

	echo dockerコンテナが存在していれば削除
	docker ps -a --filter "name=rsm" | awk 'BEGIN{i=0}{i++;}END{if(i>=2)system("docker stop rsm&&docker rm rsm")}'

	echo docker起動
	docker run --name rsm resume sh exec.sh

	echo 処理結果抽出
	docker cp rsm:/out .

	echo dockerコンテナ削除
	docker rm rsm
}

function init() {
	echo start-ini
	clean
	fonts_download
	echo end-ini
}

function run() {
	run1
	run2
}

function run1() {
	ruby ./src/make_cv.rb -i ./data/data.yaml -s ./data/style.txt -o ./out/output.pdf
}

function run2() {
	ruby ./src/make_cv.rb -i ./data/data.yaml -s ./data/academic.txt -o ./out/academic.pdf
}

function clean() {
	rm -rf ./out/*pdf
}

function fonts_download() {
	if [ -f ./fonts/ipaexg.ttf ]; then
		echo '===================================='
		echo 'ipaexg.ttfは既にダウンロード済です'
		echo '===================================='
	else
		echo '===================================='
		echo 'ipaexg.ttfをダウンロードします'
		echo '===================================='
		wget https://oscdl.ipa.go.jp/IPAexfont/ipaexg00301.zip
		unzip ipaexg00301.zip
		mv ipaexg00301/ipaexg.ttf ./fonts/
		rm -rf ipaexg00301 ipaexg00301.zip
	fi

	if [ -f ./fonts/ipaexm.ttf ]; then
		echo '===================================='
		echo 'ipaexm.ttfは既にダウンロード済です'
		echo '===================================='
	else
		echo '===================================='
		echo 'ipaexm.ttfをダウンロードします'
		echo '===================================='
		wget https://oscdl.ipa.go.jp/IPAexfont/ipaexm00301.zip
		unzip ipaexm00301.zip
		mv ipaexm00301/ipaexm.ttf ./fonts/
		rm -rf ipaexm00301 ipaexm00301.zip
	fi
}

# 引数と一致するfunctionを起動する
$1
