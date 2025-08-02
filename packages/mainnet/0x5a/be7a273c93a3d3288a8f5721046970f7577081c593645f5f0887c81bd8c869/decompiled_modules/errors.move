module 0x5abe7a273c93a3d3288a8f5721046970f7577081c593645f5f0887c81bd8c869::errors {
    public fun already_redeemed() : u64 {
        5
    }

    public fun already_refunded() : u64 {
        6
    }

    public fun builder_expired() : u64 {
        11
    }

    public fun builder_not_expired() : u64 {
        12
    }

    public fun contract_expired() : u64 {
        2
    }

    public fun contract_not_expired() : u64 {
        3
    }

    public fun insufficient_balance() : u64 {
        7
    }

    public fun invalid_secret() : u64 {
        1
    }

    public fun no_access() : u64 {
        8
    }

    public fun only_maker() : u64 {
        10
    }

    public fun only_taker() : u64 {
        9
    }

    // decompiled from Move bytecode v6
}

