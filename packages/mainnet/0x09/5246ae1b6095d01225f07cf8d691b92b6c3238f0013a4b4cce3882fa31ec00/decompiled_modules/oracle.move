module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::oracle {
    struct PriceSnapshot has copy, drop, store {
        ts_ms: u64,
        price: u64,
    }

    struct OracleState has drop, store {
        snapshots: vector<PriceSnapshot>,
        snapshot_count: u64,
        last_snapshot_ts_ms: u64,
        current_twap: u64,
        ewma_variance_bps2: u128,
        current_volatility_bps: u64,
        current_confidence_bps: u64,
        current_effective_volatility_bps: u64,
        current_regime: 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::Regime,
    }

    public fun calm_exit_vol_bps() : u64 {
        120
    }

    public fun calm_vol_bps() : u64 {
        100
    }

    public fun compute_effective_volatility_bps(arg0: u64, arg1: u64) : u64 {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::safe_add(arg0, arg1)
    }

    public fun compute_regime(arg0: u64, arg1: u64) : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::Regime {
        if (arg0 < 12) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_normal()
        } else if (arg1 < 100) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_calm()
        } else if (arg1 < 300) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_normal()
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_storm()
        }
    }

    public fun compute_regime_with_hysteresis(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::Regime, arg1: u64, arg2: u64) : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::Regime {
        if (arg1 < 12) {
            return 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_normal()
        };
        if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::is_regime_calm(arg0)) {
            if (arg2 < 120) {
                0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_calm()
            } else if (arg2 >= 300) {
                0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_storm()
            } else {
                0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_normal()
            }
        } else if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::is_regime_storm(arg0)) {
            if (arg2 >= 250) {
                0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_storm()
            } else if (arg2 < 100) {
                0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_calm()
            } else {
                0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_normal()
            }
        } else if (arg2 < 100) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_calm()
        } else if (arg2 >= 300) {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_storm()
        } else {
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_normal()
        }
    }

    public fun current_confidence_bps(arg0: &OracleState) : u64 {
        arg0.current_confidence_bps
    }

    public fun current_effective_volatility_bps(arg0: &OracleState) : u64 {
        arg0.current_effective_volatility_bps
    }

    public fun current_regime(arg0: &OracleState) : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::Regime {
        arg0.current_regime
    }

    public fun current_twap(arg0: &OracleState) : u64 {
        arg0.current_twap
    }

    public fun current_volatility_bps(arg0: &OracleState) : u64 {
        arg0.current_volatility_bps
    }

    public fun ewma_lambda_bps() : u64 {
        9400
    }

    public fun last_snapshot_ts_ms(arg0: &OracleState) : u64 {
        arg0.last_snapshot_ts_ms
    }

    public fun max_snapshots() : u64 {
        48
    }

    public fun min_samples() : u64 {
        12
    }

    public fun new() : OracleState {
        OracleState{
            snapshots                        : 0x1::vector::empty<PriceSnapshot>(),
            snapshot_count                   : 0,
            last_snapshot_ts_ms              : 0,
            current_twap                     : 0,
            ewma_variance_bps2               : 0,
            current_volatility_bps           : 0,
            current_confidence_bps           : 0,
            current_effective_volatility_bps : 0,
            current_regime                   : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_normal(),
        }
    }

    public fun price_precision() : u64 {
        1000000000
    }

    fun recompute(arg0: &mut OracleState) {
        if (arg0.snapshot_count == 0) {
            arg0.current_twap = 0;
            arg0.ewma_variance_bps2 = 0;
            arg0.current_volatility_bps = 0;
            arg0.current_effective_volatility_bps = compute_effective_volatility_bps(0, arg0.current_confidence_bps);
            arg0.current_regime = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::regime_normal();
            return
        };
        let v0 = arg0.snapshot_count;
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + (0x1::vector::borrow<PriceSnapshot>(&arg0.snapshots, v2).price as u128);
            v2 = v2 + 1;
        };
        arg0.current_twap = ((v1 / (v0 as u128)) as u64);
        if (v0 < 2) {
            arg0.ewma_variance_bps2 = 0;
            arg0.current_volatility_bps = 0;
            arg0.current_effective_volatility_bps = compute_effective_volatility_bps(0, arg0.current_confidence_bps);
            arg0.current_regime = compute_regime_with_hysteresis(&arg0.current_regime, v0, arg0.current_effective_volatility_bps);
            return
        };
        let v3 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::math::sqrt_u128(arg0.ewma_variance_bps2);
        arg0.current_volatility_bps = v3;
        arg0.current_effective_volatility_bps = compute_effective_volatility_bps(v3, arg0.current_confidence_bps);
        arg0.current_regime = compute_regime_with_hysteresis(&arg0.current_regime, v0, arg0.current_effective_volatility_bps);
    }

    public fun record_snapshot_with_confidence_with_ts(arg0: &mut OracleState, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        assert!(arg1 > 0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_zero_amount());
        if (arg0.last_snapshot_ts_ms != 0 && arg3 < arg0.last_snapshot_ts_ms + arg4) {
            return false
        };
        if (arg0.snapshot_count == 0) {
            let v0 = PriceSnapshot{
                ts_ms : arg3,
                price : arg1,
            };
            0x1::vector::push_back<PriceSnapshot>(&mut arg0.snapshots, v0);
            arg0.snapshot_count = 1;
            arg0.last_snapshot_ts_ms = arg3;
            arg0.current_twap = arg1;
            arg0.ewma_variance_bps2 = 0;
            arg0.current_volatility_bps = 0;
            arg0.current_confidence_bps = arg2;
            arg0.current_effective_volatility_bps = compute_effective_volatility_bps(0, arg2);
            arg0.current_regime = compute_regime_with_hysteresis(&arg0.current_regime, 1, arg0.current_effective_volatility_bps);
            return true
        };
        let v1 = 0x1::vector::borrow<PriceSnapshot>(&arg0.snapshots, arg0.snapshot_count - 1).price;
        let v2 = if (arg1 >= v1) {
            arg1 - v1
        } else {
            v1 - arg1
        };
        let v3 = ((v2 as u128) * 10000 + (v1 as u128) / 2) / (v1 as u128);
        if (arg0.snapshot_count == 1) {
            arg0.ewma_variance_bps2 = v3 * v3;
        } else {
            arg0.ewma_variance_bps2 = (arg0.ewma_variance_bps2 * (9400 as u128) + v3 * v3 * ((10000 - 9400) as u128) + 5000) / 10000;
        };
        if (arg0.snapshot_count < 48) {
            let v4 = PriceSnapshot{
                ts_ms : arg3,
                price : arg1,
            };
            0x1::vector::push_back<PriceSnapshot>(&mut arg0.snapshots, v4);
            arg0.snapshot_count = arg0.snapshot_count + 1;
        } else {
            0x1::vector::remove<PriceSnapshot>(&mut arg0.snapshots, 0);
            let v5 = PriceSnapshot{
                ts_ms : arg3,
                price : arg1,
            };
            0x1::vector::push_back<PriceSnapshot>(&mut arg0.snapshots, v5);
            arg0.snapshot_count = 48;
        };
        arg0.last_snapshot_ts_ms = arg3;
        arg0.current_confidence_bps = arg2;
        recompute(arg0);
        true
    }

    public fun record_snapshot_with_ts(arg0: &mut OracleState, arg1: u64, arg2: u64, arg3: u64) : bool {
        record_snapshot_with_confidence_with_ts(arg0, arg1, 0, arg2, arg3)
    }

    public fun snapshot_count(arg0: &OracleState) : u64 {
        arg0.snapshot_count
    }

    public fun snapshots_len(arg0: &OracleState) : u64 {
        0x1::vector::length<PriceSnapshot>(&arg0.snapshots)
    }

    public fun storm_exit_vol_bps() : u64 {
        250
    }

    public fun storm_vol_bps() : u64 {
        300
    }

    // decompiled from Move bytecode v6
}

