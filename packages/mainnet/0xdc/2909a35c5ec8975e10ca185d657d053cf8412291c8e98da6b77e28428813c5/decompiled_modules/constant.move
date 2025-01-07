module 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::constant {
    public fun BPS() : u64 {
        1000000000
    }

    public fun EXPIRED_MS() : u64 {
        86400000
    }

    public fun FEE_OWNER_CUT() : u32 {
        10
    }

    public fun OVER_PERCENT() : u64 {
        5
    }

    public fun PENDING_WITHDRAW_MS() : u64 {
        3600000
    }

    public fun SLIPPAGED_PERCENT() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

