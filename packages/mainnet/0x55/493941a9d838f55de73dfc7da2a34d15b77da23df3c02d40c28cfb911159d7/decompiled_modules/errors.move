module 0x55493941a9d838f55de73dfc7da2a34d15b77da23df3c02d40c28cfb911159d7::errors {
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

