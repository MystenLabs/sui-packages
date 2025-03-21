module 0x5615929b8d7911e3dcddaffd20ffb1d0e02ad29cbf088185e484c1f12bab5d2b::error {
    public fun exceed_daily_refuel_limit() : u64 {
        abort 2
    }

    public fun exceed_max_gas_amount() : u64 {
        abort 3
    }

    public fun gas_object_not_whitelisted() : u64 {
        abort 1
    }

    public fun gas_owner_mismatch() : u64 {
        abort 5
    }

    public fun insufficient_balance() : u64 {
        abort 4
    }

    // decompiled from Move bytecode v6
}

