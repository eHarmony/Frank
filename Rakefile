def discover_latest_sdk_version
  latest_iphone_sdk = `xcodebuild -showsdks | grep -o "iphoneos.*$"`.chomp
  version_part = latest_iphone_sdk[/iphoneos(.*)/,1]
  version_part
end

def build_project(xcodeproject, scheme, build_dir, library_name)
  scheme_param = scheme == nil ? "" : "-scheme #{scheme}"
# clean everything first
  sh "xcodebuild -project #{xcodeproject} #{scheme_param} -configuration Release -sdk iphoneos BUILD_DIR=\"#{build_dir}\" clean"
  sh "xcodebuild -project #{xcodeproject} #{scheme_param} -configuration Release -sdk iphonesimulator BUILD_DIR=\"#{build_dir}\" clean"
  
# now build arm + x86 libraries
  sh "xcodebuild -project #{xcodeproject} #{scheme_param} -configuration Release -sdk iphoneos BUILD_DIR=\"#{build_dir}\" build"
  sh "xcodebuild -project #{xcodeproject} #{scheme_param} -configuration Release -sdk iphonesimulator BUILD_DIR=\"#{build_dir}\" build"

# and finish with the fat library
  sh "lipo -create -output \"dist/#{library_name}.a\" \"#{build_dir}/Release-iphoneos/#{library_name}.a\" \"#{build_dir}/Release-iphonesimulator/#{library_name}.a\""
end

desc "Build the UISpec universal library"
task :build_uispec do
  xcproject = "lib/UISpec/xcode/UISpec/UISpec.xcodeproj"
  scheme = "UISpec"
  build_path = pwd + "/build/UISpec"
  libname = "libUISpec"
  build_project(xcproject, scheme, build_path, libname)
end

desc "Build the KIF universal library"
task :build_kif do
  xcproject = "lib/KIF/KIF.xcodeproj"
  build_path = pwd + "/build/KIF"
  libname = "libKIF"
  build_project(xcproject, nil, build_path, libname)
end

desc "Build the Shelley universal library"
task :build_shelley do
  xcproject = "lib/Shelley/Shelley.xcodeproj"
  scheme = "Shelley"
  build_path = pwd + "/build/Shelley"
  libname = "libShelley"
  build_project(xcproject, scheme, build_path, libname)
end

desc "Build the Frank universal library"
task :build_frank do
  xcproject = "Frank.xcodeproj"
  scheme = "Frank"
  build_path = pwd + "/build/Frank"
  libname = "libFrank"
  build_project(xcproject, scheme, build_path, libname)
end


task :combine_libraries do
  `lipo -create -output "dist/libFrank.a" "build/Release-iphoneos/libFrank.a" "build/Release-iphonesimulator/libFrank.a"`
end

desc "Build a univeral library for both iphone and iphone simulator"
task :build_lib => [:prep_dist, :build_uispec,:build_kif,:build_shelley,:build_frank]

desc "clean build artifacts"
task :clean do
  rm_rf 'dist'
end

desc "create dist directory"
task :prep_dist do
  mkdir_p 'dist'
end

task :build => [:clean, :prep_dist, :build_lib, :build_shelley]
task :default => :build

desc "compile libShelley.a and copy it into dist"
task :build_shelley do
  sh 'cd lib/Shelley && rake build_lib'
  sh 'cp lib/Shelley/build/libShelley.a dist/'
end

desc "build and copy everything into the gem directories for distribution as a gem"
task :build_for_release => [:build, :build_shelley, :copy_dist_to_gem]

desc "copies contents of dist dir to the frank-cucumber gem's frank-skeleton"
task :copy_dist_to_gem do
  sh "cp -r dist/* gem/frank-skeleton/"
end

