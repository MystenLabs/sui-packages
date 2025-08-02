module 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market {
    struct LiquidityPromise<phantom T0> {
        market_id: u64,
        coin_type: 0x1::type_name::TypeName,
        liquidity_promise: u64,
        fee: u64,
    }

    struct MarketConfigUpdateEvent has copy, drop {
        market_id: u64,
        safe_collateral_ratio: u8,
        liquidation_threshold: u8,
        deposit_limit: u64,
        borrow_limit: u64,
        borrow_limit_percentage: u8,
        partner_cap_required_for_deposit: bool,
        partner_cap_required_for_borrow: bool,
        borrow_fee_bps: u64,
        deposit_fee_bps: u64,
        withdraw_fee_bps: u64,
        collateral_types: vector<0x1::type_name::TypeName>,
        interest_rate_kinks: vector<u8>,
        interest_rates: vector<u64>,
        liquidation_bonus_bps: u64,
        liquidation_fee_bps: u64,
        spread_fee_bps: u64,
        isolated: bool,
        protocol_fee_share_bps: u64,
        protocol_spread_fee_share_bps: u64,
        time_lock: u64,
        last_updated: u64,
        is_native: bool,
        borrow_weight: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        active: bool,
        close_factor_percentage: u8,
        staking_enabled: bool,
    }

    struct MarketDataUpdateEvent has copy, drop {
        market_id: u64,
        coin_type: 0x1::type_name::TypeName,
        xtoken_type: 0x1::type_name::TypeName,
        xtoken_supply: u64,
        xtoken_ratio: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        borrowed_amount: u64,
        writeoff_amount: u64,
        balance_holding: u64,
        unclaimed_spread_fee: u64,
        unclaimed_spread_fee_protocol: u64,
        compounded_interest: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_auto_compound: u64,
        price_identifier: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::PriceIdentifier,
        decimal_digit: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
    }

    struct RepayExceedBorrowEvent has copy, drop {
        market_id: u64,
        repay_amount: u64,
        borrow_amount: u64,
    }

    struct MarketTreasuryUpdateEvent has copy, drop {
        market_id: u64,
        balance: u64,
        supply: u64,
        market_fee: u64,
        protocol_fee: u64,
    }

    struct FeeEarnedEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        market_fee: u64,
        protocol_fee: u64,
    }

    struct FeeEarnedEvent_V2 has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        market_id: u64,
        market_fee: u64,
        protocol_fee: u64,
        is_native: bool,
        fee_type: u8,
    }

    struct FeeEarnedEvent_V3 has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        market_id: u64,
        interest_earned: u64,
        market_fee: u64,
        protocol_fee: u64,
        fee_type: u8,
        is_native: bool,
    }

    struct XToken<phantom T0> has drop, store {
        dummy_field: bool,
    }

    struct TreasuryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuiStakingEnabledKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuiCoinType has copy, drop, store {
        dummy_field: bool,
    }

    struct Treasury<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        supply: 0x2::balance::Supply<XToken<T0>>,
        market_fee: 0x2::balance::Balance<XToken<T0>>,
        protocol_fee: 0x2::balance::Balance<XToken<T0>>,
    }

    struct MarketConfig has store {
        safe_collateral_ratio: u8,
        liquidation_threshold: u8,
        deposit_limit: u64,
        borrow_limit: u64,
        borrow_limit_percentage: u8,
        partner_cap_required_for_deposit: bool,
        partner_cap_required_for_borrow: bool,
        borrow_fee_bps: u64,
        deposit_fee_bps: u64,
        withdraw_fee_bps: u64,
        collateral_types: vector<0x1::type_name::TypeName>,
        interest_rate_kinks: vector<u8>,
        interest_rates: vector<u64>,
        liquidation_bonus_bps: u64,
        liquidation_fee_bps: u64,
        spread_fee_bps: u64,
        isolated: bool,
        protocol_fee_share_bps: u64,
        protocol_spread_fee_share_bps: u64,
        time_lock: u64,
        last_updated: u64,
        is_native: bool,
        borrow_weight: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        extension_fields: 0x2::bag::Bag,
        active: bool,
        close_factor_percentage: u8,
        staking_enabled: bool,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        market_id: u64,
        coin_type: 0x1::type_name::TypeName,
        xtoken_type: 0x1::type_name::TypeName,
        xtoken_supply: u64,
        xtoken_ratio: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        borrowed_amount: u64,
        writeoff_amount: u64,
        balance_holding: u64,
        unclaimed_spread_fee: u64,
        unclaimed_spread_fee_protocol: u64,
        compounded_interest: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_auto_compound: u64,
        config: MarketConfig,
        price_identifier: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::PriceIdentifier,
        deposit_reward_distributor: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::RewardDistributor,
        borrow_reward_distributor: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::RewardDistributor,
        deposit_flow_limiter: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::FlowLimiter,
        outflow_limiter: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::FlowLimiter,
        decimal_digit: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        market_cap_id: 0x2::object::ID,
    }

    struct MarketCap has store, key {
        id: 0x2::object::UID,
        market_id: u64,
        client_address: address,
    }

    public(friend) fun borrow<T0>(arg0: &mut Market, arg1: u64, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x2::clock::Clock) : LiquidityPromise<T0> {
        assert!(arg0.coin_type == 0x1::type_name::get<T0>(), 5);
        refresh_with_price(arg0, arg2, arg3);
        verify_borrow_limit(arg0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::check_and_update(&mut arg0.outflow_limiter, arg1, arg3);
        let v0 = TreasuryKey{dummy_field: false};
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>() && arg0.config.staking_enabled) {
            let v1 = SuiStakingEnabledKey{dummy_field: false};
            assert!(arg1 <= 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::get_staked_sui_count(0x2::dynamic_field::borrow_mut<SuiStakingEnabledKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::SuiStaker>(&mut arg0.id, v1)) + 0x2::balance::value<T0>(&0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v0).balance), 42);
        } else {
            assert!(arg1 <= 0x2::balance::value<T0>(&0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v0).balance), 4);
        };
        arg0.borrowed_amount = arg0.borrowed_amount + arg1;
        let v2 = LiquidityPromise<T0>{
            market_id         : arg0.market_id,
            coin_type         : arg0.coin_type,
            liquidity_promise : arg1,
            fee               : 0,
        };
        emit_market_data_update_event(arg0);
        v2
    }

    public(friend) fun add_fee<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<XToken<T0>>) {
        let v0 = get_xtoken_ratio(arg0);
        let v1 = TreasuryKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v1);
        let v3 = 0x2::balance::value<XToken<T0>>(&arg1);
        let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::bps_round_up(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v3), arg0.config.protocol_fee_share_bps));
        let v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v4), v0));
        let v6 = FeeEarnedEvent_V2{
            coin_type    : 0x1::type_name::get<T0>(),
            market_id    : arg0.market_id,
            market_fee   : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v3), v0)) - v5,
            protocol_fee : v5,
            is_native    : arg0.config.is_native,
            fee_type     : 1,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<FeeEarnedEvent_V2>(v6);
        0x2::balance::join<XToken<T0>>(&mut v2.protocol_fee, 0x2::balance::split<XToken<T0>>(&mut arg1, v4));
        0x2::balance::join<XToken<T0>>(&mut v2.market_fee, arg1);
        emit_market_treasury_update_event<T0>(arg0.market_id, v2);
        emit_market_data_update_event(arg0);
    }

    public(friend) fun add_liquidity<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<XToken<T0>> {
        refresh(arg0, arg2);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::check_and_update(&mut arg0.deposit_flow_limiter, 0x2::coin::value<T0>(&arg1), arg2);
        let v0 = add_liquidity_to_treasury<T0>(arg0, arg1, arg2);
        emit_market_data_update_event(arg0);
        v0
    }

    fun add_liquidity_to_treasury<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<XToken<T0>> {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.last_auto_compound + 1000, 3);
        let v0 = TreasuryKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v0);
        arg0.xtoken_supply = 0x2::balance::supply_value<XToken<T0>>(&v1.supply);
        0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.balance_holding = arg0.balance_holding + 0x2::coin::value<T0>(&arg1);
        emit_market_treasury_update_event<T0>(arg0.market_id, v1);
        0x2::balance::increase_supply<XToken<T0>>(&mut v1.supply, (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::coin::value<T0>(&arg1)), arg0.xtoken_ratio)) as u64))
    }

    public(friend) fun add_reward<T0>(arg0: &mut Market, arg1: &MarketCap, arg2: bool, arg3: 0x2::balance::Balance<T0>, arg4: 0x1::type_name::TypeName, arg5: bool, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        verify_market_cap(arg0, arg1);
        assert!(arg1.market_id == arg0.market_id, 7);
        if (arg2 == true) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh(&mut arg0.deposit_reward_distributor, arg9);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::add_reward<T0>(&mut arg0.deposit_reward_distributor, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        } else {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh(&mut arg0.borrow_reward_distributor, arg9);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::add_reward<T0>(&mut arg0.borrow_reward_distributor, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        };
    }

    public(friend) fun burn_xtokens_generate_promise<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<XToken<T0>>, arg2: &0x2::clock::Clock) : LiquidityPromise<T0> {
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.last_auto_compound + 1000, 3);
        let v0 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<XToken<T0>>(&arg1)), arg0.xtoken_ratio);
        assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v0) <= arg0.balance_holding, 14);
        let v1 = TreasuryKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v1);
        0x2::balance::decrease_supply<XToken<T0>>(&mut v2.supply, arg1);
        arg0.xtoken_supply = 0x2::balance::supply_value<XToken<T0>>(&v2.supply);
        let v3 = LiquidityPromise<T0>{
            market_id         : arg0.market_id,
            coin_type         : arg0.coin_type,
            liquidity_promise : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v0),
            fee               : 0,
        };
        emit_market_treasury_update_event<T0>(arg0.market_id, v2);
        v3
    }

    fun calculate_current_interest_rate_apr(arg0: &Market) : u64 {
        let v0 = (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_percentage(get_current_utilization_rate(arg0)) as u8);
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(&arg0.config.interest_rate_kinks)) {
            if (v0 >= *0x1::vector::borrow<u8>(&arg0.config.interest_rate_kinks, v1)) {
                v1 = v1 + 1;
                continue
            };
            let v2 = *0x1::vector::borrow<u64>(&arg0.config.interest_rates, v1 - 1);
            let v3 = *0x1::vector::borrow<u8>(&arg0.config.interest_rate_kinks, v1 - 1);
            return (((v2 as u32) + ((*0x1::vector::borrow<u64>(&arg0.config.interest_rates, v1) as u32) - (v2 as u32)) * ((v0 as u32) - (v3 as u32)) / ((*0x1::vector::borrow<u8>(&arg0.config.interest_rate_kinks, v1) as u32) - (v3 as u32))) as u64)
        };
        *0x1::vector::borrow<u64>(&arg0.config.interest_rates, 0x1::vector::length<u8>(&arg0.config.interest_rate_kinks) - 1)
    }

    public(friend) fun collect_staking_rewards(arg0: &mut Market, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = SuiStakingEnabledKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<SuiStakingEnabledKey>(&arg0.id, v0), 43);
        let v1 = SuiStakingEnabledKey{dummy_field: false};
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::collect_fees(0x2::dynamic_field::borrow_mut<SuiStakingEnabledKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::SuiStaker>(&mut arg0.id, v1), arg1, arg2)
    }

    public(friend) fun compound_interest(arg0: &mut Market, arg1: &0x2::clock::Clock) {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.last_auto_compound) / 1000;
        if (v0 == 0) {
            return
        };
        if (arg0.borrowed_amount == 0) {
            arg0.last_auto_compound = arg0.last_auto_compound + v0 * 1000;
            return
        };
        let v1 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::pow(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::per_second_from_apr(calculate_current_interest_rate_apr(arg0))), v0);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.borrowed_amount), v1));
        if (v2 > arg0.borrowed_amount) {
            let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2 - arg0.borrowed_amount), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg0.config.spread_fee_bps));
            let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v3, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg0.config.protocol_spread_fee_share_bps)));
            arg0.unclaimed_spread_fee_protocol = arg0.unclaimed_spread_fee_protocol + v4;
            arg0.unclaimed_spread_fee = arg0.unclaimed_spread_fee + 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v3) - v4;
            let v5 = FeeEarnedEvent_V3{
                coin_type       : arg0.coin_type,
                market_id       : arg0.market_id,
                interest_earned : v2 - arg0.borrowed_amount,
                market_fee      : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v3) - v4,
                protocol_fee    : v4,
                fee_type        : 0,
                is_native       : arg0.config.is_native,
            };
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<FeeEarnedEvent_V3>(v5);
        };
        arg0.borrowed_amount = v2;
        arg0.compounded_interest = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0.compounded_interest, v1);
        arg0.last_auto_compound = arg0.last_auto_compound + v0 * 1000;
    }

    public(friend) fun create_empty_promise<T0>() : LiquidityPromise<T0> {
        LiquidityPromise<T0>{
            market_id         : 0,
            coin_type         : 0x1::type_name::get<T0>(),
            liquidity_promise : 0,
            fee               : 0,
        }
    }

    public(friend) fun create_market<T0>(arg0: u64, arg1: 0x1::type_name::TypeName, arg2: 0x2::balance::Balance<T0>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::PriceIdentifier, arg12: vector<0x1::type_name::TypeName>, arg13: vector<u8>, arg14: vector<u64>, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: u64, arg20: u64, arg21: bool, arg22: u8, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : (Market, MarketCap) {
        assert!(arg0 != 0, 22);
        assert!(arg19 <= 10000, 8);
        let v0 = if (arg8 <= 10000) {
            if (arg9 <= 10000) {
                if (arg10 <= 10000) {
                    arg17 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 16);
        assert!(0x2::balance::value<T0>(&arg2) == 0, 24);
        if (arg18 || arg21 == false) {
            assert!(arg3 == 0 && arg4 == 0, 27);
        };
        validate_interest_rates(arg14, arg13);
        let v1 = XToken<T0>{dummy_field: false};
        let v2 = Treasury<T0>{
            balance      : 0x2::balance::zero<T0>(),
            supply       : 0x2::balance::create_supply<XToken<T0>>(v1),
            market_fee   : 0x2::balance::zero<XToken<T0>>(),
            protocol_fee : 0x2::balance::zero<XToken<T0>>(),
        };
        let v3 = MarketConfig{
            safe_collateral_ratio            : arg3,
            liquidation_threshold            : arg4,
            deposit_limit                    : arg5,
            borrow_limit                     : arg6,
            borrow_limit_percentage          : arg7,
            partner_cap_required_for_deposit : false,
            partner_cap_required_for_borrow  : false,
            borrow_fee_bps                   : arg8,
            deposit_fee_bps                  : arg9,
            withdraw_fee_bps                 : arg10,
            collateral_types                 : arg12,
            interest_rate_kinks              : arg13,
            interest_rates                   : arg14,
            liquidation_bonus_bps            : arg15,
            liquidation_fee_bps              : arg16,
            spread_fee_bps                   : arg17,
            isolated                         : arg18,
            protocol_fee_share_bps           : arg19,
            protocol_spread_fee_share_bps    : arg20,
            time_lock                        : 0x2::clock::timestamp_ms(arg23) + 86400000,
            last_updated                     : 0x2::clock::timestamp_ms(arg23),
            is_native                        : arg21,
            borrow_weight                    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(10000),
            extension_fields                 : 0x2::bag::new(arg24),
            active                           : true,
            close_factor_percentage          : 20,
            staking_enabled                  : false,
        };
        let v4 = MarketCap{
            id             : 0x2::object::new(arg24),
            market_id      : arg0,
            client_address : 0x2::tx_context::sender(arg24),
        };
        let v5 = Market{
            id                            : 0x2::object::new(arg24),
            market_id                     : arg0,
            coin_type                     : arg1,
            xtoken_type                   : 0x1::type_name::get<XToken<T0>>(),
            xtoken_supply                 : 0,
            xtoken_ratio                  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1),
            borrowed_amount               : 0,
            writeoff_amount               : 0,
            balance_holding               : 0,
            unclaimed_spread_fee          : 0,
            unclaimed_spread_fee_protocol : 0,
            compounded_interest           : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1),
            last_auto_compound            : 0x2::clock::timestamp_ms(arg23) / 1000 * 1000,
            config                        : v3,
            price_identifier              : arg11,
            deposit_reward_distributor    : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::create_reward_distributor(arg24, arg0),
            borrow_reward_distributor     : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::create_reward_distributor(arg24, arg0),
            deposit_flow_limiter          : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::new(0, 0, arg23),
            outflow_limiter               : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::new(0, 0, arg23),
            decimal_digit                 : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::pow(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10), (arg22 as u64)),
            market_cap_id                 : 0x2::object::id<MarketCap>(&v4),
        };
        let v6 = TreasuryKey{dummy_field: false};
        0x2::dynamic_field::add<TreasuryKey, Treasury<T0>>(&mut v5.id, v6, v2);
        let v7 = &mut v5;
        emit_market_data_update_event(&v5);
        validate_collateral_ratios(&v5.config);
        validate_liquidation_config(&v5.config);
        0x2::balance::destroy_zero<XToken<T0>>(add_liquidity_to_treasury<T0>(v7, 0x2::coin::from_balance<T0>(arg2, arg24), arg23));
        (v5, v4)
    }

    public(friend) fun deposit_limit_exceeded(arg0: &Market, arg1: u64) : bool {
        arg0.balance_holding + arg0.borrowed_amount + arg1 > arg0.config.deposit_limit
    }

    public(friend) fun destory_zero<T0>(arg0: LiquidityPromise<T0>) {
        assert!(arg0.market_id == 0, 39);
        let LiquidityPromise {
            market_id         : _,
            coin_type         : _,
            liquidity_promise : _,
            fee               : _,
        } = arg0;
    }

    fun emit_market_data_update_event(arg0: &Market) {
        let v0 = MarketDataUpdateEvent{
            market_id                     : arg0.market_id,
            coin_type                     : arg0.coin_type,
            xtoken_type                   : arg0.xtoken_type,
            xtoken_supply                 : arg0.xtoken_supply,
            xtoken_ratio                  : arg0.xtoken_ratio,
            borrowed_amount               : arg0.borrowed_amount,
            writeoff_amount               : arg0.writeoff_amount,
            balance_holding               : arg0.balance_holding,
            unclaimed_spread_fee          : arg0.unclaimed_spread_fee,
            unclaimed_spread_fee_protocol : arg0.unclaimed_spread_fee_protocol,
            compounded_interest           : arg0.compounded_interest,
            last_auto_compound            : arg0.last_auto_compound,
            price_identifier              : arg0.price_identifier,
            decimal_digit                 : arg0.decimal_digit,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<MarketDataUpdateEvent>(v0);
    }

    fun emit_market_treasury_update_event<T0>(arg0: u64, arg1: &Treasury<T0>) {
        let v0 = MarketTreasuryUpdateEvent{
            market_id    : arg0,
            balance      : 0x2::balance::value<T0>(&arg1.balance),
            supply       : 0x2::balance::supply_value<XToken<T0>>(&arg1.supply),
            market_fee   : 0x2::balance::value<XToken<T0>>(&arg1.market_fee),
            protocol_fee : 0x2::balance::value<XToken<T0>>(&arg1.protocol_fee),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<MarketTreasuryUpdateEvent>(v0);
    }

    public fun emit_repay_exceed_borrow_event(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = RepayExceedBorrowEvent{
            market_id     : arg0,
            repay_amount  : arg1,
            borrow_amount : arg2,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<RepayExceedBorrowEvent>(v0);
    }

    public(friend) fun fulfill_promise<T0>(arg0: &mut Market, arg1: LiquidityPromise<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg1.market_id == arg0.market_id, 33);
        let v0 = TreasuryKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::balance::split<T0>(&mut v1.balance, arg1.liquidity_promise);
        let v3 = 0x2::balance::split<T0>(&mut v1.balance, arg1.fee);
        arg0.balance_holding = arg0.balance_holding - arg1.liquidity_promise - arg1.fee;
        emit_market_treasury_update_event<T0>(arg0.market_id, v1);
        refresh(arg0, arg2);
        assert!(arg1.liquidity_promise == 0x2::balance::value<T0>(&v2), 37);
        assert!(arg1.fee == 0x2::balance::value<T0>(&v3), 38);
        let LiquidityPromise {
            market_id         : _,
            coin_type         : _,
            liquidity_promise : _,
            fee               : _,
        } = arg1;
        (0x2::coin::from_balance<T0>(v2, arg3), 0x2::coin::from_balance<T0>(v3, arg3))
    }

    public(friend) fun fulfill_promise_sui(arg0: &mut Market, arg1: LiquidityPromise<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg1.market_id == arg0.market_id, 33);
        let v0 = TreasuryKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<0x2::sui::SUI>>(&mut arg0.id, v0);
        let v2 = arg1.liquidity_promise + arg1.fee;
        let v3 = if (v2 < 0x2::balance::value<0x2::sui::SUI>(&v1.balance)) {
            0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, v2)
        } else {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.balance)
        };
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4);
        let v5 = v2 - 0x2::coin::value<0x2::sui::SUI>(&v4);
        if (arg0.config.staking_enabled && 0x2::balance::value<0x2::sui::SUI>(&v1.balance) > 0) {
            let v6 = SuiStakingEnabledKey{dummy_field: false};
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::add_stake(0x2::dynamic_field::borrow_mut<SuiStakingEnabledKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::SuiStaker>(&mut arg0.id, v6), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.balance), arg4), arg2, arg4);
        };
        if (v5 > 0) {
            let v7 = SuiStakingEnabledKey{dummy_field: false};
            0x2::coin::join<0x2::sui::SUI>(&mut v4, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::remove_stake(0x2::dynamic_field::borrow_mut<SuiStakingEnabledKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::SuiStaker>(&mut arg0.id, v7), v5, arg2, arg4));
        };
        arg0.balance_holding = arg0.balance_holding - v2;
        refresh(arg0, arg3);
        let v8 = TreasuryKey{dummy_field: false};
        emit_market_treasury_update_event<0x2::sui::SUI>(arg0.market_id, 0x2::dynamic_field::borrow<TreasuryKey, Treasury<0x2::sui::SUI>>(&arg0.id, v8));
        assert!(arg1.liquidity_promise + arg1.fee == 0x2::coin::value<0x2::sui::SUI>(&v4), 37);
        let LiquidityPromise {
            market_id         : _,
            coin_type         : _,
            liquidity_promise : _,
            fee               : _,
        } = arg1;
        (v4, 0x2::coin::split<0x2::sui::SUI>(&mut v4, arg1.fee, arg4))
    }

    fun generate_market_config_update_event(arg0: u64, arg1: &MarketConfig) {
        let v0 = MarketConfigUpdateEvent{
            market_id                        : arg0,
            safe_collateral_ratio            : arg1.safe_collateral_ratio,
            liquidation_threshold            : arg1.liquidation_threshold,
            deposit_limit                    : arg1.deposit_limit,
            borrow_limit                     : arg1.borrow_limit,
            borrow_limit_percentage          : arg1.borrow_limit_percentage,
            partner_cap_required_for_deposit : arg1.partner_cap_required_for_deposit,
            partner_cap_required_for_borrow  : arg1.partner_cap_required_for_borrow,
            borrow_fee_bps                   : arg1.borrow_fee_bps,
            deposit_fee_bps                  : arg1.deposit_fee_bps,
            withdraw_fee_bps                 : arg1.withdraw_fee_bps,
            collateral_types                 : arg1.collateral_types,
            interest_rate_kinks              : arg1.interest_rate_kinks,
            interest_rates                   : arg1.interest_rates,
            liquidation_bonus_bps            : arg1.liquidation_bonus_bps,
            liquidation_fee_bps              : arg1.liquidation_fee_bps,
            spread_fee_bps                   : arg1.spread_fee_bps,
            isolated                         : arg1.isolated,
            protocol_fee_share_bps           : arg1.protocol_fee_share_bps,
            protocol_spread_fee_share_bps    : arg1.protocol_spread_fee_share_bps,
            time_lock                        : arg1.time_lock,
            last_updated                     : arg1.last_updated,
            is_native                        : arg1.is_native,
            borrow_weight                    : arg1.borrow_weight,
            active                           : arg1.active,
            close_factor_percentage          : arg1.close_factor_percentage,
            staking_enabled                  : arg1.staking_enabled,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<MarketConfigUpdateEvent>(v0);
    }

    public(friend) fun generate_new_market_cap(arg0: &mut Market, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : MarketCap {
        let v0 = MarketCap{
            id             : 0x2::object::new(arg2),
            market_id      : arg0.market_id,
            client_address : arg1,
        };
        arg0.market_cap_id = 0x2::object::id<MarketCap>(&v0);
        v0
    }

    public(friend) fun get_active(arg0: &Market) : bool {
        arg0.config.active
    }

    public(friend) fun get_borrow_fee_bps(arg0: &Market) : u64 {
        arg0.config.borrow_fee_bps
    }

    public(friend) fun get_borrow_reward_distributor(arg0: &mut Market) : &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::RewardDistributor {
        &mut arg0.borrow_reward_distributor
    }

    public(friend) fun get_borrow_weight(arg0: &Market) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.config.borrow_weight
    }

    public(friend) fun get_close_factor_percentage(arg0: &Market) : u8 {
        arg0.config.close_factor_percentage
    }

    public(friend) fun get_coin_type(arg0: &Market) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun get_compounded_interest(arg0: &Market) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.compounded_interest
    }

    fun get_current_utilization_rate(arg0: &Market) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (total_liquidity(arg0) == 0) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
        } else if ((arg0.borrowed_amount as u128) > total_liquidity(arg0)) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.borrowed_amount), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(total_liquidity(arg0)))
        }
    }

    public(friend) fun get_deposit_fee_bps(arg0: &Market) : u64 {
        arg0.config.deposit_fee_bps
    }

    public(friend) fun get_deposit_reward_distributor(arg0: &mut Market) : &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::RewardDistributor {
        &mut arg0.deposit_reward_distributor
    }

    public(friend) fun get_id(arg0: &Market) : u64 {
        arg0.market_id
    }

    public(friend) fun get_is_native(arg0: &Market) : bool {
        arg0.config.is_native
    }

    public(friend) fun get_last_auto_compound(arg0: &Market) : u64 {
        arg0.last_auto_compound
    }

    public(friend) fun get_liquidation_bonus_bps(arg0: &Market) : u64 {
        arg0.config.liquidation_bonus_bps
    }

    public(friend) fun get_liquidation_fee_bps(arg0: &Market) : u64 {
        arg0.config.liquidation_fee_bps
    }

    public(friend) fun get_liquidation_value(arg0: &Market, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((arg0.config.liquidation_threshold as u16)))
    }

    public(friend) fun get_liquidity_promise<T0>(arg0: &LiquidityPromise<T0>) : u64 {
        arg0.liquidity_promise
    }

    public(friend) fun get_ltv_value(arg0: &Market, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((arg0.config.safe_collateral_ratio as u16)))
    }

    public(friend) fun get_market_id(arg0: &MarketCap) : u64 {
        arg0.market_id
    }

    public(friend) fun get_promise_coin_type<T0>(arg0: &LiquidityPromise<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public(friend) fun get_promise_market_id<T0>(arg0: &LiquidityPromise<T0>) : u64 {
        arg0.market_id
    }

    public(friend) fun get_safe_collateral_ratio(arg0: &Market) : u8 {
        arg0.config.safe_collateral_ratio
    }

    public(friend) fun get_spot_usd_value(arg0: &Market, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg2: u64) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg2), get_token_spot_price(arg0, arg1))
    }

    public(friend) fun get_supply<T0>() : 0x2::balance::Supply<XToken<T0>> {
        let v0 = XToken<T0>{dummy_field: false};
        0x2::balance::create_supply<XToken<T0>>(v0)
    }

    public(friend) fun get_token_count(arg0: &Market, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg2: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let (v0, _) = get_token_price(arg0, arg1);
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(arg2, v0)
    }

    public(friend) fun get_token_price(arg0: &Market, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle) : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::get_price(arg1, &arg0.price_identifier);
        (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v0, arg0.decimal_digit), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v1, arg0.decimal_digit))
    }

    public(friend) fun get_token_price_for_collateral(arg0: &Market, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle) : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) {
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::get_price(arg1, &arg0.price_identifier);
        (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v0, arg0.decimal_digit), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v1, arg0.decimal_digit))
    }

    public(friend) fun get_token_spot_price(arg0: &Market, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let (v0, _) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::get_price(arg1, &arg0.price_identifier);
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v0, arg0.decimal_digit)
    }

    public(friend) fun get_withdrawl_fee_bps(arg0: &Market) : u64 {
        arg0.config.withdraw_fee_bps
    }

    public(friend) fun get_xtoken_price(arg0: &Market, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let (v0, v1) = get_token_price(arg0, arg1);
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0.xtoken_ratio, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(v0, v1))
    }

    public(friend) fun get_xtoken_ratio(arg0: &Market) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.xtoken_ratio
    }

    public(friend) fun get_xtoken_spot_price(arg0: &Market, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        let (v0, _) = get_token_price(arg0, arg1);
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0.xtoken_ratio, v0)
    }

    public(friend) fun is_isolated(arg0: &Market) : bool {
        arg0.config.isolated
    }

    public(friend) fun join_promise<T0>(arg0: &mut LiquidityPromise<T0>, arg1: LiquidityPromise<T0>) {
        let v0 = if (arg0.market_id == arg1.market_id) {
            true
        } else if (arg0.market_id == 0) {
            true
        } else {
            arg1.market_id == 0
        };
        assert!(v0, 33);
        if (arg0.market_id == 0) {
            arg0.market_id = arg1.market_id;
            arg0.coin_type = arg1.coin_type;
        };
        arg0.liquidity_promise = arg0.liquidity_promise + arg1.liquidity_promise;
        arg0.fee = arg0.fee + arg1.fee;
        let LiquidityPromise {
            market_id         : _,
            coin_type         : _,
            liquidity_promise : _,
            fee               : _,
        } = arg1;
    }

    public(friend) fun refresh(arg0: &mut Market, arg1: &0x2::clock::Clock) {
        if (0x2::clock::timestamp_ms(arg1) < arg0.last_auto_compound + 1000 && arg0.writeoff_amount == 0) {
            return
        };
        compound_interest(arg0, arg1);
        set_xtoken_ratio_rounded_down(arg0);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh(&mut arg0.deposit_reward_distributor, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh(&mut arg0.borrow_reward_distributor, arg1);
        emit_market_data_update_event(arg0);
    }

    public(friend) fun refresh_with_price(arg0: &mut Market, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg2: &0x2::clock::Clock) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::verify_price(arg1, &arg0.price_identifier, arg2);
        refresh(arg0, arg2);
    }

    public(friend) fun remove_liquidity<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<XToken<T0>>, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x2::clock::Clock) : LiquidityPromise<T0> {
        refresh_with_price(arg0, arg2, arg3);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::check_and_update(&mut arg0.outflow_limiter, 0x2::balance::value<XToken<T0>>(&arg1), arg3);
        let v0 = burn_xtokens_generate_promise<T0>(arg0, arg1, arg3);
        emit_market_data_update_event(arg0);
        v0
    }

    public(friend) fun repay<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x1::type_name::get<T0>() == arg0.coin_type, 5);
        refresh(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (v0 <= arg0.borrowed_amount) {
            arg0.borrowed_amount = arg0.borrowed_amount - v0;
        } else {
            arg0.unclaimed_spread_fee = arg0.unclaimed_spread_fee + v0 - arg0.borrowed_amount;
            arg0.borrowed_amount = 0;
            emit_repay_exceed_borrow_event(arg0.market_id, v0, arg0.borrowed_amount);
        };
        let v1 = TreasuryKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v1);
        0x2::balance::join<T0>(&mut v2.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.balance_holding = arg0.balance_holding + v0;
        emit_market_treasury_update_event<T0>(arg0.market_id, v2);
        emit_market_data_update_event(arg0);
    }

    public(friend) fun set_market_active(arg0: &mut Market, arg1: &MarketCap, arg2: bool, arg3: &0x2::clock::Clock) {
        verify_market_cap(arg0, arg1);
        verify_time_lock(arg0, arg3);
        arg0.config.active = arg2;
        let v0 = &mut arg0.config;
        update_config_timestamp(v0, arg3);
    }

    public(friend) fun set_sui_staking_enabled(arg0: &mut Market, arg1: address, arg2: bool, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.coin_type == 0x1::type_name::get<0x2::sui::SUI>(), 36);
        if (arg2) {
            assert!(arg0.config.staking_enabled == false, 34);
            arg0.config.staking_enabled = true;
            let v0 = TreasuryKey{dummy_field: false};
            let v1 = 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<0x2::sui::SUI>>(&mut arg0.id, v0);
            let v2 = SuiStakingEnabledKey{dummy_field: false};
            if (0x2::dynamic_field::exists_<SuiStakingEnabledKey>(&arg0.id, v2)) {
                let v3 = SuiStakingEnabledKey{dummy_field: false};
                0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::delete_sui_staker(0x2::dynamic_field::remove<SuiStakingEnabledKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::SuiStaker>(&mut arg0.id, v3));
            };
            let v4 = SuiStakingEnabledKey{dummy_field: false};
            0x2::dynamic_field::add<SuiStakingEnabledKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::SuiStaker>(&mut arg0.id, v4, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::init_staker(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.balance, 0x2::balance::value<0x2::sui::SUI>(&v1.balance)), arg4), arg3, arg4));
        } else {
            assert!(arg0.config.staking_enabled == true, 35);
            arg0.config.staking_enabled = false;
            let v5 = SuiStakingEnabledKey{dummy_field: false};
            if (0x2::dynamic_field::exists_<SuiStakingEnabledKey>(&arg0.id, v5)) {
                let v6 = SuiStakingEnabledKey{dummy_field: false};
                let v7 = TreasuryKey{dummy_field: false};
                0x2::balance::join<0x2::sui::SUI>(&mut 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<0x2::sui::SUI>>(&mut arg0.id, v7).balance, 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::remove_stake(0x2::dynamic_field::borrow_mut<SuiStakingEnabledKey, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::sui_staker::SuiStaker>(&mut arg0.id, v6), arg0.balance_holding, arg3, arg4)));
            };
        };
    }

    public(friend) fun set_time_lock(arg0: &mut Market, arg1: &MarketCap, arg2: u64, arg3: &0x2::clock::Clock) {
        verify_market_cap(arg0, arg1);
        verify_time_lock(arg0, arg3);
        assert!(arg2 > 0x2::clock::timestamp_ms(arg3), 41);
        arg0.config.time_lock = arg2;
    }

    fun set_xtoken_ratio_rounded_down(arg0: &mut Market) {
        let v0 = if (arg0.xtoken_supply == 0) {
            if (total_liquidity(arg0) != 0) {
                arg0.unclaimed_spread_fee = arg0.unclaimed_spread_fee + (total_liquidity(arg0) as u64);
            };
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(total_liquidity(arg0)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.xtoken_supply))
        };
        if (arg0.writeoff_amount == 0 && arg0.xtoken_supply != 0) {
            assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::ge(v0, arg0.xtoken_ratio), 23);
        } else if (arg0.writeoff_amount != 0) {
            arg0.borrowed_amount = arg0.borrowed_amount - arg0.writeoff_amount;
            arg0.writeoff_amount = 0;
        };
        arg0.xtoken_ratio = v0;
    }

    public(friend) fun split_promise_market_fee<T0>(arg0: &mut LiquidityPromise<T0>, arg1: u64) {
        arg0.liquidity_promise = arg0.liquidity_promise - arg1;
        arg0.fee = arg1;
    }

    fun total_liquidity(arg0: &Market) : u128 {
        if ((arg0.balance_holding as u128) + (arg0.borrowed_amount as u128) >= (arg0.unclaimed_spread_fee as u128) + (arg0.writeoff_amount as u128) + (arg0.unclaimed_spread_fee_protocol as u128)) {
            (arg0.balance_holding as u128) + (arg0.borrowed_amount as u128) - (arg0.unclaimed_spread_fee as u128) + (arg0.writeoff_amount as u128) + (arg0.unclaimed_spread_fee_protocol as u128)
        } else {
            0
        }
    }

    public(friend) fun update_collateral_ratios(arg0: &mut Market, arg1: &MarketCap, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(!arg0.config.isolated && arg0.config.is_native, 27);
        verify_market_cap(arg0, arg1);
        verify_time_lock(arg0, arg4);
        if (arg0.config.liquidation_threshold > arg3 && arg0.balance_holding > 0) {
            assert!(arg0.config.liquidation_threshold - arg3 < 2, 27);
        };
        arg0.config.safe_collateral_ratio = arg2;
        arg0.config.liquidation_threshold = arg3;
        validate_collateral_ratios(&arg0.config);
        validate_liquidation_config(&arg0.config);
        let v0 = &mut arg0.config;
        update_config_timestamp(v0, arg4);
        generate_market_config_update_event(arg0.market_id, &arg0.config);
    }

    fun update_config_timestamp(arg0: &mut MarketConfig, arg1: &0x2::clock::Clock) {
        arg0.last_updated = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun update_fee_config(arg0: &mut Market, arg1: &MarketCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        verify_market_cap(arg0, arg1);
        verify_time_lock(arg0, arg7);
        refresh(arg0, arg7);
        let v0 = if (arg2 <= 10000) {
            if (arg3 <= 10000) {
                if (arg4 <= 10000) {
                    arg5 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 16);
        assert!(arg6 >= 10000 && arg6 <= 100000, 26);
        let v1 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0.config.borrow_weight, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10000)));
        if (arg0.borrowed_amount > 0 && arg6 > v1) {
            assert!(arg6 - v1 <= 1000, 16);
        };
        arg0.config.borrow_fee_bps = arg2;
        arg0.config.deposit_fee_bps = arg3;
        arg0.config.withdraw_fee_bps = arg4;
        arg0.config.spread_fee_bps = arg5;
        arg0.config.borrow_weight = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg6);
        let v2 = &mut arg0.config;
        update_config_timestamp(v2, arg7);
        generate_market_config_update_event(arg0.market_id, &arg0.config);
    }

    public(friend) fun update_flow_limiter(arg0: &mut Market, arg1: bool, arg2: u64, arg3: u64, arg4: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg5: &0x2::clock::Clock) {
        assert!(arg3 >= 1000, 11);
        if (arg2 != 0) {
            let (v0, _) = get_token_price(arg0, arg4);
            assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg2), v0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1000 * 60 * 60), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3)))) <= 1000000, 12);
        };
        if (arg1) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::update_config(&mut arg0.deposit_flow_limiter, arg2, arg3, arg5);
        } else {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter::update_config(&mut arg0.outflow_limiter, arg2, arg3, arg5);
        };
    }

    public(friend) fun update_interest_rate_config(arg0: &mut Market, arg1: &MarketCap, arg2: vector<u8>, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        verify_market_cap(arg0, arg1);
        verify_time_lock(arg0, arg4);
        validate_interest_rates(arg3, arg2);
        refresh(arg0, arg4);
        arg0.config.interest_rate_kinks = arg2;
        arg0.config.interest_rates = arg3;
        let v0 = &mut arg0.config;
        update_config_timestamp(v0, arg4);
        generate_market_config_update_event(arg0.market_id, &arg0.config);
    }

    public(friend) fun update_limits(arg0: &mut Market, arg1: u64, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock) {
        verify_time_lock(arg0, arg4);
        assert!(arg3 <= 100, 31);
        arg0.config.deposit_limit = arg1;
        arg0.config.borrow_limit = arg2;
        arg0.config.borrow_limit_percentage = arg3;
        let v0 = &mut arg0.config;
        update_config_timestamp(v0, arg4);
        generate_market_config_update_event(arg0.market_id, &arg0.config);
    }

    public(friend) fun update_liquidation_config(arg0: &mut Market, arg1: &MarketCap, arg2: u64, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock) {
        verify_market_cap(arg0, arg1);
        verify_time_lock(arg0, arg5);
        arg0.config.liquidation_bonus_bps = arg2;
        arg0.config.liquidation_fee_bps = arg3;
        arg0.config.close_factor_percentage = arg4;
        validate_liquidation_config(&arg0.config);
        let v0 = &mut arg0.config;
        update_config_timestamp(v0, arg5);
        generate_market_config_update_event(arg0.market_id, &arg0.config);
    }

    public(friend) fun update_market_isolation(arg0: &mut Market, arg1: bool, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(arg0.config.is_native, 40);
        if (!arg1) {
            assert!(arg2 < arg3, 27);
            assert!(arg2 >= 0 && arg3 <= 100, 27);
        } else {
            assert!(arg2 == 0 && arg3 <= 100, 27);
        };
        arg0.config.isolated = arg1;
        arg0.config.safe_collateral_ratio = arg2;
        arg0.config.liquidation_threshold = arg3;
        validate_collateral_ratios(&arg0.config);
        validate_liquidation_config(&arg0.config);
        let v0 = &mut arg0.config;
        update_config_timestamp(v0, arg4);
        generate_market_config_update_event(arg0.market_id, &arg0.config);
    }

    public(friend) fun update_protocol_fee_share(arg0: &mut Market, arg1: u64, arg2: u64) {
        arg0.config.protocol_fee_share_bps = arg1;
        arg0.config.protocol_spread_fee_share_bps = arg2;
    }

    fun validate_collateral_ratios(arg0: &MarketConfig) {
        assert!(arg0.safe_collateral_ratio < arg0.liquidation_threshold, 27);
        assert!(arg0.safe_collateral_ratio >= 0 && arg0.liquidation_threshold <= 100, 27);
    }

    fun validate_interest_rates(arg0: vector<u64>, arg1: vector<u8>) {
        assert!(0x1::vector::length<u64>(&arg0) >= 2, 25);
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u8>(&arg1), 2);
        assert!(*0x1::vector::borrow<u8>(&arg1, 0) == 0, 25);
        assert!(*0x1::vector::borrow<u8>(&arg1, 0x1::vector::length<u8>(&arg1) - 1) == 100, 25);
        let v0 = 1;
        while (v0 < 0x1::vector::length<u64>(&arg0)) {
            assert!(*0x1::vector::borrow<u64>(&arg0, v0 - 1) <= *0x1::vector::borrow<u64>(&arg0, v0), 25);
            v0 = v0 + 1;
        };
        v0 = 1;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            assert!(*0x1::vector::borrow<u8>(&arg1, v0 - 1) < *0x1::vector::borrow<u8>(&arg1, v0), 25);
            v0 = v0 + 1;
        };
    }

    fun validate_liquidation_config(arg0: &MarketConfig) {
        assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg0.liquidation_bonus_bps + arg0.liquidation_fee_bps), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((arg0.liquidation_threshold as u16)))), 32);
    }

    fun verify_borrow_limit(arg0: &Market, arg1: u64) {
        assert!(arg0.borrowed_amount + arg1 <= arg0.config.borrow_limit, 30);
        assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::le(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.borrowed_amount + arg1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(total_liquidity(arg0))), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((arg0.config.borrow_limit_percentage as u16))), 30);
    }

    public(friend) fun verify_market_cap(arg0: &Market, arg1: &MarketCap) {
        assert!(arg0.market_cap_id == 0x2::object::id<MarketCap>(arg1), 7);
    }

    fun verify_time_lock(arg0: &Market, arg1: &0x2::clock::Clock) {
        if (!arg0.config.is_native) {
            assert!(0x2::clock::timestamp_ms(arg1) >= arg0.config.time_lock, 15);
        };
    }

    public(friend) fun withdraw_market_fee<T0>(arg0: &mut Market, arg1: &0x2::clock::Clock) : LiquidityPromise<T0> {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.last_auto_compound + 1000, 3);
        let v0 = TreasuryKey{dummy_field: false};
        let v1 = LiquidityPromise<T0>{
            market_id         : arg0.market_id,
            coin_type         : arg0.coin_type,
            liquidity_promise : arg0.unclaimed_spread_fee,
            fee               : 0,
        };
        arg0.unclaimed_spread_fee = 0;
        let v2 = 0x2::balance::withdraw_all<XToken<T0>>(&mut 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v0).market_fee);
        if (0x2::balance::value<XToken<T0>>(&v2) > 0) {
            let v3 = burn_xtokens_generate_promise<T0>(arg0, v2, arg1);
            let v4 = &mut v1;
            join_promise<T0>(v4, v3);
        } else {
            0x2::balance::destroy_zero<XToken<T0>>(v2);
        };
        emit_market_data_update_event(arg0);
        v1
    }

    public(friend) fun withdraw_protocol_fee<T0>(arg0: &mut Market, arg1: &0x2::clock::Clock) : LiquidityPromise<T0> {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.last_auto_compound + 1000, 3);
        let v0 = TreasuryKey{dummy_field: false};
        let v1 = LiquidityPromise<T0>{
            market_id         : arg0.market_id,
            coin_type         : arg0.coin_type,
            liquidity_promise : arg0.unclaimed_spread_fee_protocol,
            fee               : 0,
        };
        arg0.unclaimed_spread_fee_protocol = 0;
        let v2 = 0x2::balance::withdraw_all<XToken<T0>>(&mut 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury<T0>>(&mut arg0.id, v0).protocol_fee);
        if (0x2::balance::value<XToken<T0>>(&v2) > 0) {
            let v3 = burn_xtokens_generate_promise<T0>(arg0, v2, arg1);
            let v4 = &mut v1;
            join_promise<T0>(v4, v3);
        } else {
            0x2::balance::destroy_zero<XToken<T0>>(v2);
        };
        emit_market_data_update_event(arg0);
        v1
    }

    public(friend) fun writeoff_borrow(arg0: &mut Market, arg1: u64) {
        assert!(arg0.writeoff_amount + arg1 <= arg0.borrowed_amount, 28);
        assert!(get_is_native(arg0) == true, 29);
        arg0.writeoff_amount = arg0.writeoff_amount + arg1;
    }

    // decompiled from Move bytecode v6
}

