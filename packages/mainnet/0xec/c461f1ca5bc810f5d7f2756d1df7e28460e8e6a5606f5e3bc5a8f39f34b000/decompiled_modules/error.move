module 0xf23575bda553a38973514e828c3d5f735d4628bb2c945336b319344d0092b094::error {
    public fun balances_not_empty() : u64 {
        3
    }

    public fun insufficient_balance() : u64 {
        2
    }

    public fun invalid_coin_type() : u64 {
        1
    }

    public fun not_whitelisted() : u64 {
        0
    }

    public fun package_not_whitelisted() : u64 {
        6
    }

    public fun slippage_exceeded() : u64 {
        8
    }

    // decompiled from Move bytecode v6
}

