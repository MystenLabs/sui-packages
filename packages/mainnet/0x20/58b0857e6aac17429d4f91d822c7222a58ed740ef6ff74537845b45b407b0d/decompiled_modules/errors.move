module 0x2058b0857e6aac17429d4f91d822c7222a58ed740ef6ff74537845b45b407b0d::errors {
    public fun already_claimed() : u64 {
        4
    }

    public fun insufficient_lots() : u64 {
        2
    }

    public fun invalid_params() : u64 {
        5
    }

    public fun mint_locked() : u64 {
        6
    }

    public fun no_lots() : u64 {
        0
    }

    public fun wrong_round() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

