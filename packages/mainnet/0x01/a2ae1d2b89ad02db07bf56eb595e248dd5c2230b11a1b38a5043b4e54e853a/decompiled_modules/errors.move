module 0x1a2ae1d2b89ad02db07bf56eb595e248dd5c2230b11a1b38a5043b4e54e853a::errors {
    public fun E_BAD_BLOCK() : u64 {
        2
    }

    public fun E_BAD_SPLIT() : u64 {
        7
    }

    public fun E_LENGTH_MISMATCH() : u64 {
        8
    }

    public fun E_NOTHING_TO_CLAIM() : u64 {
        5
    }

    public fun E_NOT_OPEN() : u64 {
        0
    }

    public fun E_NOT_PAUSED() : u64 {
        10
    }

    public fun E_NOT_SETTLING() : u64 {
        1
    }

    public fun E_PAUSED() : u64 {
        9
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

