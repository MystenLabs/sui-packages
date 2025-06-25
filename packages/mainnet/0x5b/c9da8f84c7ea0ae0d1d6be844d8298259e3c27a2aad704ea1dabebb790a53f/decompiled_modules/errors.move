module 0x5bc9da8f84c7ea0ae0d1d6be844d8298259e3c27a2aad704ea1dabebb790a53f::errors {
    public fun err_invalid_version() : u64 {
        abort 2
    }

    public fun err_version_deprecated() : u64 {
        abort 1
    }

    // decompiled from Move bytecode v6
}

