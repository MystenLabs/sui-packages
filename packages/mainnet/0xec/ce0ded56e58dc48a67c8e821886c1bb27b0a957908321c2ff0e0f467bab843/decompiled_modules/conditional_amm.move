module 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::conditional_amm {
    struct LiquidityPool has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        outcome_idx: u8,
        asset_reserve: u64,
        stable_reserve: u64,
        fee_percent: u64,
        oracle: 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::Oracle,
        protocol_fees_asset: u64,
        protocol_fees_stable: u64,
        lp_supply: u64,
        has_pending_injection: bool,
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

    struct LiquidityAdded has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        asset_amount: u64,
        stable_amount: u64,
        lp_amount: u64,
        sender: address,
        timestamp: u64,
    }

    struct LiquidityRemoved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        asset_amount: u64,
        stable_amount: u64,
        lp_amount: u64,
        sender: address,
        timestamp: u64,
    }

    struct PoolOracleCreated has copy, drop {
        pool_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        outcome_idx: u8,
        oracle_id: 0x2::object::ID,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        outcome_idx: u8,
        asset_reserve: u64,
        stable_reserve: u64,
        price: u128,
        fee_bps: u64,
        timestamp: u64,
    }

    public fun add_liquidity_proportional(arg0: &mut LiquidityPool, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.has_pending_injection, 17);
        assert!(arg1 > 0, 6);
        assert!(arg2 > 0, 6);
        let (v0, v1) = if (arg0.lp_supply == 0) {
            assert!(arg0.asset_reserve == 0 && arg0.stable_reserve == 0, 4);
            let v2 = (0x1::u128::sqrt(0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg1, arg2, 1)) as u64);
            assert!(v2 > 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::minimum_liquidity(), 0);
            (v2 - 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::minimum_liquidity(), v2)
        } else {
            let v3 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, arg0.lp_supply, arg0.asset_reserve);
            let v4 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg2, arg0.lp_supply, arg0.stable_reserve);
            let v5 = if (v3 > v4) {
                v3 - v4
            } else {
                v4 - v3
            };
            assert!((v5 as u128) * 100 <= (((v3 + v4) / 2) as u128), 13);
            let v6 = 0x1::u64::min(v3, v4);
            (v6, arg0.lp_supply + v6)
        };
        assert!(v0 >= arg3, 2);
        let v7 = arg0.asset_reserve + arg1;
        let v8 = arg0.stable_reserve + arg2;
        assert!(v7 >= arg0.asset_reserve, 10);
        assert!(v8 >= arg0.stable_reserve, 10);
        assert!(v1 >= arg0.lp_supply, 10);
        arg0.asset_reserve = v7;
        arg0.stable_reserve = v8;
        arg0.lp_supply = v1;
        assert!((arg0.asset_reserve as u128) * (arg0.stable_reserve as u128) > (arg0.asset_reserve as u128) * (arg0.stable_reserve as u128), 12);
        let v9 = LiquidityAdded{
            market_id     : arg0.market_id,
            outcome       : arg0.outcome_idx,
            asset_amount  : arg1,
            stable_amount : arg2,
            lp_amount     : v0,
            sender        : 0x2::tx_context::sender(arg5),
            timestamp     : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LiquidityAdded>(v9);
        v0
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg0, arg1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps())
    }

    public fun calculate_output(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = arg1 + arg0;
        assert!(v0 > 0, 3);
        let v1 = (arg0 as u256) * (arg2 as u256) / (v0 as u256);
        assert!(v1 <= 18446744073709551615, 10);
        (v1 as u64)
    }

    fun calculate_price_impact(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u128 {
        let v0 = (arg0 as u256) * (arg3 as u256) / (arg1 as u256);
        if (v0 == 0) {
            return (0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps() as u128)
        };
        assert!(v0 <= 340282366920938463463374607431768211455, 10);
        let v1 = (v0 as u128);
        assert!(v1 >= (arg2 as u128), 10);
        0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_mixed(v1 - (arg2 as u128), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps(), v1)
    }

    public fun check_price_under_max(arg0: u128) {
        assert!(arg0 <= 18446744073709551615 * (0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale() as u128), 5);
    }

    public fun collect_protocol_fees(arg0: &mut LiquidityPool, arg1: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) : (u64, u64) {
        arg0.protocol_fees_asset = 0;
        arg0.protocol_fees_stable = 0;
        (arg0.protocol_fees_asset, arg0.protocol_fees_stable)
    }

    public fun empty_all_amm_liquidity(arg0: &mut LiquidityPool, arg1: &mut 0x2::tx_context::TxContext, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) : (u64, u64) {
        assert!(!arg0.has_pending_injection, 17);
        arg0.asset_reserve = 0;
        arg0.stable_reserve = 0;
        arg0.lp_supply = 0;
        (arg0.asset_reserve, arg0.stable_reserve)
    }

    public fun extract_reserves_for_arbitrage(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(arg0.market_id == arg1, 15);
        assert!(arg0.has_pending_injection, 18);
        assert!(arg0.asset_reserve >= arg2, 0);
        assert!(arg0.stable_reserve >= arg3, 0);
        arg0.asset_reserve = arg0.asset_reserve - arg2;
        arg0.stable_reserve = arg0.stable_reserve - arg3;
        arg0.has_pending_injection = false;
    }

    public fun feeless_swap_asset_to_stable(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) : u64 {
        assert!(arg0.market_id == arg1, 15);
        assert!(!arg0.has_pending_injection, 17);
        let v0 = &mut arg0.oracle;
        write_observation(v0, 0x2::clock::timestamp_ms(arg3), get_current_price(arg0), arg3);
        swap_asset_to_stable_internal(arg0, arg2, false)
    }

    public fun feeless_swap_stable_to_asset(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) : u64 {
        assert!(arg0.market_id == arg1, 15);
        assert!(!arg0.has_pending_injection, 17);
        let v0 = &mut arg0.oracle;
        write_observation(v0, 0x2::clock::timestamp_ms(arg3), get_current_price(arg0), arg3);
        swap_stable_to_asset_internal(arg0, arg2, false)
    }

    public fun get_current_price(arg0: &LiquidityPool) : u128 {
        assert!(arg0.asset_reserve > 0 && arg0.stable_reserve > 0, 4);
        0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg0.stable_reserve, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale(), arg0.asset_reserve)
    }

    public fun get_fee_bps(arg0: &LiquidityPool) : u64 {
        arg0.fee_percent
    }

    public fun get_id(arg0: &LiquidityPool) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_k(arg0: &LiquidityPool) : u128 {
        0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg0.asset_reserve, arg0.stable_reserve, 1)
    }

    public fun get_lp_supply(arg0: &LiquidityPool) : u64 {
        arg0.lp_supply
    }

    public fun get_ms_id(arg0: &LiquidityPool) : 0x2::object::ID {
        arg0.market_id
    }

    public fun get_oracle(arg0: &LiquidityPool) : &0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::Oracle {
        &arg0.oracle
    }

    public fun get_oracle_full_state(arg0: &LiquidityPool) : (u128, u64, u256, u256, u64, u128, 0x1::option::Option<u64>, u128, u64, u64) {
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::get_full_state(&arg0.oracle)
    }

    public fun get_outcome_idx(arg0: &LiquidityPool) : u8 {
        arg0.outcome_idx
    }

    public fun get_price(arg0: &LiquidityPool) : u128 {
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::last_price(&arg0.oracle)
    }

    public fun get_protocol_fees(arg0: &LiquidityPool) : u64 {
        arg0.protocol_fees_stable
    }

    public fun get_protocol_fees_asset(arg0: &LiquidityPool) : u64 {
        arg0.protocol_fees_asset
    }

    public fun get_protocol_fees_stable(arg0: &LiquidityPool) : u64 {
        arg0.protocol_fees_stable
    }

    public fun get_reserves(arg0: &LiquidityPool) : (u64, u64) {
        (arg0.asset_reserve, arg0.stable_reserve)
    }

    public fun get_twap(arg0: &mut LiquidityPool, arg1: &0x2::clock::Clock, arg2: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) : u128 {
        update_twap_observation(arg0, arg1);
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::get_twap(&arg0.oracle, arg1)
    }

    public fun get_twap_at(arg0: &mut LiquidityPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) : u128 {
        let v0 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::last_timestamp(&arg0.oracle);
        if (arg1 > v0) {
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::write_observation(&mut arg0.oracle, arg1, get_current_price(arg0), arg2);
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::get_twap_at(&arg0.oracle, arg1)
        } else {
            assert!(v0 == arg1, 19);
            0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::get_twap_at(&arg0.oracle, arg1)
        }
    }

    public fun inject_reserves_for_arbitrage(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(arg0.market_id == arg1, 15);
        assert!(!arg0.has_pending_injection, 17);
        arg0.has_pending_injection = true;
        arg0.asset_reserve = arg0.asset_reserve + arg2;
        arg0.stable_reserve = arg0.stable_reserve + arg3;
    }

    public fun new_empty_pool(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u128, arg4: u64, arg5: u64, arg6: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : LiquidityPool {
        assert!(arg2 <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_amm_fee_bps(), 11);
        check_price_under_max(arg3);
        let v0 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::new_oracle(arg3, arg4, arg5, arg8);
        let v1 = LiquidityPool{
            id                    : 0x2::object::new(arg8),
            market_id             : arg0,
            outcome_idx           : arg1,
            asset_reserve         : 0,
            stable_reserve        : 0,
            fee_percent           : arg2,
            oracle                : v0,
            protocol_fees_asset   : 0,
            protocol_fees_stable  : 0,
            lp_supply             : 0,
            has_pending_injection : false,
        };
        let v2 = PoolOracleCreated{
            pool_id     : 0x2::object::id<LiquidityPool>(&v1),
            market_id   : arg0,
            outcome_idx : arg1,
            oracle_id   : 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::oracle_id(&v0),
        };
        0x2::event::emit<PoolOracleCreated>(v2);
        let v3 = PoolCreated{
            pool_id        : 0x2::object::id<LiquidityPool>(&v1),
            market_id      : arg0,
            outcome_idx    : arg1,
            asset_reserve  : 0,
            stable_reserve : 0,
            price          : arg3,
            fee_bps        : arg2,
            timestamp      : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<PoolCreated>(v3);
        v1
    }

    public fun new_pool(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u128>, arg6: u64, arg7: u64, arg8: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : LiquidityPool {
        assert!(arg3 > 0 && arg4 > 0, 6);
        assert!(arg2 <= 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::max_amm_fee_bps(), 11);
        let v0 = if (0x1::option::is_some<u128>(&arg5)) {
            *0x1::option::borrow<u128>(&arg5)
        } else {
            0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg4, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale(), arg3)
        };
        check_price_under_max(v0);
        let v1 = 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::new_oracle(v0, arg6, arg7, arg10);
        let v2 = (0x1::u128::sqrt(0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg3, arg4, 1)) as u64);
        assert!(v2 > 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::minimum_liquidity(), 0);
        let v3 = LiquidityPool{
            id                    : 0x2::object::new(arg10),
            market_id             : arg0,
            outcome_idx           : arg1,
            asset_reserve         : arg3,
            stable_reserve        : arg4,
            fee_percent           : arg2,
            oracle                : v1,
            protocol_fees_asset   : 0,
            protocol_fees_stable  : 0,
            lp_supply             : v2,
            has_pending_injection : false,
        };
        let v4 = PoolOracleCreated{
            pool_id     : 0x2::object::id<LiquidityPool>(&v3),
            market_id   : arg0,
            outcome_idx : arg1,
            oracle_id   : 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::oracle_id(&v1),
        };
        0x2::event::emit<PoolOracleCreated>(v4);
        let v5 = PoolCreated{
            pool_id        : 0x2::object::id<LiquidityPool>(&v3),
            market_id      : arg0,
            outcome_idx    : arg1,
            asset_reserve  : arg3,
            stable_reserve : arg4,
            price          : v0,
            fee_bps        : arg2,
            timestamp      : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<PoolCreated>(v5);
        v3
    }

    public fun quote_swap_asset_to_stable(arg0: &LiquidityPool, arg1: u64) : u64 {
        let v0 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_fee_bps(), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps()) + calculate_fee(arg1, arg0.fee_percent);
        if (arg1 > v0) {
            return calculate_output(arg1 - v0, arg0.asset_reserve, arg0.stable_reserve)
        };
        0
    }

    public fun quote_swap_stable_to_asset(arg0: &LiquidityPool, arg1: u64) : u64 {
        let v0 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_fee_bps(), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps()) + calculate_fee(arg1, arg0.fee_percent);
        if (arg1 > v0) {
            return calculate_output(arg1 - v0, arg0.stable_reserve, arg0.asset_reserve)
        };
        0
    }

    public fun remove_liquidity_proportional(arg0: &mut LiquidityPool, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : (u64, u64) {
        assert!(!arg0.has_pending_injection, 17);
        assert!(arg0.lp_supply > 0, 4);
        assert!(arg1 > 0, 6);
        let v0 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, arg0.asset_reserve, arg0.lp_supply);
        let v1 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, arg0.stable_reserve, arg0.lp_supply);
        assert!(v0 > 0 || v1 > 0, 14);
        assert!(arg0.asset_reserve > v0, 1);
        assert!(arg0.stable_reserve > v1, 1);
        assert!(arg0.lp_supply > arg1, 8);
        let v2 = (0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::minimum_liquidity() as u128);
        assert!(0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg0.asset_reserve - v0, arg0.stable_reserve - v1, 1) >= v2 * v2, 0);
        arg0.asset_reserve = arg0.asset_reserve - v0;
        arg0.stable_reserve = arg0.stable_reserve - v1;
        arg0.lp_supply = arg0.lp_supply - arg1;
        let v3 = (arg0.asset_reserve as u128) * (arg0.stable_reserve as u128);
        assert!(v3 < (arg0.asset_reserve as u128) * (arg0.stable_reserve as u128), 12);
        assert!(v3 >= v2 * v2, 0);
        let v4 = LiquidityRemoved{
            market_id     : arg0.market_id,
            outcome       : arg0.outcome_idx,
            asset_amount  : v0,
            stable_amount : v1,
            lp_amount     : arg1,
            sender        : 0x2::tx_context::sender(arg3),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LiquidityRemoved>(v4);
        (v0, v1)
    }

    public fun set_oracle_start_time(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) {
        assert!(get_ms_id(arg0) == arg1, 7);
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::set_oracle_start_time(&mut arg0.oracle, arg2);
    }

    public fun simulate_swap_asset_to_stable(arg0: &LiquidityPool, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        if (arg0.asset_reserve == 0 || arg0.stable_reserve == 0) {
            return 0
        };
        let v0 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_fee_bps(), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps()) + calculate_fee(arg1, arg0.fee_percent);
        if (arg1 > v0) {
            let v1 = calculate_output(arg1 - v0, arg0.asset_reserve, arg0.stable_reserve);
            if (v1 >= arg0.stable_reserve) {
                return 0
            };
            return v1
        };
        0
    }

    public fun simulate_swap_asset_to_stable_feeless(arg0: &LiquidityPool, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        if (arg0.asset_reserve == 0 || arg0.stable_reserve == 0) {
            return 0
        };
        let v0 = calculate_output(arg1, arg0.asset_reserve, arg0.stable_reserve);
        if (v0 >= arg0.stable_reserve) {
            return 0
        };
        v0
    }

    public fun simulate_swap_stable_to_asset(arg0: &LiquidityPool, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        if (arg0.asset_reserve == 0 || arg0.stable_reserve == 0) {
            return 0
        };
        let v0 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_fee_bps(), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps()) + calculate_fee(arg1, arg0.fee_percent);
        if (arg1 > v0) {
            let v1 = calculate_output(arg1 - v0, arg0.stable_reserve, arg0.asset_reserve);
            if (v1 >= arg0.asset_reserve) {
                return 0
            };
            return v1
        };
        0
    }

    public fun simulate_swap_stable_to_asset_feeless(arg0: &LiquidityPool, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        if (arg0.asset_reserve == 0 || arg0.stable_reserve == 0) {
            return 0
        };
        let v0 = calculate_output(arg1, arg0.stable_reserve, arg0.asset_reserve);
        if (v0 >= arg0.asset_reserve) {
            return 0
        };
        v0
    }

    public fun swap_asset_to_stable(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.market_id == arg1, 7);
        assert!(!arg0.has_pending_injection, 17);
        assert!(arg2 > 0, 6);
        let v0 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg2, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_fee_bps(), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps());
        let v1 = calculate_fee(arg2, arg0.fee_percent);
        let v2 = v0 + v1;
        assert!(arg2 > v2, 14);
        let v3 = arg2 - v2;
        let v4 = calculate_output(v3, arg0.asset_reserve, arg0.stable_reserve);
        arg0.protocol_fees_asset = arg0.protocol_fees_asset + v0;
        assert!(v4 >= arg3, 2);
        assert!(v4 < arg0.stable_reserve, 1);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        let v6 = &mut arg0.oracle;
        write_observation(v6, v5, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg0.stable_reserve, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale(), arg0.asset_reserve), arg4);
        let v7 = arg0.asset_reserve + v3 + v1;
        assert!(v7 >= arg0.asset_reserve, 10);
        arg0.asset_reserve = v7;
        arg0.stable_reserve = arg0.stable_reserve - v4;
        assert!((arg0.asset_reserve as u128) * (arg0.stable_reserve as u128) >= (arg0.asset_reserve as u128) * (arg0.stable_reserve as u128), 12);
        let v8 = get_current_price(arg0);
        check_price_under_max(v8);
        let v9 = SwapEvent{
            market_id      : arg0.market_id,
            outcome        : arg0.outcome_idx,
            is_buy         : false,
            amount_in      : arg2,
            amount_out     : v4,
            price_impact   : calculate_price_impact(v3, arg0.asset_reserve, v4, arg0.stable_reserve),
            price          : v8,
            sender         : 0x2::tx_context::sender(arg5),
            asset_reserve  : arg0.asset_reserve,
            stable_reserve : arg0.stable_reserve,
            timestamp      : v5,
        };
        0x2::event::emit<SwapEvent>(v9);
        v4
    }

    fun swap_asset_to_stable_internal(arg0: &mut LiquidityPool, arg1: u64, arg2: bool) : u64 {
        assert!(arg1 > 0, 6);
        assert!(arg0.asset_reserve > 0 && arg0.stable_reserve > 0, 1);
        let (v0, v1, v2) = if (arg2) {
            let v3 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_fee_bps(), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps());
            let v4 = calculate_fee(arg1, arg0.fee_percent);
            let v5 = v3 + v4;
            assert!(arg1 > v5, 14);
            (arg1 - v5, v3, v4)
        } else {
            (arg1, 0, 0)
        };
        let v6 = calculate_output(v0, arg0.asset_reserve, arg0.stable_reserve);
        assert!(v6 < arg0.stable_reserve, 1);
        if (v1 > 0) {
            arg0.protocol_fees_asset = arg0.protocol_fees_asset + v1;
        };
        let v7 = if (arg2) {
            v0 + v2
        } else {
            arg1
        };
        arg0.asset_reserve = arg0.asset_reserve + v7;
        arg0.stable_reserve = arg0.stable_reserve - v6;
        assert!((arg0.asset_reserve as u128) * (arg0.stable_reserve as u128) >= (arg0.asset_reserve as u128) * (arg0.stable_reserve as u128), 12);
        v6
    }

    public fun swap_from_injected_asset_to_stable(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) : u64 {
        assert!(arg0.market_id == arg1, 15);
        assert!(arg0.has_pending_injection, 18);
        assert!(arg2 > 0, 6);
        assert!(arg0.asset_reserve > 0 && arg0.stable_reserve > 0, 1);
        assert!(arg0.asset_reserve >= arg2, 16);
        let v0 = arg0.asset_reserve - arg2;
        assert!(v0 > 0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = &mut arg0.oracle;
        write_observation(v2, v1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg0.stable_reserve, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale(), v0), arg3);
        let v3 = calculate_output(arg2, v0, arg0.stable_reserve);
        assert!(v3 < arg0.stable_reserve, 1);
        let v4 = arg0.asset_reserve;
        let v5 = arg0.stable_reserve - v3;
        let v6 = SwapEvent{
            market_id      : arg0.market_id,
            outcome        : arg0.outcome_idx,
            is_buy         : false,
            amount_in      : arg2,
            amount_out     : v3,
            price_impact   : calculate_price_impact(arg2, v0, v3, arg0.stable_reserve),
            price          : 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(v5, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale(), v4),
            sender         : @0x0,
            asset_reserve  : v4,
            stable_reserve : v5,
            timestamp      : v1,
        };
        0x2::event::emit<SwapEvent>(v6);
        v3
    }

    public fun swap_from_injected_stable_to_asset(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x7b8b388d3e741cad40114dd0644959bbabb3d065a9a657e5d0d43e1445e4fb9f::market_state_mutation_auth::MarketStateMutationAuth) : u64 {
        assert!(arg0.market_id == arg1, 15);
        assert!(arg0.has_pending_injection, 18);
        assert!(arg2 > 0, 6);
        assert!(arg0.asset_reserve > 0 && arg0.stable_reserve > 0, 1);
        assert!(arg0.stable_reserve >= arg2, 16);
        let v0 = arg0.stable_reserve - arg2;
        assert!(v0 > 0, 1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = &mut arg0.oracle;
        write_observation(v2, v1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(v0, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale(), arg0.asset_reserve), arg3);
        let v3 = calculate_output(arg2, v0, arg0.asset_reserve);
        assert!(v3 < arg0.asset_reserve, 1);
        let v4 = arg0.asset_reserve - v3;
        let v5 = arg0.stable_reserve;
        let v6 = SwapEvent{
            market_id      : arg0.market_id,
            outcome        : arg0.outcome_idx,
            is_buy         : true,
            amount_in      : arg2,
            amount_out     : v3,
            price_impact   : calculate_price_impact(arg2, v0, v3, arg0.asset_reserve),
            price          : 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(v5, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale(), v4),
            sender         : @0x0,
            asset_reserve  : v4,
            stable_reserve : v5,
            timestamp      : v1,
        };
        0x2::event::emit<SwapEvent>(v6);
        v3
    }

    public fun swap_stable_to_asset(arg0: &mut LiquidityPool, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.market_id == arg1, 7);
        assert!(!arg0.has_pending_injection, 17);
        assert!(arg2 > 0, 6);
        let v0 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg2, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_fee_bps(), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps());
        let v1 = calculate_fee(arg2, arg0.fee_percent);
        let v2 = v0 + v1;
        assert!(arg2 > v2, 14);
        let v3 = arg2 - v2;
        arg0.protocol_fees_stable = arg0.protocol_fees_stable + v0;
        let v4 = calculate_output(v3, arg0.stable_reserve, arg0.asset_reserve);
        assert!(v4 >= arg3, 2);
        assert!(v4 < arg0.asset_reserve, 1);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        let v6 = &mut arg0.oracle;
        write_observation(v6, v5, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_128(arg0.stable_reserve, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::price_precision_scale(), arg0.asset_reserve), arg4);
        let v7 = arg0.stable_reserve + v3 + v1;
        assert!(v7 >= arg0.stable_reserve, 10);
        arg0.stable_reserve = v7;
        arg0.asset_reserve = arg0.asset_reserve - v4;
        assert!((arg0.asset_reserve as u128) * (arg0.stable_reserve as u128) >= (arg0.asset_reserve as u128) * (arg0.stable_reserve as u128), 12);
        let v8 = get_current_price(arg0);
        check_price_under_max(v8);
        let v9 = SwapEvent{
            market_id      : arg0.market_id,
            outcome        : arg0.outcome_idx,
            is_buy         : true,
            amount_in      : arg2,
            amount_out     : v4,
            price_impact   : calculate_price_impact(v3, arg0.stable_reserve, v4, arg0.asset_reserve),
            price          : v8,
            sender         : 0x2::tx_context::sender(arg5),
            asset_reserve  : arg0.asset_reserve,
            stable_reserve : arg0.stable_reserve,
            timestamp      : v5,
        };
        0x2::event::emit<SwapEvent>(v9);
        v4
    }

    fun swap_stable_to_asset_internal(arg0: &mut LiquidityPool, arg1: u64, arg2: bool) : u64 {
        assert!(arg1 > 0, 6);
        assert!(arg0.asset_reserve > 0 && arg0.stable_reserve > 0, 1);
        let (v0, v1, v2) = if (arg2) {
            let v3 = 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::math::mul_div_to_64(arg1, 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::protocol_fee_bps(), 0x764dad1bf6168a08840578e6478ecd10aa080670592a0ffd158d92f61d7d7174::constants::total_fee_bps());
            let v4 = calculate_fee(arg1, arg0.fee_percent);
            let v5 = v3 + v4;
            assert!(arg1 > v5, 14);
            (arg1 - v5, v3, v4)
        } else {
            (arg1, 0, 0)
        };
        let v6 = calculate_output(v0, arg0.stable_reserve, arg0.asset_reserve);
        assert!(v6 < arg0.asset_reserve, 1);
        if (v1 > 0) {
            arg0.protocol_fees_stable = arg0.protocol_fees_stable + v1;
        };
        let v7 = if (arg2) {
            v0 + v2
        } else {
            arg1
        };
        arg0.stable_reserve = arg0.stable_reserve + v7;
        arg0.asset_reserve = arg0.asset_reserve - v6;
        assert!((arg0.asset_reserve as u128) * (arg0.stable_reserve as u128) >= (arg0.asset_reserve as u128) * (arg0.stable_reserve as u128), 12);
        v6
    }

    fun update_twap_observation(arg0: &mut LiquidityPool, arg1: &0x2::clock::Clock) {
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::write_observation(&mut arg0.oracle, 0x2::clock::timestamp_ms(arg1), get_current_price(arg0), arg1);
    }

    fun write_observation(arg0: &mut 0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::Oracle, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock) {
        0xecce0ded56e58dc48a67c8e821886c1bb27b0a957908321c2ff0e0f467bab843::futarchy_twap_oracle::write_observation(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

