module 0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::pool_factory {
    struct WaveRegistry has key {
        id: 0x2::object::UID,
        active_waves: u8,
        wave_2_minted_at_ms: u64,
        wave_3_minted_at_ms: u64,
        total_pools: u64,
    }

    public fun active_waves(arg0: &WaveRegistry) : u8 {
        arg0.active_waves
    }

    public fun advance_wave_skeleton(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut WaveRegistry, arg2: u64) {
        assert!(arg1.active_waves < 3, 1);
        arg1.active_waves = arg1.active_waves + 1;
        if (arg1.active_waves == 2) {
            arg1.wave_2_minted_at_ms = arg2;
        } else if (arg1.active_waves == 3) {
            arg1.wave_3_minted_at_ms = arg2;
        };
    }

    public fun init_wave_registry(arg0: &0x9308ba5ea180f0192f85184e36507b0e3e0e17bd60f71df978221c09f21ecf35::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WaveRegistry{
            id                  : 0x2::object::new(arg1),
            active_waves        : 1,
            wave_2_minted_at_ms : 0,
            wave_3_minted_at_ms : 0,
            total_pools         : 0,
        };
        0x2::transfer::share_object<WaveRegistry>(v0);
    }

    public fun total_pools(arg0: &WaveRegistry) : u64 {
        arg0.total_pools
    }

    public fun wave_1_micro_max() : u64 {
        10000000
    }

    public fun wave_1_micro_min() : u64 {
        1000000
    }

    public fun wave_1_std_max() : u64 {
        100000000
    }

    public fun wave_1_std_min() : u64 {
        10000000
    }

    public fun wave_2_micro_max() : u64 {
        20000000
    }

    public fun wave_2_micro_min() : u64 {
        2000000
    }

    public fun wave_2_std_max() : u64 {
        200000000
    }

    public fun wave_2_std_min() : u64 {
        20000000
    }

    public fun wave_2_tvl_trigger() : u64 {
        1000000000000000
    }

    public fun wave_3_micro_max() : u64 {
        30000000
    }

    public fun wave_3_micro_min() : u64 {
        3000000
    }

    public fun wave_3_std_max() : u64 {
        300000000
    }

    public fun wave_3_std_min() : u64 {
        30000000
    }

    public fun wave_3_tvl_trigger() : u64 {
        2000000000000000
    }

    public fun wave_mint_bounty() : u64 {
        100000000
    }

    // decompiled from Move bytecode v7
}

