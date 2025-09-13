module 0x8d9ea9aa165f57b65b46174132d3db456ac05f083f76600f25de2a0b81f3eff7::executor_type {
    struct DstConfig has copy, drop, store {
        lz_receive_base_gas: u64,
        lz_compose_base_gas: u64,
        multiplier_bps: u16,
        floor_margin_usd: u128,
        native_cap: u128,
    }

    public fun create_dst_config(arg0: u64, arg1: u64, arg2: u16, arg3: u128, arg4: u128) : DstConfig {
        DstConfig{
            lz_receive_base_gas : arg0,
            lz_compose_base_gas : arg1,
            multiplier_bps      : arg2,
            floor_margin_usd    : arg3,
            native_cap          : arg4,
        }
    }

    public fun dst_config_floor_margin_usd(arg0: &DstConfig) : u128 {
        arg0.floor_margin_usd
    }

    public fun dst_config_lz_compose_base_gas(arg0: &DstConfig) : u64 {
        arg0.lz_compose_base_gas
    }

    public fun dst_config_lz_receive_base_gas(arg0: &DstConfig) : u64 {
        arg0.lz_receive_base_gas
    }

    public fun dst_config_multiplier_bps(arg0: &DstConfig) : u16 {
        arg0.multiplier_bps
    }

    public fun dst_config_native_cap(arg0: &DstConfig) : u128 {
        arg0.native_cap
    }

    // decompiled from Move bytecode v6
}

