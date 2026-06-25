module 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::gap_stress_module {
    struct OrderBlockedByNMax has copy, drop {
        symbol: vector<u8>,
        post_trade_net_oi: u64,
        effective_n_max: u64,
        is_long: bool,
    }

    struct MarginEscalated has copy, drop {
        symbol: vector<u8>,
        utilization_bps: u64,
        margin_multiplier_bps: u64,
    }

    public fun assert_order_valid(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::InsuranceFundState, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg3: vector<u8>, arg4: u64, arg5: bool) {
        let (v0, v1, v2, _) = validate_order(arg0, arg1, arg2, arg3, arg4, arg5);
        if (!v0) {
            let v4 = OrderBlockedByNMax{
                symbol            : arg3,
                post_trade_net_oi : v1,
                effective_n_max   : v2,
                is_long           : arg5,
            };
            0x2::event::emit<OrderBlockedByNMax>(v4);
            abort 0
        };
    }

    public fun compute_effective_n_max(arg0: u64, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::InsuranceFundState, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg3: vector<u8>) : u64 {
        if (0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::breaker_exists(arg2, arg3) && 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::is_n_max_halved(arg2, arg3)) {
            0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::compute_effective_n_max(arg1, arg0) / 2
        } else {
            0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::compute_effective_n_max(arg1, arg0)
        }
    }

    public fun compute_escalation_multiplier(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 10000
        };
        let v0 = (((arg0 as u128) * (10000 as u128) / (arg1 as u128)) as u64);
        if (v0 >= 9500) {
            20000
        } else if (v0 >= 8500) {
            15000
        } else if (v0 >= 7000) {
            12000
        } else {
            10000
        }
    }

    public fun compute_n_max(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1);
        (((500 as u128) * (arg0 as u128) / (arg1 as u128) * (10000 as u128)) as u64)
    }

    public fun get_effective_n_max_for_market(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::InsuranceFundState, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg3: vector<u8>) : u64 {
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::assert_initialized(arg1);
        compute_effective_n_max(compute_n_max(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::balance(arg1), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_gap_assumption_bps(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg0, arg3))), arg1, arg2, arg3)
    }

    public fun get_n_max_utilization_bps(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::InsuranceFundState, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg3: vector<u8>) : u64 {
        let v0 = get_effective_n_max_for_market(arg0, arg1, arg2, arg3);
        if (v0 == 0) {
            return 0
        };
        (((get_net_oi(arg0, arg3) as u128) * (10000 as u128) / (v0 as u128)) as u64)
    }

    public fun get_net_oi(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: vector<u8>) : u64 {
        let v0 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg0, arg1);
        let v1 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_long_oi(v0);
        let v2 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_short_oi(v0);
        if (v1 >= v2) {
            v1 - v2
        } else {
            v2 - v1
        }
    }

    public fun get_order_margin_multiplier(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::InsuranceFundState, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg3: vector<u8>, arg4: u64, arg5: bool) : u64 {
        let (_, v1, v2, v3) = validate_order(arg0, arg1, arg2, arg3, arg4, arg5);
        if (v3 > 10000) {
            let v4 = if (v2 > 0) {
                (((v1 as u128) * (10000 as u128) / (v2 as u128)) as u64)
            } else {
                0
            };
            let v5 = MarginEscalated{
                symbol                : arg3,
                utilization_bps       : v4,
                margin_multiplier_bps : v3,
            };
            0x2::event::emit<MarginEscalated>(v5);
        };
        v3
    }

    public fun validate_order(arg0: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::MarketRegistry, arg1: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::InsuranceFundState, arg2: &0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::circuit_breaker::BreakerRegistry, arg3: vector<u8>, arg4: u64, arg5: bool) : (bool, u64, u64, u64) {
        0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::assert_initialized(arg1);
        let v0 = 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::borrow_market(arg0, arg3);
        let v1 = compute_effective_n_max(compute_n_max(0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::insurance_fund::balance(arg1), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_gap_assumption_bps(v0)), arg1, arg2, arg3);
        let (v2, v3) = if (arg5) {
            (0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_long_oi(v0) + arg4, 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_short_oi(v0))
        } else {
            (0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_long_oi(v0), 0xacb076e99b227bdb98685ee3537b9e89e79bff6cdaf8318e4afefdad7ba69c45::market_factory::market_short_oi(v0) + arg4)
        };
        let v4 = if (v2 >= v3) {
            v2 - v3
        } else {
            v3 - v2
        };
        let v5 = v2 >= v3 && arg5 || !arg5;
        let v6 = v4 > v1 && v5 && false || true;
        (v6, v4, v1, compute_escalation_multiplier(v4, v1))
    }

    // decompiled from Move bytecode v7
}

