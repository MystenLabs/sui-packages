module 0xa6244236d5d19ba42f479a1444e6c24ec0ede1d2fe8f9aed562abf331b9491f2::registry_rules {
    public fun next_revision(arg0: u64) : u64 {
        assert!(arg0 < 18446744073709551615, 3225);
        arg0 + 1
    }

    public fun revision_matches(arg0: u64, arg1: u64) : bool {
        arg0 == arg1
    }

    public fun same_parent(arg0: u64, arg1: u64) : bool {
        arg0 == arg1
    }

    public fun valid_scopes(arg0: bool, arg1: bool, arg2: bool) : bool {
        (arg0 || arg1) && arg1 == arg2
    }

    public fun within_size(arg0: u64, arg1: u64) : bool {
        arg0 <= arg1
    }

    // decompiled from Move bytecode v7
}

