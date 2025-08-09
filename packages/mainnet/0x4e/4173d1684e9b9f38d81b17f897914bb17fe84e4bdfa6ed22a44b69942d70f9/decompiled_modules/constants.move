module 0x4e4173d1684e9b9f38d81b17f897914bb17fe84e4bdfa6ed22a44b69942d70f9::constants {
    public fun default_min_tick_range_factor() : u32 {
        1
    }

    public fun fee_rate_denominator() : u64 {
        1000000
    }

    public fun is_pause_df_key() : vector<u8> {
        b"pause"
    }

    public fun max_protocol_fee_percent() : u64 {
        75
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

    public fun position_display_description() : vector<u8> {
        b"This object represents your LP position in a Mmt CLMM Pool. Do not burn this object since this is the only way you can redeem your funds from the liquidity pool and claim rewards emissions."
    }

    public fun position_display_image_url() : vector<u8> {
        b"https://orange-casual-flamingo-897.mypinata.cloud/ipfs/bafkreigzh2muit47iinsvmfj4bhju5vtnxdqtvrezbew6sopzwcbu5vjka"
    }

    public fun position_display_name() : vector<u8> {
        b"Mmt CLMM LP position"
    }

    public fun protocol_fee_share_denominator() : u64 {
        1000000
    }

    public fun protocol_flash_loan_fee_share() : u64 {
        200000
    }

    public fun protocol_swap_fee_share() : u64 {
        200000
    }

    public fun q64() : u128 {
        18446744073709551616
    }

    public fun rewarder_admin_df_key() : u64 {
        0
    }

    // decompiled from Move bytecode v6
}

