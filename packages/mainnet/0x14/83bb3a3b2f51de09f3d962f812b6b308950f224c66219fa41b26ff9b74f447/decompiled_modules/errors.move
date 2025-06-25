module 0x1483bb3a3b2f51de09f3d962f812b6b308950f224c66219fa41b26ff9b74f447::errors {
    public fun err_invalid_version() : u64 {
        abort 2
    }

    public fun err_version_deprecated() : u64 {
        abort 1
    }

    // decompiled from Move bytecode v6
}

