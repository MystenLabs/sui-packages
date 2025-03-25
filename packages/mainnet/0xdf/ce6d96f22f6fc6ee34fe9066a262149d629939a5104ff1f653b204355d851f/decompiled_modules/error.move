module 0xdfce6d96f22f6fc6ee34fe9066a262149d629939a5104ff1f653b204355d851f::error {
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

