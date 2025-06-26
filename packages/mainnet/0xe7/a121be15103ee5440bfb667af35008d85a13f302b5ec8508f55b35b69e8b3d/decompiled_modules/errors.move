module 0xe7a121be15103ee5440bfb667af35008d85a13f302b5ec8508f55b35b69e8b3d::errors {
    public fun err_invalid_version() : u64 {
        abort 2
    }

    public fun err_version_deprecated() : u64 {
        abort 1
    }

    // decompiled from Move bytecode v6
}

