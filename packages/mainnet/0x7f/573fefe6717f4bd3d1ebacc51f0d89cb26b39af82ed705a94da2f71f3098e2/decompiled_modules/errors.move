module 0x7f573fefe6717f4bd3d1ebacc51f0d89cb26b39af82ed705a94da2f71f3098e2::errors {
    public fun E_BAD_BLOCK() : u64 {
        2
    }

    public fun E_NOTHING_TO_CLAIM() : u64 {
        5
    }

    public fun E_NOT_OPEN() : u64 {
        0
    }

    public fun E_NOT_SETTLING() : u64 {
        1
    }

    public fun E_STILL_OPEN() : u64 {
        3
    }

    public fun E_SUPPLY_CAP() : u64 {
        4
    }

    public fun E_UNAUTH() : u64 {
        6
    }

    // decompiled from Move bytecode v6
}

