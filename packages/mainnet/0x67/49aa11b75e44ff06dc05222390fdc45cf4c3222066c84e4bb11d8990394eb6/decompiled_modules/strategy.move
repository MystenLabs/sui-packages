module 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::strategy {
    struct PredictPosition has drop, store {
        oracle_id: 0x2::object::ID,
        strike_low: u64,
        strike_high: u64,
        amount_deployed: u64,
        expiry_ms: u64,
        position_type: u8,
        settled: bool,
    }

    struct StrategyState has key {
        id: 0x2::object::UID,
        total_deployed: u64,
        total_in_predict_range: u64,
        total_in_plp: u64,
        total_settled: u64,
        total_pnl: u64,
        atm_range_bps: u64,
        sigma_range_bps: u64,
        atm_ratio_bps: u64,
        sigma_ratio_bps: u64,
        plp_ratio_bps: u64,
        paused: bool,
        position_count: u64,
        settled_count: u64,
    }

    struct StrategyCreated has copy, drop {
        strategy_id: 0x2::object::ID,
    }

    struct PositionOpened has copy, drop {
        strategy_id: 0x2::object::ID,
        position_type: u8,
        amount: u64,
        strike_low: u64,
        strike_high: u64,
    }

    struct PositionSettled has copy, drop {
        strategy_id: 0x2::object::ID,
        amount_deployed: u64,
        amount_received: u64,
        profit: bool,
        pnl: u64,
    }

    struct FundsDeployed has copy, drop {
        strategy_id: 0x2::object::ID,
        total_amount: u64,
        atm_amount: u64,
        sigma_amount: u64,
        plp_amount: u64,
        timestamp: u64,
    }

    public entry fun create_strategy(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 + arg3 + arg4 == 10000, 0);
        let v0 = StrategyState{
            id                     : 0x2::object::new(arg5),
            total_deployed         : 0,
            total_in_predict_range : 0,
            total_in_plp           : 0,
            total_settled          : 0,
            total_pnl              : 0,
            atm_range_bps          : arg0,
            sigma_range_bps        : arg1,
            atm_ratio_bps          : arg2,
            sigma_ratio_bps        : arg3,
            plp_ratio_bps          : arg4,
            paused                 : false,
            position_count         : 0,
            settled_count          : 0,
        };
        let v1 = StrategyCreated{strategy_id: 0x2::object::id<StrategyState>(&v0)};
        0x2::event::emit<StrategyCreated>(v1);
        0x2::transfer::share_object<StrategyState>(v0);
    }

    public fun is_paused(arg0: &StrategyState) : bool {
        arg0.paused
    }

    public fun position_count(arg0: &StrategyState) : u64 {
        arg0.position_count
    }

    public fun prepare_deployment<T0>(arg0: &mut StrategyState, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        assert!(!arg0.paused, 502);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 500);
        let v1 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(v0, arg0.atm_ratio_bps);
        let v2 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(v0, arg0.sigma_ratio_bps);
        let v3 = v0 - v1 - v2;
        arg0.total_deployed = arg0.total_deployed + v0;
        arg0.total_in_predict_range = arg0.total_in_predict_range + v1 + v2;
        arg0.total_in_plp = arg0.total_in_plp + v3;
        arg0.position_count = arg0.position_count + 2;
        let v4 = FundsDeployed{
            strategy_id  : 0x2::object::id<StrategyState>(arg0),
            total_amount : v0,
            atm_amount   : v1,
            sigma_amount : v2,
            plp_amount   : v3,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FundsDeployed>(v4);
        let v5 = PositionOpened{
            strategy_id   : 0x2::object::id<StrategyState>(arg0),
            position_type : 0,
            amount        : v1,
            strike_low    : arg2 - 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(arg2, arg0.atm_range_bps),
            strike_high   : arg2 + 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(arg2, arg0.atm_range_bps),
        };
        0x2::event::emit<PositionOpened>(v5);
        let v6 = PositionOpened{
            strategy_id   : 0x2::object::id<StrategyState>(arg0),
            position_type : 1,
            amount        : v2,
            strike_low    : arg2 - 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(arg2, arg0.sigma_range_bps),
            strike_high   : arg2 + 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::mul_bps(arg2, arg0.sigma_range_bps),
        };
        0x2::event::emit<PositionOpened>(v6);
        let v7 = PositionOpened{
            strategy_id   : 0x2::object::id<StrategyState>(arg0),
            position_type : 2,
            amount        : v3,
            strike_low    : 0,
            strike_high   : 0,
        };
        0x2::event::emit<PositionOpened>(v7);
        (0x2::balance::split<T0>(&mut arg1, v1), 0x2::balance::split<T0>(&mut arg1, v2), arg1)
    }

    public fun record_settlement(arg0: &mut StrategyState, arg1: u64, arg2: u64) {
        arg0.settled_count = arg0.settled_count + 1;
        arg0.total_settled = arg0.total_settled + arg2;
        if (arg2 > arg1) {
            arg0.total_pnl = arg0.total_pnl + arg2 - arg1;
        };
        arg0.total_deployed = arg0.total_deployed - 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(arg1, arg0.total_deployed);
        let v0 = arg2 >= arg1;
        let v1 = if (v0) {
            arg2 - arg1
        } else {
            arg1 - arg2
        };
        let v2 = PositionSettled{
            strategy_id     : 0x2::object::id<StrategyState>(arg0),
            amount_deployed : arg1,
            amount_received : arg2,
            profit          : v0,
            pnl             : v1,
        };
        0x2::event::emit<PositionSettled>(v2);
    }

    public fun settled_count(arg0: &StrategyState) : u64 {
        arg0.settled_count
    }

    public fun total_deployed(arg0: &StrategyState) : u64 {
        arg0.total_deployed
    }

    public fun total_in_plp(arg0: &StrategyState) : u64 {
        arg0.total_in_plp
    }

    public fun total_in_predict(arg0: &StrategyState) : u64 {
        arg0.total_in_predict_range
    }

    public fun total_pnl(arg0: &StrategyState) : u64 {
        arg0.total_pnl
    }

    // decompiled from Move bytecode v7
}

