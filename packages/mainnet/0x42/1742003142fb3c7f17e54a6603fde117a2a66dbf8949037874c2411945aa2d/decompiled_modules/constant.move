module 0x421742003142fb3c7f17e54a6603fde117a2a66dbf8949037874c2411945aa2d::constant {
    public fun BPS() : u64 {
        1000000000
    }

    public fun BPS_FOR_COST() : u32 {
        100
    }

    public fun EXPIRED_MS() : u64 {
        86400000
    }

    public fun EXPIRED_MS_12H() : u64 {
        43200000
    }

    public fun EXPIRED_MS_48H() : u64 {
        172800000
    }

    public fun FEE_CREATOR_CUT() : u32 {
        1
    }

    public fun FEE_OWNER_CUT() : u32 {
        9
    }

    public fun OVER_PERCENT() : u64 {
        5
    }

    public fun PENDING_WITHDRAW_MS() : u64 {
        3600000
    }

    public fun POOL_MAX_USER() : u32 {
        100
    }

    public fun REQUIRED_COST_IN_USD_BPS() : u32 {
        100
    }

    public fun SLIPPAGED_PERCENT() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

