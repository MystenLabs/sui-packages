module 0xb5c5a83932dd1f8c54d26efb20377414073fb6c7fac3d099dc6b086e71fe00f3::version {
    public fun next_version() : u64 {
        1 + 1
    }

    public fun pre_check_version(arg0: u64, arg1: u64) {
        assert!(arg0 == 1, arg1);
    }

    public fun this_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

