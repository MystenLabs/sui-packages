module 0x8adb28013005cdc4f8d72217eece3cd71af3e4fd88e602077afeab87b82fd439::cetus_clmm_oracle {
    public(friend) fun assert_pool_spot<T0, T1>(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::RiskParams) {
        assert_spot(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2);
    }

    public(friend) fun assert_spot(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u128, arg2: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::RiskParams) {
        assert_sqrt_price(arg1);
        let (v0, v1) = rate(arg0);
        let (v2, v3) = spot_bounds_x64(v0, v1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::clmm_price_deviation_bps(arg2));
        let v4 = (arg1 as u256) * (arg1 as u256);
        assert!(v4 / 18446744073709551616 >= v2 && div_up(v4, 18446744073709551616) <= v3, 240);
    }

    public(friend) fun assert_sqrt_price(arg0: u128) {
        assert!(arg0 >= 4295048016 && arg0 <= 79226673515401279992447579055, 228);
    }

    fun composition_value_at_rate(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : u128 {
        if (arg4) {
            (arg3 as u128) + (quote_at_rate(arg2, arg0, arg1, false) as u128)
        } else {
            (arg2 as u128) + (quote_at_rate(arg3, arg0, arg1, true) as u128)
        }
    }

    public(friend) fun composition_value_hawal(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64, arg2: u64) : u128 {
        let (v0, v1) = rate(arg0);
        composition_value_at_rate(v0, v1, arg1, arg2, false)
    }

    public(friend) fun composition_value_wal(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64, arg2: u64) : u128 {
        let (v0, v1) = rate(arg0);
        composition_value_at_rate(v0, v1, arg1, arg2, true)
    }

    fun discounted(arg0: u64, arg1: u64) : u64 {
        discounted_at_bps(arg0, arg1)
    }

    fun discounted_at_bps(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 < 10000, 239);
        if (arg0 == 0) {
            abort 237
        };
        let v0 = (arg0 as u256) * ((10000 - arg1) as u256) / (10000 as u256);
        let v1 = if (v0 == 0) {
            1
        } else {
            v0
        };
        narrow(v1)
    }

    fun div_up(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 233);
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    public(friend) fun hawal_to_wal(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64) : u64 {
        let (v0, v1) = rate(arg0);
        quote_at_rate(arg1, v0, v1, false)
    }

    public(friend) fun hawal_to_wal_sqrt_limit(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::RiskParams) : u128 {
        let (v0, v1) = rate(arg0);
        let (v2, _) = spot_bounds_x64(v0, v1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::clmm_price_deviation_bps(arg1));
        let v4 = sqrt_ceil(v2 * 18446744073709551616);
        assert!(v4 >= (4295048016 as u256) && v4 <= (79226673515401279992447579055 as u256), 228);
        (v4 as u128)
    }

    fun hawal_to_wal_up(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let (v0, v1) = rate(arg0);
        narrow(div_up((arg1 as u256) * (v0 as u256), (v1 as u256)))
    }

    public(friend) fun min_hawal_to_wal(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64, arg2: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::RiskParams) : u64 {
        assert!(hawal_to_wal_up(arg0, arg1) <= 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::max_swap_wal_amount(arg2), 241);
        discounted(hawal_to_wal(arg0, arg1), 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::swap_deviation_bps(arg2))
    }

    public(friend) fun min_wal_to_hawal(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64, arg2: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::RiskParams) : u64 {
        assert!(arg1 <= 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::max_swap_wal_amount(arg2), 241);
        discounted(wal_to_hawal(arg0, arg1), 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::swap_deviation_bps(arg2))
    }

    fun narrow(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 236);
        (arg0 as u64)
    }

    fun quote_at_rate(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 233);
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg3) {
            (arg0 as u256) * (arg2 as u256) / (arg1 as u256)
        } else {
            (arg0 as u256) * (arg1 as u256) / (arg2 as u256)
        };
        narrow(v0)
    }

    public(friend) fun rate(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking) : (u64, u64) {
        let v0 = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_total_wal(arg0);
        let v1 = 0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::get_hawal_supply(arg0);
        assert!(v0 > 0 && v1 > 0, 233);
        (v0, v1)
    }

    public(friend) fun spot_bounds_x64(arg0: u64, arg1: u64, arg2: u64) : (u256, u256) {
        assert!(arg0 > 0 && arg1 > 0, 233);
        assert!(arg2 <= 2000, 239);
        let v0 = (arg0 as u256) * 18446744073709551616;
        let v1 = (arg1 as u256) * (10000 as u256);
        let v2 = v0 * ((10000 - arg2) as u256) / v1;
        let v3 = div_up(v0 * ((10000 + arg2) as u256), v1);
        assert!(v2 > 0 && v3 >= v2, 233);
        (v2, v3)
    }

    fun sqrt_ceil(arg0: u256) : u256 {
        let v0 = sqrt_floor(arg0);
        if (v0 * v0 == arg0) {
            v0
        } else {
            v0 + 1
        }
    }

    fun sqrt_floor(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = arg0;
        let v1 = 1;
        let v2 = v1;
        if (arg0 >= 340282366920938463463374607431768211456) {
            v0 = arg0 >> 128;
            v2 = v1 << 64;
        };
        if (v0 >= 18446744073709551616) {
            v0 = v0 >> 64;
            v2 = v2 << 32;
        };
        if (v0 >= 4294967296) {
            v0 = v0 >> 32;
            v2 = v2 << 16;
        };
        if (v0 >= 65536) {
            v0 = v0 >> 16;
            v2 = v2 << 8;
        };
        if (v0 >= 256) {
            v0 = v0 >> 8;
            v2 = v2 << 4;
        };
        if (v0 >= 16) {
            v0 = v0 >> 4;
            v2 = v2 << 2;
        };
        if (v0 >= 8) {
            v2 = v2 << 1;
        };
        let v3 = 0;
        while (v3 < 7) {
            let v4 = v2 + arg0 / v2;
            v2 = v4 >> 1;
            v3 = v3 + 1;
        };
        let v5 = arg0 / v2;
        if (v2 < v5) {
            v2
        } else {
            v5
        }
    }

    public(friend) fun wal_to_hawal(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: u64) : u64 {
        let (v0, v1) = rate(arg0);
        quote_at_rate(arg1, v0, v1, true)
    }

    public(friend) fun wal_to_hawal_sqrt_limit(arg0: &0x8b4d553839b219c3fd47608a0cc3d5fcc572cb25d41b7df3833208586a8d2470::walstaking::Staking, arg1: &0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::RiskParams) : u128 {
        let (v0, v1) = rate(arg0);
        let (_, v3) = spot_bounds_x64(v0, v1, 0x3777fbddf314316bb4b3618538255b09eff5460de094f5084f21edbeacbec9a8::vault_cetus_clmm_params::clmm_price_deviation_bps(arg1));
        let v4 = sqrt_floor(v3 * 18446744073709551616);
        assert!(v4 >= (4295048016 as u256) && v4 <= (79226673515401279992447579055 as u256), 228);
        (v4 as u128)
    }

    // decompiled from Move bytecode v7
}

