module 0xfee50aed453ae56450084eafaa9eedbd816c45bc98f063e873ee51f534f40779::version {
    public fun next_version() : u64 {
        2 + 1
    }

    public fun pre_check_version(arg0: u64, arg1: u64) {
        assert!(arg0 == 2, arg1);
    }

    public fun this_version() : u64 {
        2
    }

    // decompiled from Move bytecode v7
}

