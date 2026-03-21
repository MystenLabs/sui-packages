module 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::apy_oracle {
    public fun begin_oracle_update(arg0: &mut 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::OracleState, arg1: &0x2::clock::Clock) {
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::begin_update(arg0, arg1);
    }

    fun cap(arg0: u64) : u64 {
        if (arg0 > 10000) {
            10000
        } else {
            arg0
        }
    }

    public fun compute_reward_apy_bps(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = if (v0 >= arg1) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg0 == 0
        };
        if (v1) {
            return 0
        };
        let v2 = (arg0 as u128) * (arg3 as u128) / 1000000000 * 31557600000 * 10000 / ((arg1 - v0) as u128) * (arg2 as u128);
        if (v2 > (10000 as u128)) {
            10000
        } else {
            (v2 as u64)
        }
    }

    public fun finish_oracle_update(arg0: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::OracleState, arg1: &0x2::clock::Clock) {
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::finish_update(arg0, arg1);
    }

    public fun get_total_apy_bps(arg0: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::OracleState, arg1: &0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::StrategyRegistry, arg2: u8) : u64 {
        let (v0, v1, v2) = 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::get_rate(arg0, arg2);
        let (v3, v4, v5) = 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::get_prev_rate(arg0, arg2);
        let v6 = if (v1 == 0) {
            true
        } else if (v4 == 0) {
            true
        } else if (v0 == 0) {
            true
        } else if (v3 == 0) {
            true
        } else {
            v2 <= v5
        };
        if (v6) {
            return 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::get_reward_apy_bps(arg1, arg2)
        };
        let v7 = (v0 as u128) * (v4 as u128);
        let v8 = (v3 as u128) * (v1 as u128);
        let v9 = if (v7 > v8 && v8 > 0) {
            let v10 = v8 * ((v2 - v5) as u128);
            if (v10 == 0) {
                0
            } else {
                (((v7 - v8) * 31557600000 * 10000 / v10) as u64)
            }
        } else {
            0
        };
        v9 + 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::get_reward_apy_bps(arg1, arg2)
    }

    public fun push_base_rate(arg0: &mut 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::StrategyRegistry, arg1: &mut 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::OracleState, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg4 > 0, 503);
        assert!((arg3 as u128) * 1000000000 / (arg4 as u128) >= 500000000, 503);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::update_rate(arg0, arg2, arg3, arg4, arg5);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::push_snapshot(arg1, arg2, arg3, arg4, arg5);
    }

    public fun push_reward_apys(arg0: &mut 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::StrategyRegistry, arg1: &mut 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::OracleState, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = cap(arg2);
        let v1 = cap(arg3);
        let v2 = cap(arg4);
        let v3 = cap(arg5);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::update_reward_apy(arg0, 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::strategy_navi(), v0, arg6);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::update_reward_apy(arg0, 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::strategy_suilend(), v1, arg6);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::update_reward_apy(arg0, 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::strategy_bluefin(), v2, arg6);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::update_reward_apy(arg0, 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::strategy_alphafi(), v3, arg6);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::update_reward_bps(arg1, 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::strategy_navi(), v0);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::update_reward_bps(arg1, 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::strategy_suilend(), v1);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::update_reward_bps(arg1, 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::strategy_bluefin(), v2);
        0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::oracle::update_reward_bps(arg1, 0x6ff4dc407e25a940b345dceca99fc50e8ba27d4de5eec5050100b8036bb0eced::strategy::strategy_alphafi(), v3);
    }

    // decompiled from Move bytecode v6
}

