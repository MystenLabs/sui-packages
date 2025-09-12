module 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants {
    public fun basis_point() : u64 {
        10000
    }

    public fun emergency_pause_version() : u64 {
        9223372036854775808
    }

    public fun fee_precision() : u64 {
        1000000000
    }

    public fun fee_precision_square() : u128 {
        1000000000000000000
    }

    public fun max_bin_per_group() : u8 {
        16
    }

    public fun max_bin_per_position() : u16 {
        1000
    }

    public fun max_fee_rate() : u64 {
        100000000
    }

    public fun max_partner_fee_rate() : u64 {
        1000000000
    }

    public fun max_protocol_fee_rate() : u64 {
        300000000
    }

    public fun max_reward_num() : u64 {
        5
    }

    public fun pool_default_uri() : vector<u8> {
        b"https://node1.irys.xyz/yKfgcB2yEJ1JZSeGm_eXAD0d34a3Wx7tcomS502ZKT8"
    }

    public fun reward_period() : u64 {
        604800
    }

    public fun reward_period_start_at() : u64 {
        1747627200
    }

    public fun scale_offset() : u8 {
        64
    }

    public fun u24_max() : u32 {
        16777215
    }

    // decompiled from Move bytecode v6
}

