module 0xd13044b1e42bc8962270f031c8408d679855d97deba3cb047834a185bb7145e2::errors {
    public fun E_BAD_BLOCK() : u64 {
        2
    }

    public fun E_BAD_SPLIT() : u64 {
        7
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

