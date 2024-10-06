package(
    default_visibility = ["//visibility:public"],
)

# https://bazel.build/reference/be/c-cpp#cc_binary
cc_binary(
    name = "hello_world",
    srcs = [
        "hello_world.cc",
    ],
    deps = [
        "@libtorch//:torch_cpu",
    ],
)
