#!/bin/bash


# 指定 DEB 包所在的目录
deb_directory="."

# 定义要排除的文件夹列表
exclude_folders=("ss" "outdeb" "out")

rm -rf "$deb_directory/out"
mkdir -p "$deb_directory/out"

# 遍历 DEB 包的目录
for package_directory in "$deb_directory"/*/; do
    # 提取目录名作为 DEB 包名
    package_name=$(basename "$package_directory")

    # 检查是否是要排除的文件夹
    if [[ " ${exclude_folders[@]} " =~ " ${package_name} " ]]; then
        echo "Skipping $package_name"
        continue
    fi

    # 指定打包后的 DEB 包文件名
    deb_file="$deb_directory/out/${package_name}.deb"

    # 打包目录成 DEB 包
    dpkg-deb -b "$package_directory" "$deb_file"

    # 打印提示信息
    echo "Package $package_name packed into $deb_file"
done
