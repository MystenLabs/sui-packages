module 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::dextrader_bluefin {
    struct TransferOwnership has copy, drop {
        old_owner: address,
        new_owner: address,
    }

    struct SetOperator has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct SetTokenHolder has copy, drop {
        old_token_holder: address,
        new_token_holder: address,
    }

    struct SetPoolWhitelist has copy, drop {
        pool: 0x2::object::ID,
        accepted: bool,
    }

    struct SetPoolTickLimits has copy, drop {
        pool: 0x2::object::ID,
        tick_lowest_idx: u32,
        tick_upperest_idx: u32,
    }

    struct SetPoolPriceLimits has copy, drop {
        pool: 0x2::object::ID,
        sqrt_price_limit_a2b: u128,
        sqrt_price_limit_b2a: u128,
    }

    struct SetPriceOracle has copy, drop {
        pool: 0x2::object::ID,
        oracle_price_id: vector<u8>,
    }

    struct SetOracleStalenessThreshold has copy, drop {
        oracle_staleness_threshold: u64,
    }

    struct SetOracleTolerance has copy, drop {
        oracle_tolerance_bps: u64,
    }

    struct CreatePosition has copy, drop {
        pool: 0x2::object::ID,
        position_id: 0x2::object::ID,
        tick_lower_idx: u32,
        tick_upper_idx: u32,
    }

    struct ClosePosition has copy, drop {
        pool: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct State has key {
        id: 0x2::object::UID,
        version: u64,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        owner: address,
        operator: address,
        token_holder: address,
        pool_whitelist: 0x2::table::Table<0x2::object::ID, bool>,
        pool_tick_limits: 0x2::table::Table<0x2::object::ID, TickLimits>,
        pool_price_limits: 0x2::table::Table<0x2::object::ID, PriceLimits>,
        balances: 0x2::bag::Bag,
        oracles: 0x2::table::Table<0x2::object::ID, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::OracleConfig>,
        oracle_staleness_threshold: u64,
        oracle_tolerance_bps: u64,
    }

    struct TickLimits has drop, store {
        tick_lowest_idx: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upperest_idx: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct PriceLimits has drop, store {
        sqrt_price_limit_a2b: u128,
        sqrt_price_limit_b2a: u128,
    }

    entry fun swap<T0, T1>(arg0: &mut State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg12);
        check_pool_prices(arg0, check_pool_id<T0, T1>(arg0, arg2), arg5, arg9, arg10, arg11);
        let v0 = &mut arg0.balances;
        let v1 = 0x2::balance::split<T0>(get_balance_mut<T0>(v0), arg3);
        let v2 = &mut arg0.balances;
        let (v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg11, arg1, arg2, v1, 0x2::balance::split<T1>(get_balance_mut<T1>(v2), arg4), arg5, arg6, arg7, arg8, arg9);
        let v5 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v5), v3);
        let v6 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v6), v4);
    }

    entry fun add_liquidity<T0, T1>(arg0: &mut State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg10);
        check_pool_id<T0, T1>(arg0, arg2);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg8);
        let v1 = &mut v0;
        add_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, arg9);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun collect_fee<T0, T1>(arg0: &mut State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        check_pool_id<T0, T1>(arg0, arg2);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg3);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg1, arg2, &mut v0);
        let v5 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v5), v3);
        let v6 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v6), v4);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun collect_reward<T0, T1, T2>(arg0: &mut State, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        check_pool_id<T0, T1>(arg0, arg3);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg4);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg1, arg2, arg3, &mut v0), arg5), v1);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v1);
    }

    entry fun remove_liquidity<T0, T1>(arg0: &mut State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u128, arg4: u64, arg5: u64, arg6: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg8);
        check_pool_id<T0, T1>(arg0, arg2);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg6);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut v0, arg3, arg7);
        let v5 = v4;
        let v6 = v3;
        assert!(v1 >= arg4, 112);
        assert!(v2 >= arg5, 113);
        let (_, _, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg7, arg1, arg2, &mut v0);
        0x2::balance::join<T0>(&mut v6, v9);
        0x2::balance::join<T1>(&mut v5, v10);
        let v11 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v11), v6);
        let v12 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v12), v5);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun accept_payment<T0>(arg0: &mut State, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1));
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg9: &0x2::clock::Clock) {
        let v0 = &mut arg0.balances;
        let v1 = 0x2::balance::split<T0>(get_balance_mut<T0>(v0), arg3);
        let v2 = &mut arg0.balances;
        let (v3, v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg9, arg1, arg2, arg8, v1, 0x2::balance::split<T1>(get_balance_mut<T1>(v2), arg4), arg7);
        assert!(v3 >= arg5, 112);
        assert!(v4 >= arg6, 113);
        let v7 = &mut arg0.balances;
        0x2::balance::join<T0>(get_balance_mut<T0>(v7), v5);
        let v8 = &mut arg0.balances;
        0x2::balance::join<T1>(get_balance_mut<T1>(v8), v6);
    }

    fun check_operator(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 102);
    }

    fun check_owner(arg0: &State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 101);
    }

    fun check_pool_id<T0, T1>(arg0: &State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.pool_whitelist, v0), 104);
        v0
    }

    public(friend) fun check_pool_prices(arg0: &State, arg1: 0x2::object::ID, arg2: bool, arg3: u128, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1), 108);
        if (arg2) {
            assert!(0x2::table::borrow<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1).sqrt_price_limit_a2b <= arg3, 110);
        } else {
            assert!(0x2::table::borrow<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1).sqrt_price_limit_b2a >= arg3, 110);
        };
        if (arg2) {
            assert!(0x1::u256::pow((arg3 as u256), 2) >= 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::get_oracle_price_x128(0x2::table::borrow<0x2::object::ID, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::OracleConfig>(&arg0.oracles, arg1), arg4, arg0.oracle_staleness_threshold, arg2, arg5) * ((10000 - arg0.oracle_tolerance_bps) as u256) / 10000, 121);
        } else {
            assert!(0x1::u256::pow((arg3 as u256), 2) <= 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::get_oracle_price_x128(0x2::table::borrow<0x2::object::ID, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::OracleConfig>(&arg0.oracles, arg1), arg4, arg0.oracle_staleness_threshold, arg2, arg5) * ((10000 + arg0.oracle_tolerance_bps) as u256) / 10000, 121);
        };
    }

    public(friend) fun check_pool_ticks<T0, T1>(arg0: &State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, v0), 107);
        let v1 = 0x2::table::borrow<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, v0);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1.tick_lowest_idx, arg2) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v1.tick_upperest_idx, arg3), 109);
        let v2 = 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::get_oracle_price_x128(0x2::table::borrow<0x2::object::ID, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::OracleConfig>(&arg0.oracles, v0), arg4, arg0.oracle_staleness_threshold, true, arg5);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::create_tick(arg2);
        let v4 = 0x1::u256::pow((0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(&v3) as u256), 2);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::create_tick(arg3);
        let v6 = 0x1::u256::pow((0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::sqrt_price(&v5) as u256), 2);
        let v7 = 0x1::u256::pow((0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1) as u256), 2);
        assert!(0x1::u256::min(v6, v4) >= 0x1::u256::max(v7, v2) || 0x1::u256::max(v6, v4) <= 0x1::u256::min(v7, v2), 122);
    }

    fun check_version(arg0: &State) {
        assert!(arg0.version == 1, 100);
    }

    entry fun close_position<T0, T1>(arg0: &mut State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg5);
        let v0 = 0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg3);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0) == 0, 105);
        let v1 = ClosePosition{
            pool        : check_pool_id<T0, T1>(arg0, arg2),
            position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0),
        };
        0x2::event::emit<ClosePosition>(v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg4, arg1, arg2, v0);
    }

    entry fun create_position<T0, T1>(arg0: &State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg7);
        check_pool_id<T0, T1>(arg0, arg2);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(create_position_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), 0x2::object::uid_to_address(&arg0.id));
    }

    entry fun create_position_and_add_liquidity<T0, T1>(arg0: &mut State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg12);
        check_pool_id<T0, T1>(arg0, arg2);
        let v0 = create_position_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg10, arg11, arg12);
        let v1 = &mut v0;
        add_liquidity_internal<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9, v1, arg11);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, 0x2::object::uid_to_address(&arg0.id));
    }

    fun create_position_internal<T0, T1>(arg0: &State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u32, arg4: u32, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg3, arg4, arg7);
        check_pool_ticks<T0, T1>(arg0, arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4), arg5, arg6);
        let v1 = CreatePosition{
            pool           : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2),
            position_id    : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0),
            tick_lower_idx : arg3,
            tick_upper_idx : arg4,
        };
        0x2::event::emit<CreatePosition>(v1);
        v0
    }

    fun get_balance_mut<T0>(arg0: &mut 0x2::bag::Bag) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0), 106);
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = State{
            id                         : 0x2::object::new(arg0),
            version                    : 1,
            upgrade_cap_id             : 0x1::option::none<0x2::object::ID>(),
            owner                      : v0,
            operator                   : v0,
            token_holder               : v0,
            pool_whitelist             : 0x2::table::new<0x2::object::ID, bool>(arg0),
            pool_tick_limits           : 0x2::table::new<0x2::object::ID, TickLimits>(arg0),
            pool_price_limits          : 0x2::table::new<0x2::object::ID, PriceLimits>(arg0),
            balances                   : 0x2::bag::new(arg0),
            oracles                    : 0x2::table::new<0x2::object::ID, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::OracleConfig>(arg0),
            oracle_staleness_threshold : 90,
            oracle_tolerance_bps       : 100,
        };
        0x2::transfer::share_object<State>(v1);
    }

    entry fun init_upgrade_cap_id(arg0: &mut State, arg1: &0x2::package::UpgradeCap, arg2: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg2);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.upgrade_cap_id), 111);
        let v0 = 0x2::package::upgrade_package(arg1);
        assert!(0x2::object::id_to_address(&v0) == package_address(arg0), 103);
        arg0.upgrade_cap_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    entry fun migrate(arg0: &mut State, arg1: &0x2::tx_context::TxContext) {
        check_owner(arg0, arg1);
        assert!(arg0.version < 1, 100);
        arg0.version = 1;
    }

    public fun oracle_staleness_threshold(arg0: &State) : u64 {
        arg0.oracle_staleness_threshold
    }

    public fun oracle_tolerance_bps(arg0: &State) : u64 {
        arg0.oracle_tolerance_bps
    }

    public fun package_address(arg0: &State) : address {
        let v0 = 0x1::type_name::with_original_ids<State>();
        let v1 = 0x1::type_name::address_string(&v0);
        0x2::address::from_ascii_bytes(0x1::ascii::as_bytes(&v1))
    }

    entry fun set_operator(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.operator = arg1;
        let v0 = SetOperator{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<SetOperator>(v0);
    }

    entry fun set_oracle_staleness_threshold(arg0: &mut State, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.oracle_staleness_threshold = arg1;
        let v0 = SetOracleStalenessThreshold{oracle_staleness_threshold: arg1};
        0x2::event::emit<SetOracleStalenessThreshold>(v0);
    }

    entry fun set_oracle_tolerance(arg0: &mut State, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.oracle_tolerance_bps = arg1;
        let v0 = SetOracleTolerance{oracle_tolerance_bps: arg1};
        0x2::event::emit<SetOracleTolerance>(v0);
    }

    entry fun set_pool_price_limits(arg0: &mut State, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg4);
        if (0x2::table::contains<0x2::object::ID, PriceLimits>(&arg0.pool_price_limits, arg1)) {
            0x2::table::remove<0x2::object::ID, PriceLimits>(&mut arg0.pool_price_limits, arg1);
        };
        let v0 = PriceLimits{
            sqrt_price_limit_a2b : arg2,
            sqrt_price_limit_b2a : arg3,
        };
        0x2::table::add<0x2::object::ID, PriceLimits>(&mut arg0.pool_price_limits, arg1, v0);
        let v1 = SetPoolPriceLimits{
            pool                 : arg1,
            sqrt_price_limit_a2b : arg2,
            sqrt_price_limit_b2a : arg3,
        };
        0x2::event::emit<SetPoolPriceLimits>(v1);
    }

    entry fun set_pool_tick_limits(arg0: &mut State, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg4);
        if (0x2::table::contains<0x2::object::ID, TickLimits>(&arg0.pool_tick_limits, arg1)) {
            0x2::table::remove<0x2::object::ID, TickLimits>(&mut arg0.pool_tick_limits, arg1);
        };
        let v0 = TickLimits{
            tick_lowest_idx   : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2),
            tick_upperest_idx : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg3),
        };
        0x2::table::add<0x2::object::ID, TickLimits>(&mut arg0.pool_tick_limits, arg1, v0);
        let v1 = SetPoolTickLimits{
            pool              : arg1,
            tick_lowest_idx   : arg2,
            tick_upperest_idx : arg3,
        };
        0x2::event::emit<SetPoolTickLimits>(v1);
    }

    entry fun set_pool_whitelist(arg0: &mut State, arg1: 0x2::object::ID, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.pool_whitelist, arg1)) {
            if (!arg2) {
                0x2::table::remove<0x2::object::ID, bool>(&mut arg0.pool_whitelist, arg1);
            };
        } else if (arg2) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.pool_whitelist, arg1, true);
        };
        let v0 = SetPoolWhitelist{
            pool     : arg1,
            accepted : arg2,
        };
        0x2::event::emit<SetPoolWhitelist>(v0);
    }

    entry fun set_price_oracle<T0, T1>(arg0: &mut State, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: vector<u8>, arg3: bool, arg4: u8, arg5: &0x2::coin::CoinMetadata<T0>, arg6: &0x2::coin::CoinMetadata<T1>, arg7: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg7);
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1);
        if (0x2::table::contains<0x2::object::ID, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::OracleConfig>(&arg0.oracles, v0)) {
            0x2::table::remove<0x2::object::ID, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::OracleConfig>(&mut arg0.oracles, v0);
        };
        0x2::table::add<0x2::object::ID, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::OracleConfig>(&mut arg0.oracles, v0, 0xa59fb76bc3c9f9d62277a21d20d3176ed4e20a3dd408ed7b583de23967cc6ada::pyth_oracle::create_oracle_config(arg2, arg3, arg4, 0x2::coin::get_decimals<T0>(arg5), 0x2::coin::get_decimals<T1>(arg6)));
        let v1 = SetPriceOracle{
            pool            : v0,
            oracle_price_id : arg2,
        };
        0x2::event::emit<SetPriceOracle>(v1);
    }

    entry fun set_token_holder(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg2);
        arg0.token_holder = arg1;
        let v0 = SetTokenHolder{
            old_token_holder : arg0.token_holder,
            new_token_holder : arg1,
        };
        0x2::event::emit<SetTokenHolder>(v0);
    }

    entry fun transfer_ownership(arg0: &mut State, arg1: address, arg2: 0x2::package::UpgradeCap, arg3: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_owner(arg0, arg3);
        let v0 = 0x2::object::id<0x2::package::UpgradeCap>(&arg2);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.upgrade_cap_id, &v0), 103);
        0x2::transfer::public_transfer<0x2::package::UpgradeCap>(arg2, arg1);
        arg0.owner = arg1;
        let v1 = TransferOwnership{
            old_owner : arg0.owner,
            new_owner : arg1,
        };
        0x2::event::emit<TransferOwnership>(v1);
    }

    entry fun withdraw<T0>(arg0: &mut State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        let v0 = &mut arg0.balances;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(get_balance_mut<T0>(v0), arg1, arg2), arg0.token_holder);
    }

    entry fun withdraw_position(arg0: &mut State, arg1: 0x2::transfer::Receiving<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg2);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::transfer::public_receive<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, arg1), arg0.token_holder);
    }

    entry fun withdraw_to_state<T0>(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        check_operator(arg0, arg1);
        let v0 = &mut arg0.balances;
        let v1 = get_balance_mut<T0>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, 0x2::balance::value<T0>(v1), arg1), 0x2::object::uid_to_address(&arg0.id));
    }

    // decompiled from Move bytecode v7
}

