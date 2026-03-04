module 0xd5a478f8d5ac1ce431cebcb22b632c7f4847560e77d1ccba9ca97b36c553ad03::version {
    public fun next_version() : u64 {
        1 + 1
    }

    public fun pre_check_version(arg0: u64, arg1: u64) {
        assert!(arg0 == 1, arg1);
    }

    public fun this_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

