module 0xac928205d73d8a9de7d8aba63d9df263abd429855f71a7a9cc02d732102d985a::constants {
    public fun fee_rate_denominator() : u64 {
        1000000
    }

    public fun max_u128() : u128 {
        340282366920938463463374607431768211455
    }

    public fun max_u16() : u16 {
        65535
    }

    public fun max_u256() : u256 {
        115792089237316195423570985008687907853269984665640564039457584007913129639935
    }

    public fun max_u32() : u32 {
        4294967295
    }

    public fun max_u64() : u64 {
        18446744073709551615
    }

    public fun max_u8() : u8 {
        255
    }

    public fun pool_admin_df_key() : u64 {
        1
    }

    public fun pool_trading_enabled_df_key() : vector<u8> {
        b"trading_enabled"
    }

    public fun protocol_fee_share_denominator() : u64 {
        1000000
    }

    public fun q64() : u128 {
        18446744073709551616
    }

    public fun rewarder_admin_df_key() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

