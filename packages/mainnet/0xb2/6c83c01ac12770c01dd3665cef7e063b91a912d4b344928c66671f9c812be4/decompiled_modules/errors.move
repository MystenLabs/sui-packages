module 0xb26c83c01ac12770c01dd3665cef7e063b91a912d4b344928c66671f9c812be4::errors {
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

