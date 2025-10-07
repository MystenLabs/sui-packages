module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::amm {
    struct LiquidityPool has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        outcome_idx: u8,
        asset_reserve: u64,
        stable_reserve: u64,
        fee_percent: u64,
        oracle: 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::Oracle,
        protocol_fees: u64,
    }

    struct SwapEvent has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        is_buy: bool,
        amount_in: u64,
        amount_out: u64,
        price_impact: u128,
        price: u128,
        sender: address,
        asset_reserve: u64,
        stable_reserve: u64,
        timestamp: u64,
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_64(arg0, arg1, 10000);
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public(friend) fun calculate_output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = arg1 + arg0;
        assert!(v0 > 0, 3);
        (0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_mixed(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_128(arg0, arg2, 1), 1, (v0 as u128)) as u64)
    }

    fun calculate_price_impact(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u128 {
        let v0 = 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_128(arg0, arg3, arg1);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_mixed(v0 - (arg2 as u128), 10000, v0)
    }

    public fun check_price_under_max(arg0: u128) {
        assert!(arg0 <= 18446744073709551615 * (1000000000000 as u128), 5);
    }

    public(friend) fun empty_all_amm_liquidity(arg0: &mut LiquidityPool, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        arg0.asset_reserve = 0;
        arg0.stable_reserve = 0;
        (arg0.asset_reserve, arg0.stable_reserve)
    }

    public fun get_current_price(arg0: &LiquidityPool) : u128 {
        assert!(arg0.asset_reserve > 0 && arg0.stable_reserve > 0, 4);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_128(arg0.stable_reserve, 1000000000000, arg0.asset_reserve)
    }

    public fun get_id(arg0: &LiquidityPool) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_k(arg0: &LiquidityPool) : u128 {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_128(arg0.asset_reserve, arg0.stable_reserve, 1)
    }

    public(friend) fun get_ms_id(arg0: &LiquidityPool) : 0x2::object::ID {
        arg0.market_id
    }

    public fun get_oracle(arg0: &LiquidityPool) : &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::Oracle {
        &arg0.oracle
    }

    public fun get_outcome_idx(arg0: &LiquidityPool) : u8 {
        arg0.outcome_idx
    }

    public fun get_price(arg0: &LiquidityPool) : u128 {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::get_last_price(&arg0.oracle)
    }

    public(friend) fun get_protocol_fees(arg0: &LiquidityPool) : u64 {
        arg0.protocol_fees
    }

    public fun get_reserves(arg0: &LiquidityPool) : (u64, u64) {
        (arg0.asset_reserve, arg0.stable_reserve)
    }

    public(friend) fun get_twap(arg0: &mut LiquidityPool, arg1: &0x2::clock::Clock) : u128 {
        update_twap_observation(arg0, arg1);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::get_twap(&arg0.oracle, arg1)
    }

    public(friend) fun new_pool(arg0: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg1: u8, arg2: u64, arg3: u64, arg4: u128, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : LiquidityPool {
        assert!(arg2 > 0 && arg3 > 0, 6);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_128(arg2, arg3, 1) >= 1000, 0);
        check_price_under_max(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_128(arg3, 1000000000000, arg2));
        check_price_under_max(arg4);
        LiquidityPool{
            id             : 0x2::object::new(arg7),
            market_id      : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg0),
            outcome_idx    : arg1,
            asset_reserve  : arg2,
            stable_reserve : arg3,
            fee_percent    : 30,
            oracle         : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::new_oracle(arg4, arg5, arg6, arg7),
            protocol_fees  : 0,
        }
    }

    public fun quote_swap_asset_to_stable(arg0: &LiquidityPool, arg1: u64) : u64 {
        let v0 = calculate_output(arg1, arg0.asset_reserve, arg0.stable_reserve);
        v0 - calculate_fee(v0, arg0.fee_percent)
    }

    public fun quote_swap_stable_to_asset(arg0: &LiquidityPool, arg1: u64) : u64 {
        calculate_output(arg1 - calculate_fee(arg1, arg0.fee_percent), arg0.stable_reserve, arg0.asset_reserve)
    }

    public(friend) fun reset_protocol_fees(arg0: &mut LiquidityPool) {
        arg0.protocol_fees = 0;
    }

    public(friend) fun set_oracle_start_time(arg0: &mut LiquidityPool, arg1: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState) {
        assert!(get_ms_id(arg0) == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg1), 7);
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::set_oracle_start_time(&mut arg0.oracle, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::get_trading_start(arg1));
    }

    public(friend) fun swap_asset_to_stable(arg0: &mut LiquidityPool, arg1: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_trading_active(arg1);
        assert!(arg0.market_id == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg1), 7);
        assert!(arg2 > 0, 6);
        let v0 = calculate_output(arg2, arg0.asset_reserve, arg0.stable_reserve);
        let v1 = calculate_fee(v0, arg0.fee_percent);
        let v2 = v0 - v1;
        arg0.protocol_fees = arg0.protocol_fees + v1;
        assert!(v2 >= arg3, 2);
        assert!(v0 < arg0.stable_reserve, 1);
        arg0.asset_reserve = arg0.asset_reserve + arg2;
        arg0.stable_reserve = arg0.stable_reserve - v0;
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = &mut arg0.oracle;
        write_observation(v4, v3, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_128(arg0.stable_reserve, 1000000000000, arg0.asset_reserve));
        let v5 = get_current_price(arg0);
        check_price_under_max(v5);
        let v6 = SwapEvent{
            market_id      : arg0.market_id,
            outcome        : arg0.outcome_idx,
            is_buy         : false,
            amount_in      : arg2,
            amount_out     : v2,
            price_impact   : calculate_price_impact(arg2, arg0.asset_reserve, v0, arg0.stable_reserve),
            price          : v5,
            sender         : 0x2::tx_context::sender(arg5),
            asset_reserve  : arg0.asset_reserve,
            stable_reserve : arg0.stable_reserve,
            timestamp      : v3,
        };
        0x2::event::emit<SwapEvent>(v6);
        v2
    }

    public(friend) fun swap_stable_to_asset(arg0: &mut LiquidityPool, arg1: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_trading_active(arg1);
        assert!(arg0.market_id == 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg1), 7);
        assert!(arg2 > 0, 6);
        let v0 = calculate_fee(arg2, arg0.fee_percent);
        let v1 = arg2 - v0;
        arg0.protocol_fees = arg0.protocol_fees + v0;
        let v2 = calculate_output(v1, arg0.stable_reserve, arg0.asset_reserve);
        assert!(v2 >= arg3, 2);
        assert!(v2 < arg0.asset_reserve, 1);
        arg0.stable_reserve = arg0.stable_reserve + v1;
        arg0.asset_reserve = arg0.asset_reserve - v2;
        let v3 = 0x2::clock::timestamp_ms(arg4);
        let v4 = &mut arg0.oracle;
        write_observation(v4, v3, 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::math::mul_div_to_128(arg0.stable_reserve, 1000000000000, arg0.asset_reserve));
        let v5 = get_current_price(arg0);
        check_price_under_max(v5);
        let v6 = SwapEvent{
            market_id      : arg0.market_id,
            outcome        : arg0.outcome_idx,
            is_buy         : true,
            amount_in      : arg2,
            amount_out     : v2,
            price_impact   : calculate_price_impact(v1, arg0.stable_reserve, v2, arg0.asset_reserve),
            price          : v5,
            sender         : 0x2::tx_context::sender(arg5),
            asset_reserve  : arg0.asset_reserve,
            stable_reserve : arg0.stable_reserve,
            timestamp      : v3,
        };
        0x2::event::emit<SwapEvent>(v6);
        v2
    }

    public(friend) fun update_twap_observation(arg0: &mut LiquidityPool, arg1: &0x2::clock::Clock) {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::write_observation(&mut arg0.oracle, 0x2::clock::timestamp_ms(arg1), get_current_price(arg0));
    }

    fun write_observation(arg0: &mut 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::Oracle, arg1: u64, arg2: u128) {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::oracle::write_observation(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

