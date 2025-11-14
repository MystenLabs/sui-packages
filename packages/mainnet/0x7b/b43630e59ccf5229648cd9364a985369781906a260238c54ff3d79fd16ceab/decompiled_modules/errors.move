module 0x7bb43630e59ccf5229648cd9364a985369781906a260238c54ff3d79fd16ceab::errors {
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

