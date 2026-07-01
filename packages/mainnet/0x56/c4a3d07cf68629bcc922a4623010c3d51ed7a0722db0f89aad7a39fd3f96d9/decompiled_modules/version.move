module 0x56c4a3d07cf68629bcc922a4623010c3d51ed7a0722db0f89aad7a39fd3f96d9::version {
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

