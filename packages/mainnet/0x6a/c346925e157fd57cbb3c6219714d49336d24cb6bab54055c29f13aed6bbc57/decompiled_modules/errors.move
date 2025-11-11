module 0x6ac346925e157fd57cbb3c6219714d49336d24cb6bab54055c29f13aed6bbc57::errors {
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

