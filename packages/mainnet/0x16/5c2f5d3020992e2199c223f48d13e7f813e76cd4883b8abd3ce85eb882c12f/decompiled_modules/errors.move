module 0x165c2f5d3020992e2199c223f48d13e7f813e76cd4883b8abd3ce85eb882c12f::errors {
    public fun insufficient_funds() : u64 {
        1004
    }

    public fun unauthorized() : u64 {
        1003
    }

    public fun version_mismatch() : u64 {
        1001
    }

    public fun zero_coin_amount() : u64 {
        1002
    }

    // decompiled from Move bytecode v6
}

