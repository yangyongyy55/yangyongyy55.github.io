#!/bin/bash

# 指定 DEB 包所在的目录
deb_directory="."

# 遍历 DEB 包并进行解包
for deb_file in "$deb_directory"/*.deb; do
    # 提取 DEB 包的文件名（不含扩展名）
    package_name=$(basename "$deb_file" .deb)

    # 创建以 DEB 包名命名的目录，如果目录已存在则跳过
    package_directory="$deb_directory/$package_name"
    if [ -d "$package_directory" ]; then
		echo -e "\033[0;31mSkipping\033[0m: Directory $package_directory already exists."
        continue
    fi

    mkdir -p "$package_directory"

    # 解包 DEB 包到相应目录
    dpkg-deb -R "$deb_file" "$package_directory"

    # 打印提示信息
	# echo -e "\033[0;32mDEB package $deb_file extracted to $package_directory\033[0m"
	echo -e "\033[0;32mSuccess\033[0m: DEB package $deb_file extracted to $package_directory"
done
