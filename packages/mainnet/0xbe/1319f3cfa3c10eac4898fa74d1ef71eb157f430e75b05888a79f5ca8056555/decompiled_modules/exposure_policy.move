module 0xbe1319f3cfa3c10eac4898fa74d1ef71eb157f430e75b05888a79f5ca8056555::exposure_policy {
    public fun closing_side() : bool {
        true
    }

    public fun entry_notional(arg0: u64) : u64 {
        arg0
    }

    public fun opening_side() : bool {
        false
    }

    // decompiled from Move bytecode v7
}

