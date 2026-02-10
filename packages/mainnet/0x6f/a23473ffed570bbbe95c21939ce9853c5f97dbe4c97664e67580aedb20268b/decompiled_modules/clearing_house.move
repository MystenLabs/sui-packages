module 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::clearing_house {
    struct ClearingHouse<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        market_params: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketParams,
        market_state: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketState,
    }

    struct Vault<phantom T0> has store {
        collateral_balance: 0x2::balance::Balance<T0>,
        insurance_fund_balance: 0x2::balance::Balance<T0>,
    }

    struct MarginRatioProposal has store {
        maturity: u64,
        margin_ratio_initial: u256,
        margin_ratio_maintenance: u256,
    }

    struct PositionFeesProposal has store {
        maker_fee: u256,
        taker_fee: u256,
    }

    struct IntegratorVault has store {
        fees: u256,
    }

    struct SettlementPrices has store {
        base_price: u256,
        collateral_price: u256,
    }

    struct SessionHotPotato<phantom T0> {
        clearing_house: ClearingHouse<T0>,
        orderbook: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook,
        account_id: u64,
        timestamp_ms: u64,
        collateral_price: u256,
        index_price: u256,
        gas_price: u64,
        margin_before: u256,
        min_margin_before: u256,
        position_base_before: u256,
        total_open_interest: u256,
        total_fees: u256,
        maker_events: vector<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::FilledMakerOrder>,
        liqee_account_id: 0x1::option::Option<u64>,
        liquidator_fees: u256,
        session_summary: SessionSummary,
    }

    struct SessionSummary has copy, drop {
        base_filled_ask: u256,
        base_filled_bid: u256,
        quote_filled_ask: u256,
        quote_filled_bid: u256,
        base_posted_ask: u256,
        base_posted_bid: u256,
        posted_orders: u64,
        base_liquidated: u256,
        quote_liquidated: u256,
        is_liqee_long: bool,
        bad_debt: u256,
    }

    struct IntegratorInfo has copy, drop {
        integrator_address: address,
        taker_fee: u256,
    }

    public(friend) fun accept_position_fees_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position_fees_proposal(arg1);
        assert!(0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::PositionFeesProposal>(&arg0.id, v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::proposal_does_not_exist());
        let PositionFeesProposal {
            maker_fee : v1,
            taker_fee : v2,
        } = 0x2::dynamic_field::remove<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::PositionFeesProposal, PositionFeesProposal>(&mut arg0.id, v0);
        let v3 = 0x2::object::id<ClearingHouse<T0>>(arg0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::update_position_fees(get_position_mut<T0>(arg0, arg1), v1, v2);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_accepted_position_fees_proposal(v3, arg1, v1, v2);
    }

    public(friend) fun add_orderbook<T0>(arg0: &mut ClearingHouse<T0>, arg1: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook) {
        0x2::dynamic_object_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Orderbook, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::market_orderbook(), arg1);
    }

    fun add_position<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position) {
        assert!(!0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Position>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position(arg1)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::position_already_exists());
        0x2::dynamic_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Position, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position(arg1), arg2);
    }

    public(friend) fun allocate_collateral<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg2: u64) {
        allocate_collateral_impl<T0>(arg0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_account_id<T0>(arg1), 0x2::balance::split<T0>(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_mut<T0>(arg1), arg2));
    }

    fun allocate_collateral_impl<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg2);
        assert!(v0 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::deposit_or_withdraw_amount_zero());
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(&arg0.market_params);
        let v2 = get_market_vault_mut<T0>(arg0);
        0x2::balance::join<T0>(&mut v2.collateral_balance, arg2);
        let v3 = get_position_mut<T0>(arg0, arg1);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_collateral(v3, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v0, v1));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_allocated_collateral(0x2::object::id<ClearingHouse<T0>>(arg0), arg1, v0);
    }

    public fun book_price_or_index(arg0: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook, arg1: u256) : u256 {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::book_price(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            return arg1
        };
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x1::option::destroy_some<u64>(v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling())
    }

    public fun calculate_mark_price(arg0: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketState, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketParams, arg2: u256, arg3: u256, arg4: u64) : u256 {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::calculate_funding_price(arg0, arg1, arg2, arg4);
        let v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_spread_twap(arg0));
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::min(v1, v0), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::min(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v1, v0), arg3))
    }

    public fun calculate_taker_fees<T0>(arg0: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg2: u256, arg3: u256, arg4: u256, arg5: 0x1::option::Option<IntegratorInfo>) : (u256, u256, 0x1::option::Option<address>) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_taker_fee(arg0);
        let v1 = if (v0 != 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::null_fee()) {
            v0
        } else {
            arg3
        };
        let v2 = v1;
        if (arg4 != 0) {
            v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v1, arg4);
        };
        let (v3, v4) = if (0x1::option::is_some<IntegratorInfo>(&arg5)) {
            let v5 = 0x1::option::destroy_some<IntegratorInfo>(arg5);
            assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(v5.taker_fee, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_integrator_max_taker_fee(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_integrator_config<T0>(arg1, v5.integrator_address))), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_integrator_taker_fee());
            (v5.taker_fee, 0x1::option::some<address>(v5.integrator_address))
        } else {
            (0, 0x1::option::none<address>())
        };
        (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v2, arg2), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v3, arg2), v4)
    }

    public(friend) fun cancel_orders<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: &vector<u128>) {
        let v0 = 0x1::vector::length<u128>(arg2);
        assert!(v0 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_cancel_order_ids());
        let v1 = 0x2::object::id<ClearingHouse<T0>>(arg0);
        let v2 = get_orderbook_mut<T0>(arg0);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v0) {
            let v6 = *0x1::vector::borrow<u128>(arg2, v5);
            let v7 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::cancel_limit_order(v2, arg1, v6);
            if (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::order_id::is_ask(v6)) {
                v3 = v3 + v7;
            } else {
                v4 = v4 + v7;
            };
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_canceled_order(v1, arg1, v6, v7);
            v5 = v5 + 1;
        };
        let v8 = get_position_mut<T0>(arg0, arg1);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_pending_amount(v8, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::ask(), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v3, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_pending_amount(v8, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::bid(), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v4, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::update_pending_orders(v8, false, v0);
    }

    public fun check_ch_version<T0>(arg0: &ClearingHouse<T0>) {
        if (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::force_equal_version()) {
            assert!(arg0.version == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::version(), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::wrong_version());
        } else {
            assert!(arg0.version == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::version() || arg0.version == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::version() - 1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::wrong_version());
        };
    }

    public fun check_ch_version_in_session<T0>(arg0: &SessionHotPotato<T0>) {
        check_ch_version<T0>(&arg0.clearing_house);
    }

    public fun check_market_is_closed<T0>(arg0: &ClearingHouse<T0>) {
        assert!(0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::SettlementPrices>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::settlement_prices()), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::market_is_not_closed());
    }

    public fun check_market_is_not_closed<T0>(arg0: &ClearingHouse<T0>) {
        assert!(!0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::SettlementPrices>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::settlement_prices()), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::market_is_closed());
    }

    public fun check_market_is_not_paused<T0>(arg0: &ClearingHouse<T0>) {
        assert!(!is_market_paused<T0>(arg0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::market_is_paused());
    }

    public fun check_market_is_paused<T0>(arg0: &ClearingHouse<T0>) {
        assert!(is_market_paused<T0>(arg0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::market_is_not_paused());
    }

    public fun check_order_value(arg0: u64, arg1: u256, arg2: u256) {
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()), arg1) >= arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::order_usd_value_too_low());
    }

    public fun check_reduce_only<T0>(arg0: &SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: bool) : u64 {
        if (arg3) {
            let v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.position_base_before, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg0.session_summary.base_filled_bid, arg0.session_summary.base_filled_ask));
            assert!(v1 != 0 && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v1) != arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::reduce_only_violated());
            0x1::u64::min(arg2, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v1), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()))
        } else {
            arg2
        }
    }

    public fun clip_size_to_liquidate(arg0: u256, arg1: u256, arg2: u64) : u64 {
        if (arg2 != 1) {
            0x1::u64::min(0x1::u64::divide_and_round_up(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()) + 1, arg2) * arg2, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg1), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()))
        } else {
            0x1::u64::min(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()) + 1, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(arg1), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()))
        }
    }

    public(friend) fun close_market<T0>(arg0: &mut ClearingHouse<T0>, arg1: u256, arg2: u256) {
        arg0.paused = true;
        let v0 = SettlementPrices{
            base_price       : arg1,
            collateral_price : arg2,
        };
        0x2::dynamic_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::SettlementPrices, SettlementPrices>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::settlement_prices(), v0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_closed_market(0x2::object::id<ClearingHouse<T0>>(arg0), arg1, arg2);
    }

    public(friend) fun close_position_at_settlement_prices<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg2: &vector<u128>) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_account_id<T0>(arg1);
        let v1 = 0x2::object::id<ClearingHouse<T0>>(arg0);
        let v2 = get_settlement_prices<T0>(arg0);
        let v3 = v2.base_price;
        let v4 = v2.collateral_price;
        if (!0x1::vector::is_empty<u128>(arg2)) {
            cancel_orders<T0>(arg0, v0, arg2);
        };
        let (v5, v6) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(&arg0.market_state);
        let v7 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(&arg0.market_params);
        let v8 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_fees_accrued(&arg0.market_state);
        let v9 = get_position_mut<T0>(arg0, v0);
        let (v10, v11) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_amounts(v9);
        let v12 = if (v10 == 0) {
            if (v11 == 0) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(v9) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v12, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_cancel_order_ids());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::settle_position_funding(v9, v4, v5, v6, &v1, v0);
        let (v13, v14) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v9);
        let v15 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v13);
        let v16 = 0;
        let v17 = 0;
        if (v13 != 0) {
            let v18 = if (v15) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_long_to_position(v9, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v13), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v13), v3))
            } else {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_short_to_position(v9, v13, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v13, v3))
            };
            v17 = v18;
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_collateral_usd(v9, v18, v4);
            if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(v9))) {
                v16 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::reset_collateral(v9);
            };
        };
        let (v19, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v9);
        let v21 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(v9);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_collateral(v9, v21);
        let v22 = get_market_vault_mut<T0>(arg0);
        let v23 = 0x1::u64::min(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(v21, v7), get_vault_collateral_balance<T0>(v22, v8, v7));
        0x2::balance::join<T0>(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_mut<T0>(arg1), 0x2::balance::split<T0>(&mut v22.collateral_balance, v23));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::add_to_open_interest(&mut arg0.market_state, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v19, 0), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v13, 0)));
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v16, 0)) {
            handle_bad_debt<T0>(arg0, v16, v3, v4, !v15, &v1);
        };
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_closed_position_at_settlement_prices(v1, v0, v17, v13, v14, v23, v16);
    }

    public(friend) fun commit_margin_ratios_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::margin_ratio_proposal();
        assert!(0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarginRatioProposal>(&arg0.id, v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::proposal_does_not_exist());
        let MarginRatioProposal {
            maturity                 : v1,
            margin_ratio_initial     : v2,
            margin_ratio_maintenance : v3,
        } = 0x2::dynamic_field::remove<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarginRatioProposal, MarginRatioProposal>(&mut arg0.id, v0);
        assert!(v1 <= 0x2::clock::timestamp_ms(arg1), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::premature_proposal());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::update_margin_ratios(&mut arg0.market_params, v2, v3);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_updated_margin_ratios(0x2::object::id<ClearingHouse<T0>>(arg0), v2, v3);
    }

    public fun compute_size_to_liquidate(arg0: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256) : (u256, bool) {
        let (v0, v1) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(arg0);
        let v2 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v0);
        let v3 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg4, arg1), v2);
        let (v4, v5) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::compute_margin(arg0, arg2, arg1, arg4, arg8);
        let v6 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v4, arg5);
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v6, v5)) {
            return (0, true)
        };
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(v6, 0)) {
            return (v2, false)
        };
        let v7 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v3, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v0, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg3, arg1))), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg6, arg7), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg3, v2)));
        if (v7 == 0) {
            return (v2, false)
        };
        let v8 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div_up(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v3, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v1, arg5)), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg1, v0), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(arg0)), arg8))), v7);
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than(v8, 0) || 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v8, 1000000000000000000)) {
            return (v2, false)
        };
        (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v8, v2), false)
    }

    public(friend) fun create_clearing_house<T0>(arg0: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::clock::Clock, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: u256, arg8: u256, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u256, arg17: u256, arg18: u256, arg19: u256, arg20: u256, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) : ClearingHouse<T0> {
        assert!(0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::any_source(arg3), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::no_price_feed_for_market());
        assert!(0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::any_source(arg4), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::no_price_feed_for_market());
        let v0 = 0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg3);
        let v1 = 0x2::object::id<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage>(arg4);
        let v2 = (0x2::coin::get_decimals<T0>(arg1) as u64);
        let v3 = Vault<T0>{
            collateral_balance     : 0x2::balance::zero<T0>(),
            insurance_fund_balance : 0x2::balance::zero<T0>(),
        };
        let (v4, v5) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::create_market_objects(arg2, arg7, arg8, v0, v1, arg5, arg6, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::decimal_scalar_from_decimals(v2) as u256), 0x2::tx_context::gas_price(arg23));
        let v6 = ClearingHouse<T0>{
            id            : 0x2::object::new(arg23),
            version       : 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::version(),
            paused        : false,
            market_params : v4,
            market_state  : v5,
        };
        0x2::dynamic_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarketVault, Vault<T0>>(&mut v6.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::market_vault(), v3);
        0x2::dynamic_object_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Orderbook, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook>(&mut v6.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::market_orderbook(), arg0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_created_clearing_house(0x2::object::id<ClearingHouse<T0>>(&v6), get_collateral_symbol<T0>(), v2, arg7, arg8, v0, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        v6
    }

    public fun create_integrator_info(arg0: address, arg1: u256) : 0x1::option::Option<IntegratorInfo> {
        let v0 = IntegratorInfo{
            integrator_address : arg0,
            taker_fee          : arg1,
        };
        0x1::option::some<IntegratorInfo>(v0)
    }

    public(friend) fun create_integrator_vault<T0>(arg0: &mut ClearingHouse<T0>, arg1: address) {
        assert!(!0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::IntegratorVault>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::integrator_vault(arg1)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::integrator_vault_already_exists());
        let v0 = IntegratorVault{fees: 0};
        0x2::dynamic_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::IntegratorVault, IntegratorVault>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::integrator_vault(arg1), v0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_created_integrator_vault(0x2::object::id<ClearingHouse<T0>>(arg0), arg1);
    }

    public(friend) fun create_margin_ratios_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u256, arg4: u256) {
        assert!(!0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarginRatioProposal>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::margin_ratio_proposal()), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::proposal_already_exists());
        assert!(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::min_proposal_delay_ms() <= arg2 && arg2 <= 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::max_proposal_delay_ms(), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_proposal_delay());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::check_margin_ratios(arg3, arg4);
        let v0 = MarginRatioProposal{
            maturity                 : 0x2::clock::timestamp_ms(arg1) + arg2,
            margin_ratio_initial     : arg3,
            margin_ratio_maintenance : arg4,
        };
        0x2::dynamic_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarginRatioProposal, MarginRatioProposal>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::margin_ratio_proposal(), v0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_created_margin_ratios_proposal(0x2::object::id<ClearingHouse<T0>>(arg0), arg3, arg4);
    }

    public(friend) fun create_market_position<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64) {
        let (v0, v1) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(&arg0.market_state);
        add_position<T0>(arg0, arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::create_position(v0, v1));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_created_position(0x2::object::id<ClearingHouse<T0>>(arg0), arg1, v0, v1);
    }

    public(friend) fun create_position_fees_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: u256, arg3: u256) {
        assert!(!0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::PositionFeesProposal>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position_fees_proposal(arg1)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::proposal_already_exists());
        let (v0, v1) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_maker_taker_fees(&arg0.market_params);
        if (arg2 != 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::null_fee()) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::check_market_fees(arg2, v1);
        };
        if (arg3 != 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::null_fee()) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::check_market_fees(v0, arg3);
        };
        let v2 = PositionFeesProposal{
            maker_fee : arg2,
            taker_fee : arg3,
        };
        0x2::dynamic_field::add<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::PositionFeesProposal, PositionFeesProposal>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position_fees_proposal(arg1), v2);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_created_position_fees_proposal(0x2::object::id<ClearingHouse<T0>>(arg0), arg1, arg2, arg3);
    }

    fun create_session_summary() : SessionSummary {
        SessionSummary{
            base_filled_ask  : 0,
            base_filled_bid  : 0,
            quote_filled_ask : 0,
            quote_filled_bid : 0,
            base_posted_ask  : 0,
            base_posted_bid  : 0,
            posted_orders    : 0,
            base_liquidated  : 0,
            quote_liquidated : 0,
            is_liqee_long    : true,
            bad_debt         : 0,
        }
    }

    public(friend) fun deallocate_collateral<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u64>) {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(arg0);
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_account_id<T0>(arg1);
        let v2 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_mut<T0>(arg1);
        let v3 = take_collateral<T0>(arg0, v2, arg2, arg3, arg4, arg5, v1, arg6);
        if (v3 != 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_deallocated_collateral(v0, v1, v3);
        };
    }

    public(friend) fun delete_margin_ratios_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::margin_ratio_proposal();
        assert!(0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarginRatioProposal>(&arg0.id, v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::proposal_does_not_exist());
        let MarginRatioProposal {
            maturity                 : v1,
            margin_ratio_initial     : v2,
            margin_ratio_maintenance : v3,
        } = 0x2::dynamic_field::remove<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarginRatioProposal, MarginRatioProposal>(&mut arg0.id, v0);
        assert!(0x2::clock::timestamp_ms(arg1) < v1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::proposal_already_matured());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_deleted_margin_ratios_proposal(0x2::object::id<ClearingHouse<T0>>(arg0), v2, v3);
    }

    public(friend) fun delete_position_fees_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position_fees_proposal(arg1);
        assert!(0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::PositionFeesProposal>(&arg0.id, v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::proposal_does_not_exist());
        let PositionFeesProposal {
            maker_fee : v1,
            taker_fee : v2,
        } = 0x2::dynamic_field::remove<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::PositionFeesProposal, PositionFeesProposal>(&mut arg0.id, v0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_deleted_position_fees_proposal(0x2::object::id<ClearingHouse<T0>>(arg0), arg1, v1, v2);
    }

    public(friend) fun donate_to_insurance_fund<T0>(arg0: &mut ClearingHouse<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(arg0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_donated_to_insurance_fund(arg2, v0, 0x2::balance::join<T0>(&mut get_market_vault_mut<T0>(arg0).insurance_fund_balance, 0x2::coin::into_balance<T0>(arg1)));
    }

    public(friend) fun end_session<T0>(arg0: SessionHotPotato<T0>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg2: bool, arg3: 0x1::option::Option<IntegratorInfo>) : (ClearingHouse<T0>, SessionSummary) {
        process_session_hot_potato<T0>(arg0, arg1, arg2, arg3)
    }

    fun execute_limit_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::option::Option<u64>) : u64 {
        assert!(arg4 < 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::order_types(), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::flag_requirements_violated());
        let v0 = &mut arg0.clearing_house;
        let v1 = &mut arg0.orderbook;
        let v2 = &mut arg0.session_summary;
        let v3 = &mut arg0.maker_events;
        let v4 = arg0.account_id;
        let v5 = arg0.timestamp_ms;
        assert!(0x1::option::get_with_default<u64>(&arg6, 18446744073709551615) >= v5, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_expiration_timestamp());
        let v6 = 0x2::object::id<ClearingHouse<T0>>(v0);
        let (v7, v8) = get_market_objects<T0>(v0);
        let (v9, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_maker_taker_fees(v7);
        let (v11, v12) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(v8);
        let (v13, v14) = if (arg1 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::ask()) {
            let v13 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::get_bids_mut(v1);
            (v13, ((arg3 ^ 18446744073709551615) as u128))
        } else {
            let v13 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::get_asks_mut(v1);
            (v13, (arg3 as u128))
        };
        let v15 = 0;
        let v16 = true;
        let v17 = false;
        let v18 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::first_leaf_ptr<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v13);
        while (v18 != 0) {
            let v19 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::get_leaf_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v13, v18);
            v18 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::leaf_next<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v19);
            let v20 = 0;
            while (v20 < 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::leaf_size<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v19)) {
                let (v21, v22) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::leaf_elem_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v19, v20);
                if (v21 >> 64 > v14) {
                    v17 = true;
                    break
                };
                v15 = v21;
                let (v23, v24, v25, v26) = process_fill_maker<T0>(v2, v0, v21, v22, v5, arg0.collateral_price, v9, v11, v12, v4, arg2);
                let v27 = v25;
                let v28 = arg2 - v23;
                arg2 = v28;
                v16 = v24;
                arg0.total_fees = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.total_fees, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::get_maker_event_fees(&v27));
                arg0.total_open_interest = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.total_open_interest, v26);
                0x1::vector::push_back<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::FilledMakerOrder>(v3, v27);
                if (v28 == 0) {
                    break
                };
                v20 = v20 + 1;
            };
            if (v17 || arg2 == 0) {
                break
            };
        };
        if (arg4 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::fill_or_kill()) {
            assert!(arg2 == 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::flag_requirements_violated());
        };
        if (arg4 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::post_only()) {
            assert!(arg2 == arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::flag_requirements_violated());
        };
        if (arg4 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::immediate_or_cancel()) {
            arg2 = 0;
        };
        if (v15 > 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::batch_drop<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v13, v15, v16);
        };
        if (arg2 != 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_posted_order(v6, v4, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::post_order(v1, v4, arg1, arg2, arg3, arg5, arg6), arg2, arg5, arg6);
            arg0.session_summary.posted_orders = arg0.session_summary.posted_orders + 1;
            if (arg1) {
                arg0.session_summary.base_posted_ask = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.session_summary.base_posted_ask, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()));
            } else {
                arg0.session_summary.base_posted_bid = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.session_summary.base_posted_bid, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()));
            };
        };
        arg2
    }

    fun execute_liquidation<T0>(arg0: &mut SessionHotPotato<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(&arg0.clearing_house);
        let v1 = &v0;
        let v2 = settle_liquidated_position<T0>(arg0, arg1, arg2, arg3, arg4, v1);
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(arg0.session_summary.bad_debt, 0)) {
            let v3 = &mut arg0.clearing_house;
            handle_bad_debt<T0>(v3, arg0.session_summary.bad_debt, v2, arg0.collateral_price, arg0.session_summary.is_liqee_long, v1);
        };
    }

    fun execute_market_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64) {
        let v0 = &mut arg0.clearing_house;
        let v1 = &mut arg0.session_summary;
        let v2 = &mut arg0.maker_events;
        let (v3, v4) = get_market_objects<T0>(v0);
        let (v5, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_maker_taker_fees(v3);
        let (v7, v8) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(v4);
        let v9 = if (arg1 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::ask()) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::get_bids_mut(&mut arg0.orderbook)
        } else {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::get_asks_mut(&mut arg0.orderbook)
        };
        let v10 = 0;
        let v11 = true;
        let v12 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::first_leaf_ptr<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v9);
        while (v12 != 0) {
            let v13 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::get_leaf_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v9, v12);
            v12 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::leaf_next<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v13);
            let v14 = 0;
            while (v14 < 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::leaf_size<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v13)) {
                let (v15, v16) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::leaf_elem_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v13, v14);
                v10 = v15;
                let (v17, v18, v19, v20) = process_fill_maker<T0>(v1, v0, v15, v16, arg0.timestamp_ms, arg0.collateral_price, v5, v7, v8, arg0.account_id, arg2);
                let v21 = v19;
                let v22 = arg2 - v17;
                arg2 = v22;
                v11 = v18;
                arg0.total_fees = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.total_fees, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::get_maker_event_fees(&v21));
                arg0.total_open_interest = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.total_open_interest, v20);
                0x1::vector::push_back<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::FilledMakerOrder>(v2, v21);
                if (v22 == 0) {
                    break
                };
                v14 = v14 + 1;
            };
            if (arg2 == 0) {
                break
            };
        };
        assert!(arg2 == 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::not_enough_liquidity());
        if (v10 > 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::ordered_map::batch_drop<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order>(v9, v10, v11);
        };
    }

    public fun exists_position<T0>(arg0: &ClearingHouse<T0>, arg1: u64) : bool {
        0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Position>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position(arg1))
    }

    public(friend) fun force_cancel_orders(arg0: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook, arg1: u64, arg2: &vector<u128>, arg3: 0x2::object::ID) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v0 < 0x1::vector::length<u128>(arg2)) {
            let v3 = *0x1::vector::borrow<u128>(arg2, v0);
            let v4 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::cancel_limit_order(arg0, arg1, v3);
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_canceled_order(arg3, arg1, v3, v4);
            if (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::order_id::is_ask(v3)) {
                v1 = v1 + v4;
            } else {
                v2 = v2 + v4;
            };
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    public fun get_account_id_in_session<T0>(arg0: &SessionHotPotato<T0>) : u64 {
        arg0.account_id
    }

    public fun get_amount_to_deallocate_for_mr<T0>(arg0: &ClearingHouse<T0>, arg1: u64, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<u256>) : u64 {
        let v0 = get_market_params<T0>(arg0);
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_margin_ratio_initial(v0);
        let v2 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_haircut(v0);
        let (v3, v4) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(get_market_state<T0>(arg0));
        let v5 = get_position<T0>(arg0, arg1);
        let v6 = if (0x1::option::is_some<u256>(&arg6)) {
            0x1::option::destroy_some<u256>(arg6)
        } else {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_initial_margin_ratio(v5)
        };
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v6, v1), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::deallocate_target_mr_too_low());
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::compute_free_collateral_with_fundings(v5, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_oracle_price(v0, arg3, arg4, arg5), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_oracle_price(v0, arg2, arg4, arg5), v6, v3, v4, v2), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(v0))
    }

    public fun get_base_and_quote_deltas(arg0: u64, arg1: u64) : (u256, u256) {
        (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()), (arg1 as u256) * (arg0 as u256))
    }

    public fun get_best_price<T0>(arg0: &ClearingHouse<T0>, arg1: bool) : 0x1::option::Option<u256> {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::best_price(get_orderbook<T0>(arg0), arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<u256>()
        };
        0x1::option::some<u256>(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x1::option::destroy_some<u64>(v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()))
    }

    public fun get_book_price<T0>(arg0: &ClearingHouse<T0>) : 0x1::option::Option<u256> {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::book_price(get_orderbook<T0>(arg0));
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<u256>()
        };
        0x1::option::some<u256>(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x1::option::destroy_some<u64>(v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()))
    }

    public fun get_ch_version<T0>(arg0: &ClearingHouse<T0>) : u64 {
        arg0.version
    }

    fun get_collateral_symbol<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())))
    }

    public fun get_imr_for_position(arg0: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position, arg1: u256) : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_initial_margin_ratio(arg0), arg1)
    }

    public fun get_integrator_vault<T0>(arg0: &ClearingHouse<T0>, arg1: address) : &IntegratorVault {
        0x2::dynamic_field::borrow<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::IntegratorVault, IntegratorVault>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::integrator_vault(arg1))
    }

    public(friend) fun get_integrator_vault_mut<T0>(arg0: &mut ClearingHouse<T0>, arg1: address) : &mut IntegratorVault {
        0x2::dynamic_field::borrow_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::IntegratorVault, IntegratorVault>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::integrator_vault(arg1))
    }

    public fun get_liquidation_mark_price_u64<T0>(arg0: &SessionHotPotato<T0>) : u64 {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_tick_size(&arg0.clearing_house.market_params);
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg0.session_summary.quote_liquidated, arg0.session_summary.base_liquidated), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()) / v0 * v0
    }

    public fun get_mark_price<T0>(arg0: &ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = get_market_objects<T0>(arg0);
        let v2 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_oracle_price(v0, arg1, arg2, arg3);
        calculate_mark_price(v1, v0, v2, book_price_or_index(get_orderbook<T0>(arg0), v2), 0x2::clock::timestamp_ms(arg3))
    }

    public fun get_market_objects<T0>(arg0: &ClearingHouse<T0>) : (&0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketParams, &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketState) {
        (&arg0.market_params, &arg0.market_state)
    }

    public(friend) fun get_market_objects_mut<T0>(arg0: &mut ClearingHouse<T0>) : (&0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketParams, &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketState) {
        (&arg0.market_params, &mut arg0.market_state)
    }

    public fun get_market_params<T0>(arg0: &ClearingHouse<T0>) : &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketParams {
        &arg0.market_params
    }

    public(friend) fun get_market_params_mut<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketParams {
        &mut arg0.market_params
    }

    public fun get_market_state<T0>(arg0: &ClearingHouse<T0>) : &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketState {
        &arg0.market_state
    }

    public(friend) fun get_market_state_mut<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketState {
        &mut arg0.market_state
    }

    public fun get_market_vault<T0>(arg0: &ClearingHouse<T0>) : &Vault<T0> {
        0x2::dynamic_field::borrow<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarketVault, Vault<T0>>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::market_vault())
    }

    public(friend) fun get_market_vault_mut<T0>(arg0: &mut ClearingHouse<T0>) : &mut Vault<T0> {
        0x2::dynamic_field::borrow_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::MarketVault, Vault<T0>>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::market_vault())
    }

    public fun get_orderbook<T0>(arg0: &ClearingHouse<T0>) : &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook {
        0x2::dynamic_object_field::borrow<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Orderbook, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::market_orderbook())
    }

    public(friend) fun get_orderbook_mut<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook {
        0x2::dynamic_object_field::borrow_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Orderbook, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::market_orderbook())
    }

    public fun get_position<T0>(arg0: &ClearingHouse<T0>, arg1: u64) : &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position {
        0x2::dynamic_field::borrow<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Position, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position(arg1))
    }

    public(friend) fun get_position_mut<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64) : &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position {
        0x2::dynamic_field::borrow_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Position, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position(arg1))
    }

    public fun get_session_execution_price(arg0: &SessionSummary, arg1: bool) : u256 {
        if (arg1 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::ask() && arg0.base_filled_ask != 0) {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg0.quote_filled_ask, arg0.base_filled_ask)
        } else if (arg1 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::bid() && arg0.base_filled_bid != 0) {
            0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg0.quote_filled_bid, arg0.base_filled_bid)
        } else {
            0
        }
    }

    public fun get_session_fills(arg0: &SessionSummary, arg1: bool) : (u256, u256) {
        if (arg1 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::ask()) {
            (arg0.base_filled_ask, arg0.quote_filled_ask)
        } else {
            (arg0.base_filled_bid, arg0.quote_filled_bid)
        }
    }

    public fun get_session_liquidated_size(arg0: &SessionSummary) : u64 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(arg0.base_liquidated, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling())
    }

    public fun get_session_liquidation_bad_debt(arg0: &SessionSummary) : u256 {
        arg0.bad_debt
    }

    public fun get_session_liquidation_info(arg0: &SessionSummary) : (u256, u256, bool) {
        (arg0.base_liquidated, arg0.quote_liquidated, arg0.is_liqee_long)
    }

    public fun get_session_liquidation_mark_price(arg0: &SessionSummary) : u256 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg0.quote_liquidated, arg0.base_liquidated)
    }

    public fun get_session_liquidation_mark_price_u64(arg0: &SessionSummary) : u64 {
        0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg0.quote_liquidated, arg0.base_liquidated), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling())
    }

    public fun get_session_posts(arg0: &SessionSummary) : (u256, u256) {
        (arg0.base_posted_ask, arg0.base_posted_bid)
    }

    public fun get_settlement_prices<T0>(arg0: &ClearingHouse<T0>) : &SettlementPrices {
        0x2::dynamic_field::borrow<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::SettlementPrices, SettlementPrices>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::settlement_prices())
    }

    public(friend) fun get_settlement_prices_mut<T0>(arg0: &mut ClearingHouse<T0>) : &mut SettlementPrices {
        0x2::dynamic_field::borrow_mut<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::SettlementPrices, SettlementPrices>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::settlement_prices())
    }

    public fun get_summary_in_session<T0>(arg0: &SessionHotPotato<T0>) : &SessionSummary {
        &arg0.session_summary
    }

    public fun get_summary_in_session_<T0>(arg0: &SessionHotPotato<T0>) : SessionSummary {
        arg0.session_summary
    }

    public fun get_vault_balances<T0>(arg0: &ClearingHouse<T0>) : (u64, u64) {
        let v0 = get_market_vault<T0>(arg0);
        (0x2::balance::value<T0>(&v0.collateral_balance), 0x2::balance::value<T0>(&v0.insurance_fund_balance))
    }

    public fun get_vault_collateral_balance<T0>(arg0: &Vault<T0>, arg1: u256, arg2: u256) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_balance) - 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(arg1, arg2)
    }

    fun handle_bad_debt<T0>(arg0: &mut ClearingHouse<T0>, arg1: u256, arg2: u256, arg3: u256, arg4: bool, arg5: &0x2::object::ID) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(&arg0.market_params);
        let (v1, v2) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_max_bad_debt_thresholds(&arg0.market_params);
        let v3 = get_market_vault_mut<T0>(arg0);
        let v4 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x2::balance::value<T0>(&v3.insurance_fund_balance), v0);
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v4, arg1)) {
            transfer_from_insurance_fund_to_vault<T0>(v3, arg1, v0);
        } else {
            transfer_from_insurance_fund_to_vault<T0>(v3, v4, v0);
            let v5 = &mut arg0.market_state;
            try_socialize_bad_debt(v5, arg2, arg4, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(arg1, v4), arg3), v1, v2, arg5);
        };
    }

    public fun is_market_paused<T0>(arg0: &ClearingHouse<T0>) : bool {
        arg0.paused
    }

    public(friend) fun liquidate<T0>(arg0: &mut SessionHotPotato<T0>, arg1: u64, arg2: &vector<u128>) {
        assert!(arg0.account_id != arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::self_liquidation());
        let v0 = &mut arg0.orderbook;
        let v1 = &arg0.session_summary;
        let v2 = if (0x1::vector::length<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::FilledMakerOrder>(&arg0.maker_events) == 0) {
            if (v1.posted_orders == 0) {
                0x1::option::is_none<u64>(&arg0.liqee_account_id)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::liquidate_not_first_operation());
        let v3 = 0x1::vector::length<u128>(arg2);
        let (v4, v5) = if (v3 != 0) {
            force_cancel_orders(v0, arg1, arg2, 0x2::object::id<ClearingHouse<T0>>(&arg0.clearing_house))
        } else {
            (0, 0)
        };
        execute_liquidation<T0>(arg0, arg1, v4, v5, v3);
    }

    public(friend) fun pause_market<T0>(arg0: &mut ClearingHouse<T0>) {
        arg0.paused = true;
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_paused_market(0x2::object::id<ClearingHouse<T0>>(arg0));
    }

    public(friend) fun place_limit_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0x1::option::Option<u64>) {
        assert!(arg3 % 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_tick_size(&arg0.clearing_house.market_params) == 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::price_not_multiple_of_tick_size());
        assert!(arg3 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_price());
        let v0 = check_reduce_only<T0>(arg0, arg1, arg2, arg5);
        assert!(v0 % 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_lot_size(&arg0.clearing_house.market_params) == 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::size_not_multiple_of_lot_size());
        assert!(v0 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::size_or_position_zero());
        let v1 = execute_limit_order<T0>(arg0, arg1, v0, arg3, arg4, arg5, arg6);
        if (v1 != 0) {
            check_order_value(v1, arg0.index_price, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_min_order_usd_value(&arg0.clearing_house.market_params));
        };
    }

    public(friend) fun place_market_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: bool) {
        let v0 = check_reduce_only<T0>(arg0, arg1, arg2, arg3);
        assert!(v0 % 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_lot_size(&arg0.clearing_house.market_params) == 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::size_not_multiple_of_lot_size());
        assert!(v0 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::size_or_position_zero());
        execute_market_order<T0>(arg0, arg1, v0);
    }

    public(friend) fun place_stop_order_sltp<T0>(arg0: ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T0>, arg6: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: 0x1::option::Option<u256>, arg10: 0x1::option::Option<u256>, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: &vector<u8>, arg16: address, arg17: 0x1::option::Option<IntegratorInfo>, arg18: u64) : (SessionSummary, 0x2::balance::Balance<0x2::sui::SUI>, ClearingHouse<T0>) {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(&arg0);
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::get_account_id<T0>(&arg5);
        let (v2, v3, v4) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::delete_stop_order_ticket<T0>(arg5, true, arg16);
        let v5 = v4;
        assert!(v3 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::sltp(), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_stop_order_type());
        verify_sltp_encrypted_details(&v5, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        if (0x1::option::is_some<u64>(&arg7)) {
            assert!(0x2::clock::timestamp_ms(arg4) < *0x1::option::borrow<u64>(&arg7), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::stop_order_ticket_expired());
        };
        let v6 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_oracle_price(get_market_params<T0>(&arg0), arg1, arg3, arg4);
        let v7 = if (0x1::option::is_some<u256>(&arg9)) {
            let v8 = 0x1::option::destroy_some<u256>(arg9);
            arg11 && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v6, v8) || !arg11 && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(v6, v8)
        } else {
            false
        };
        let v9 = if (0x1::option::is_some<u256>(&arg10)) {
            let v10 = 0x1::option::destroy_some<u256>(arg10);
            arg11 && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(v6, v10) || !arg11 && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than_eq(v6, v10)
        } else {
            false
        };
        assert!(v7 || v9, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::stop_order_conditions_violated());
        let (v11, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(get_position<T0>(&arg0, v1));
        assert!(v11 != 0 && arg11 == 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v11), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_position_for_sltp());
        let v13 = start_session<T0>(arg0, v1, arg1, arg2, arg3, arg4, arg18);
        if (arg8) {
            let v14 = &mut v13;
            place_limit_order<T0>(v14, !arg11, 0x1::u64::min(arg12, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v11), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling())), arg13, arg14, true, arg7);
        } else {
            let v15 = &mut v13;
            place_market_order<T0>(v15, !arg11, 0x1::u64::min(arg12, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v11), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling())), false);
        };
        let (v16, v17) = end_session<T0>(v13, arg6, false, arg17);
        let v18 = v16;
        let v19 = &mut v18;
        let v20 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_mut<T0>(arg6);
        let v21 = take_collateral<T0>(v19, v20, arg1, arg2, arg3, arg4, v1, 0x1::option::none<u64>());
        if (v21 != 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_deallocated_collateral(v0, v1, v21);
        };
        (v17, v2, v18)
    }

    public(friend) fun place_stop_order_standalone<T0>(arg0: ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::StopOrderTicket<T0>, arg6: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg7: 0x1::option::Option<u64>, arg8: bool, arg9: u256, arg10: bool, arg11: bool, arg12: u64, arg13: u64, arg14: u64, arg15: bool, arg16: &vector<u8>, arg17: address, arg18: 0x1::option::Option<IntegratorInfo>, arg19: u64) : (SessionSummary, 0x2::balance::Balance<0x2::sui::SUI>, ClearingHouse<T0>) {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(&arg0);
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::get_account_id<T0>(&arg5);
        let (v2, v3, v4) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::stop_orders::delete_stop_order_ticket<T0>(arg5, true, arg17);
        let v5 = v4;
        assert!(v3 == 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::standalone(), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_stop_order_type());
        verify_standalone_encrypted_details(&v5, v0, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        if (0x1::option::is_some<u64>(&arg7)) {
            assert!(0x2::clock::timestamp_ms(arg4) < *0x1::option::borrow<u64>(&arg7), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::stop_order_ticket_expired());
        };
        let v6 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_oracle_price(get_market_params<T0>(&arg0), arg1, arg3, arg4);
        assert!(arg10 && v6 >= arg9 || !arg10 && v6 < arg9, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::stop_order_conditions_violated());
        let v7 = start_session<T0>(arg0, v1, arg1, arg2, arg3, arg4, arg19);
        if (arg8) {
            let v8 = &mut v7;
            place_limit_order<T0>(v8, arg11, arg12, arg13, arg14, arg15, arg7);
        } else {
            let v9 = &mut v7;
            place_market_order<T0>(v9, arg11, arg12, arg15);
        };
        let (v10, v11) = end_session<T0>(v7, arg6, !arg15, arg18);
        let v12 = v10;
        let v13 = &mut v12;
        let v14 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_mut<T0>(arg6);
        let v15 = take_collateral<T0>(v13, v14, arg1, arg2, arg3, arg4, v1, 0x1::option::none<u64>());
        if (v15 != 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_deallocated_collateral(v0, v1, v15);
        };
        (v11, v2, v12)
    }

    fun process_fill_maker<T0>(arg0: &mut SessionSummary, arg1: &mut ClearingHouse<T0>, arg2: u128, arg3: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Order, arg4: u64, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u64, arg10: u64) : (u64, bool, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::FilledMakerOrder, u256) {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(arg1);
        let (v1, v2, v3, v4) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::get_order_details(arg3);
        let v5 = get_position_mut<T0>(arg1, v1);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::settle_position_funding(v5, arg5, arg7, arg8, &v0, v1);
        let (v6, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v5);
        let v8 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::order_id::is_ask(arg2);
        let v9 = if (v3) {
            if (v6 != 0 && (v8 && !0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v6) || !v8 && 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v6))) {
                0x1::u64::min(v2, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v6), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()))
            } else {
                0
            }
        } else {
            v2
        };
        let v10 = v9;
        if (arg4 > 0x1::option::destroy_with_default<u64>(v4, 18446744073709551615) || arg9 == v1) {
            v10 = 0;
        };
        let v11 = 0;
        let v12 = true;
        let v13 = if (v10 == v2) {
            if (arg10 >= v10) {
                v10
            } else {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::reduce_order_size(arg3, arg10);
                v12 = false;
                arg10
            }
        } else if (arg10 >= v10) {
            let v14 = v2 - v10;
            v11 = v14;
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_pending_amount(v5, v8, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v14, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()));
            v10
        } else {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::reduce_order_size(arg3, arg10);
            v12 = false;
            arg10
        };
        if (v12) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::update_pending_orders(v5, false, 1);
        };
        let (v15, v16, v17) = if (v13 != 0) {
            let (v18, v19) = get_base_and_quote_deltas(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::order_id::price(arg2), v13);
            let v20 = if (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::order_id::is_ask(arg2)) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_pending_amount(v5, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::ask(), v18);
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_short_to_position(v5, v18, v19)
            } else {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_pending_amount(v5, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::bid(), v18);
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_long_to_position(v5, v18, v19)
            };
            let v21 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_maker_fee(v5);
            if (v21 != 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::null_fee()) {
                arg6 = v21;
            };
            let v22 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg6, v19);
            let (v23, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v5);
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_collateral_usd(v5, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v20, v22), arg5);
            if (v8) {
                arg0.base_filled_bid = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.base_filled_bid, v18);
                arg0.quote_filled_bid = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.quote_filled_bid, v19);
            } else {
                arg0.base_filled_ask = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.base_filled_ask, v18);
                arg0.quote_filled_ask = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.quote_filled_ask, v19);
            };
            (v20, v22, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v23, 0), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v6, 0)))
        } else {
            (0, 0, 0)
        };
        (v13, v12, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::create_filled_maker_order(v0, v1, arg9, arg2, v13, v2 - v13 - v11, v11, v15, v16), v17)
    }

    fun process_fill_taker<T0>(arg0: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position, arg1: &0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg2: u256, arg3: u64, arg4: &SessionSummary, arg5: u256, arg6: u256, arg7: 0x1::option::Option<IntegratorInfo>, arg8: &0x2::object::ID) : (u256, u256, 0x1::option::Option<address>, u256) {
        let (v0, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(arg0);
        let v2 = if (arg4.base_filled_ask != 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_short_to_position(arg0, arg4.base_filled_ask, arg4.quote_filled_ask)
        } else {
            0
        };
        let v3 = if (arg4.base_filled_bid != 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_long_to_position(arg0, arg4.base_filled_bid, arg4.quote_filled_bid)
        } else {
            0
        };
        let (v4, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(arg0);
        let v6 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v2, v3);
        let (v7, v8, v9) = calculate_taker_fees<T0>(arg0, arg1, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg4.quote_filled_ask, arg4.quote_filled_bid), arg5, arg6, arg7);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_collateral_usd(arg0, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v6, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v7, v8)), arg2);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_filled_taker_order(*arg8, arg3, v6, v7, v8, v9, arg4.base_filled_ask, arg4.quote_filled_ask, arg4.base_filled_bid, arg4.quote_filled_bid);
        (v7, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v4, 0), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v0, 0)), v9, v8)
    }

    fun process_post(arg0: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position, arg1: u64, arg2: &SessionSummary) {
        if (arg2.posted_orders == 0) {
            return
        };
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::update_pending_orders(arg0, true, arg2.posted_orders);
        assert!(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(arg0) <= arg1, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::max_pending_orders_exceeded());
        if (arg2.base_posted_ask != 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_pending_amount(arg0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::ask(), arg2.base_posted_ask);
        };
        if (arg2.base_posted_bid != 0) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_pending_amount(arg0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::bid(), arg2.base_posted_bid);
        };
    }

    fun process_session_hot_potato<T0>(arg0: SessionHotPotato<T0>, arg1: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::Account<T0>, arg2: bool, arg3: 0x1::option::Option<IntegratorInfo>) : (ClearingHouse<T0>, SessionSummary) {
        let SessionHotPotato {
            clearing_house       : v0,
            orderbook            : v1,
            account_id           : v2,
            timestamp_ms         : v3,
            collateral_price     : v4,
            index_price          : v5,
            gas_price            : v6,
            margin_before        : v7,
            min_margin_before    : v8,
            position_base_before : _,
            total_open_interest  : v10,
            total_fees           : v11,
            maker_events         : v12,
            liqee_account_id     : v13,
            liquidator_fees      : v14,
            session_summary      : v15,
        } = arg0;
        let v16 = v15;
        let v17 = v13;
        let v18 = v12;
        let v19 = v10;
        let v20 = v1;
        let v21 = v0;
        let v22 = &mut v21;
        add_orderbook<T0>(v22, v20);
        let v23 = 0x2::object::id<ClearingHouse<T0>>(&v21);
        let v24 = !0x1::vector::is_empty<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::FilledMakerOrder>(&v18);
        let v25 = 0x1::option::is_some<u64>(&v17);
        let v26 = if (v25) {
            true
        } else if (v16.posted_orders != 0) {
            true
        } else {
            v24
        };
        assert!(v26, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::empty_session());
        let v27 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_u64(v6);
        let (v28, v29) = get_market_objects<T0>(&v21);
        let v30 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_haircut(v28);
        let (_, v32) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_maker_taker_fees(v28);
        let (v33, v34) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_max_open_interest_position_params(v28);
        let v35 = &mut v21;
        let v36 = get_position_mut<T0>(v35, v2);
        if (v25) {
            let (v37, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v36);
            let v39 = if (v16.base_liquidated != 0) {
                if (v16.is_liqee_long) {
                    0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_long_to_position(v36, v16.base_liquidated, v16.quote_liquidated)
                } else {
                    0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_short_to_position(v36, v16.base_liquidated, v16.quote_liquidated)
                }
            } else {
                0
            };
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_collateral_usd(v36, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v39, v14), v4);
            let (v40, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v36);
            v19 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v10, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v40, 0), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::max(v37, 0)));
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_performed_liquidation(v23, 0x1::option::destroy_some<u64>(v17), v2, v16.is_liqee_long, v16.base_liquidated, v16.quote_liquidated, v39, v14);
        };
        if (v24) {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_filled_maker_orders(v18);
        };
        let (v42, v43, v44, v45) = if (v16.base_filled_ask != 0 || v16.base_filled_bid != 0) {
            process_fill_taker<T0>(v36, arg1, v4, v2, &v16, v32, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_additional_gas_price_taker_fee(v29, v28, v27), arg3, &v23)
        } else {
            (0, 0, 0x1::option::none<address>(), 0)
        };
        let v46 = v44;
        process_post(v36, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_max_pending_orders(v28), &v16);
        let (v47, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v36);
        let (v49, v50) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::compute_margin(v36, v4, v5, get_imr_for_position(v36, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_margin_ratio_initial(v28)), v30);
        if (arg2) {
            if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v50, v49)) {
                let v51 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div_up(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v50, v49), v4);
                let v52 = v51;
                if (v30 != 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::one_fixed()) {
                    v52 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div_up(v51, v30);
                };
                assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v7), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::position_bad_debt());
                let v53 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(v52, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(v28));
                let v54 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::account::get_collateral_mut<T0>(arg1);
                assert!(0x2::balance::value<T0>(v54) >= v53, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::not_enough_collateral_to_allocate_for_session());
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_collateral(v36, v52);
                let v55 = &mut v21;
                0x2::balance::join<T0>(&mut get_market_vault_mut<T0>(v55).collateral_balance, 0x2::balance::split<T0>(v54, v53));
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_allocated_collateral(0x2::object::id<ClearingHouse<T0>>(&v21), v2, v53);
            };
        } else {
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::ensure_margin_requirements(v7, v8, v49, v50);
        };
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::try_update_fundings_and_twaps(&v21.market_params, &mut v21.market_state, v3, v5, book_price_or_index(&v20, v5), v27, &v23);
        let v56 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v11, v42);
        let v57 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v19, v43);
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v56), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::negative_fees_accrued());
        if (v56 != 0 || v57 != 0) {
            let v58 = &mut v21;
            let v59 = get_market_state_mut<T0>(v58);
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::add_fees_accrued_usd(v59, v56, v4);
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::add_to_open_interest(v59, v57);
            let v60 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_open_interest(v59);
            assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(v60, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_max_open_interest(v28)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::max_open_interest_surpassed());
            if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::greater_than(v60, v33)) {
                assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v47), v60), v34), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::max_position_open_interest_percent_surpassed());
            };
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_updated_open_interest_and_fees_accrued(v23, v60, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_fees_accrued(v59));
        };
        if (0x1::option::is_some<address>(&v46)) {
            let v61 = 0x1::option::destroy_some<address>(v46);
            let v62 = &mut v21;
            let v63 = get_integrator_vault_mut<T0>(v62, v61);
            v63.fees = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v63.fees, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v45, v4));
            0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_paid_integrator_fees<T0>(v2, v61, v45);
        };
        (v21, v16)
    }

    public(friend) fun reduce_liquidated_position(arg0: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::Position, arg1: u64, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256) : (u256, u256, bool, u256, u256, u256, u256, u256, u256, u256, u256) {
        let (v0, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(arg0);
        let (v2, v3) = get_base_and_quote_deltas(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(arg3, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()), arg1);
        let v4 = !0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v0);
        let (v5, v6) = if (v4) {
            (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_short_to_position(arg0, v2, v3), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::neg(v2))
        } else {
            (0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_long_to_position(arg0, v2, v3), 0)
        };
        let v7 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg5, v3);
        let v8 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(arg6, v3);
        let v9 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v8, arg7);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::add_to_collateral_usd(arg0, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(v5, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v9, v7)), arg4);
        let v10 = 0;
        if (0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_collateral(arg0))) {
            v10 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::reset_collateral(arg0);
        };
        let (v11, v12) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::compute_margin(arg0, arg4, arg2, arg8, arg9);
        (v11, v12, v4, v2, v3, v5, v9, v8, v7, v10, v6)
    }

    public(friend) fun reject_position_fees_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::position_fees_proposal(arg1);
        assert!(0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::PositionFeesProposal>(&arg0.id, v0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::proposal_does_not_exist());
        let PositionFeesProposal {
            maker_fee : v1,
            taker_fee : v2,
        } = 0x2::dynamic_field::remove<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::PositionFeesProposal, PositionFeesProposal>(&mut arg0.id, v0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_rejected_position_fees_proposal(0x2::object::id<ClearingHouse<T0>>(arg0), arg1, v1, v2);
    }

    public(friend) fun remove_orderbook<T0>(arg0: &mut ClearingHouse<T0>) : 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook {
        0x2::dynamic_object_field::remove<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::Orderbook, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::orderbook::Orderbook>(&mut arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::market_orderbook())
    }

    public(friend) fun reset_position_fees<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64) {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(arg0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::update_position_fees(get_position_mut<T0>(arg0, arg1), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::null_fee(), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::null_fee());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_resetted_position_fees(v0, arg1);
    }

    public(friend) fun resume_market<T0>(arg0: &mut ClearingHouse<T0>) {
        arg0.paused = false;
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_resumed_market(0x2::object::id<ClearingHouse<T0>>(arg0));
    }

    fun settle_liquidated_position<T0>(arg0: &mut SessionHotPotato<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::object::ID) : u256 {
        let (v0, v1) = get_market_objects<T0>(&arg0.clearing_house);
        let (v2, v3, v4) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_liquidation_fee_rates(v0);
        let v5 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(v0);
        let v6 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_margin_ratio_initial(v0);
        let v7 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_margin_ratio_maintenance(v0);
        let v8 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_haircut(v0);
        let (v9, v10) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(v1);
        let v11 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_fees_accrued(v1);
        let v12 = calculate_mark_price(v1, v0, arg0.index_price, book_price_or_index(&arg0.orderbook, arg0.index_price), arg0.timestamp_ms);
        let v13 = &mut arg0.clearing_house;
        let v14 = get_position_mut<T0>(v13, arg1);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::settle_position_funding(v14, arg0.collateral_price, v9, v10, arg5, arg1);
        let (v15, v16) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::compute_margin(v14, arg0.collateral_price, arg0.index_price, v7, v8);
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than(v15, v16), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::position_above_mmr());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_pending_amount(v14, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::ask(), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg2, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_pending_amount(v14, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::bid(), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg3, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::update_pending_orders(v14, false, arg4);
        let (v17, v18) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_amounts(v14);
        let v19 = if (v17 == 0) {
            if (v18 == 0) {
                0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_pending_orders_counter(v14) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v19, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::invalid_force_cancel_ids());
        let v20 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(v2, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(arg2 + arg3, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()), arg0.index_price));
        let (v21, v22) = compute_size_to_liquidate(v14, arg0.index_price, arg0.collateral_price, v12, v6, v20, v3, v4, v8);
        let (v23, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v14);
        let v25 = if (v22) {
            0
        } else {
            clip_size_to_liquidate(v21, v23, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_lot_size(v0))
        };
        let (v26, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36) = reduce_liquidated_position(v14, v25, arg0.index_price, v12, arg0.collateral_price, v4, v3, v20, v6, v8);
        let v37 = v36;
        let v38 = v35;
        let v39 = v34;
        let v40 = v33;
        let v41 = v32;
        let v42 = v31;
        let v43 = v30;
        let v44 = v29;
        if (v26 < v27) {
            assert!(!0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::abort_on_unhealthy_liquidation(), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::liquidated_position_still_unhealthy());
            let (v45, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v14);
            let (_, _, _, v50, v51, v52, v53, v54, v55, v56, v57) = reduce_liquidated_position(v14, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(v45), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::b9_scaling()), arg0.index_price, v12, arg0.collateral_price, v4, v3, 0, v6, v8);
            v44 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v29, v50);
            v43 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v30, v51);
            v42 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v31, v52);
            v41 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v32, v53);
            v40 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v33, v54);
            v39 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v34, v55);
            v38 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v35, v56);
            v37 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(v36, v57);
        };
        let v58 = &mut arg0.clearing_house;
        let v59 = get_market_vault_mut<T0>(v58);
        transfer_from_vault_to_insurance_fund<T0>(v59, v11, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v39, arg0.collateral_price), v5);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_liquidated_position(*arg5, arg1, arg0.account_id, v28, v44, v43, v42, v40, v20, v39, v38);
        arg0.total_open_interest = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::add(arg0.total_open_interest, v37);
        arg0.liqee_account_id = 0x1::option::some<u64>(arg1);
        arg0.liquidator_fees = v41;
        arg0.session_summary.base_liquidated = v44;
        arg0.session_summary.quote_liquidated = v43;
        arg0.session_summary.is_liqee_long = v28;
        arg0.session_summary.bad_debt = v38;
        v12
    }

    public(friend) fun share_clearing_house<T0>(arg0: ClearingHouse<T0>) {
        0x2::transfer::share_object<ClearingHouse<T0>>(arg0);
    }

    public(friend) fun start_session<T0>(arg0: ClearingHouse<T0>, arg1: u64, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: u64) : SessionHotPotato<T0> {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(&arg0);
        let (v1, v2) = get_market_objects<T0>(&arg0);
        let v3 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_oracle_price(v1, arg3, arg4, arg5);
        let v4 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_oracle_price(v1, arg2, arg4, arg5);
        let (v5, v6) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(v2);
        let v7 = &mut arg0;
        let v8 = get_position_mut<T0>(v7, arg1);
        let (v9, _) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::get_amounts(v8);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::settle_position_funding(v8, v3, v5, v6, &v0, arg1);
        let (v11, v12) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::compute_margin(v8, v3, v4, get_imr_for_position(v8, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_margin_ratio_initial(v1)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_haircut(v1));
        let v13 = &mut arg0;
        SessionHotPotato<T0>{
            clearing_house       : arg0,
            orderbook            : remove_orderbook<T0>(v13),
            account_id           : arg1,
            timestamp_ms         : 0x2::clock::timestamp_ms(arg5),
            collateral_price     : v3,
            index_price          : v4,
            gas_price            : arg6,
            margin_before        : v11,
            min_margin_before    : v12,
            position_base_before : v9,
            total_open_interest  : 0,
            total_fees           : 0,
            maker_events         : 0x1::vector::empty<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::FilledMakerOrder>(),
            liqee_account_id     : 0x1::option::none<u64>(),
            liquidator_fees      : 0,
            session_summary      : create_session_summary(),
        }
    }

    fun take_collateral<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg4: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg5: &0x2::clock::Clock, arg6: u64, arg7: 0x1::option::Option<u64>) : u64 {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(arg0);
        let (v1, v2) = get_market_objects<T0>(arg0);
        let v3 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(v1);
        let v4 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_oracle_price(v1, arg3, arg4, arg5);
        let v5 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_margin_ratio_initial(v1);
        let (v6, v7) = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_cum_funding_rates(v2);
        let v8 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_fees_accrued(v2);
        let v9 = get_position_mut<T0>(arg0, arg6);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::settle_position_funding(v9, v4, v6, v7, &v0, arg6);
        let v10 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::compute_free_collateral(v9, v4, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_oracle_price(v1, arg2, arg4, arg5), get_imr_for_position(v9, v5), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_haircut(v1)), v3);
        let v11 = if (0x1::option::is_some<u64>(&arg7)) {
            let v12 = 0x1::option::destroy_some<u64>(arg7);
            assert!(v12 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::deposit_or_withdraw_amount_zero());
            assert!(v10 >= v12, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::insufficient_free_collateral());
            v12
        } else {
            if (v10 == 0) {
                return 0
            };
            v10
        };
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::position::sub_from_collateral(v9, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(v11, v3));
        let v13 = get_market_vault_mut<T0>(arg0);
        0x2::balance::join<T0>(arg1, 0x2::balance::split<T0>(&mut v13.collateral_balance, 0x1::u64::min(v11, get_vault_collateral_balance<T0>(v13, v8, v3))));
        v11
    }

    fun transfer_from_insurance_fund_to_vault<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u256) {
        0x2::balance::join<T0>(&mut arg0.collateral_balance, 0x2::balance::split<T0>(&mut arg0.insurance_fund_balance, 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(arg1, arg2)));
    }

    fun transfer_from_vault_to_insurance_fund<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u256, arg3: u256) {
        0x2::balance::join<T0>(&mut arg0.insurance_fund_balance, 0x2::balance::split<T0>(&mut arg0.collateral_balance, 0x1::u64::min(get_vault_collateral_balance<T0>(arg0, arg1, arg3), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(arg2, arg3))));
    }

    fun try_socialize_bad_debt(arg0: &mut 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::MarketState, arg1: u256, arg2: bool, arg3: u256, arg4: u256, arg5: u256, arg6: &0x2::object::ID) {
        let v0 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_open_interest(arg0);
        assert!(v0 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::no_open_interest_to_socialize_bad_debt());
        let v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(arg3, v0);
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(arg3, arg4), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::bad_debt_above_threshold());
        assert!(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::less_than_eq(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v1, arg1), arg5), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::bad_debt_above_threshold());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::add_bad_debt_to_market(arg0, arg6, !arg2, arg3, v1);
    }

    public(friend) fun update_clearing_house_version<T0>(arg0: &mut ClearingHouse<T0>) {
        arg0.version = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::version();
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_updated_clearing_house_version(0x2::object::id<ClearingHouse<T0>>(arg0), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::version());
    }

    public fun verify_sltp_encrypted_details(arg0: &vector<u8>, arg1: 0x2::object::ID, arg2: 0x1::option::Option<u64>, arg3: bool, arg4: 0x1::option::Option<u256>, arg5: 0x1::option::Option<u256>, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: &vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::option::Option<u64>>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::option::Option<u256>>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::option::Option<u256>>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg9));
        0x1::vector::append<u8>(&mut v0, *arg10);
        assert!(0x2::hash::blake2b256(&v0) == *arg0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::wrong_order_details());
    }

    public fun verify_standalone_encrypted_details(arg0: &vector<u8>, arg1: 0x2::object::ID, arg2: 0x1::option::Option<u64>, arg3: bool, arg4: u256, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: &vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::option::Option<u64>>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg6));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg9));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg10));
        0x1::vector::append<u8>(&mut v0, *arg11);
        assert!(0x2::hash::blake2b256(&v0) == *arg0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::wrong_order_details());
    }

    public(friend) fun withdraw_fees<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<ClearingHouse<T0>>(arg0);
        let v1 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::reset_fees_accrued(&mut arg0.market_state), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(&arg0.market_params));
        assert!(v1 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::no_fees_accrued());
        let v2 = get_market_vault_mut<T0>(arg0);
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_withdrew_fees(0x2::tx_context::sender(arg1), v0, v1, 0x2::balance::value<T0>(&v2.collateral_balance));
        0x2::coin::take<T0>(&mut v2.collateral_balance, v1, arg1)
    }

    public(friend) fun withdraw_from_integrator_vault<T0>(arg0: &mut ClearingHouse<T0>, arg1: address) : 0x2::balance::Balance<T0> {
        assert!(0x2::dynamic_field::exists_<0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::IntegratorVault>(&arg0.id, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::keys::integrator_vault(arg1)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::integrator_vault_does_not_exist());
        let (v0, v1) = get_market_objects<T0>(arg0);
        let v2 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(v0);
        let v3 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_fees_accrued(v1);
        let v4 = get_integrator_vault_mut<T0>(arg0, arg1);
        let v5 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(v4.fees, v2);
        v4.fees = 0;
        let v6 = get_market_vault_mut<T0>(arg0);
        let v7 = 0x1::u64::min(v5, get_vault_collateral_balance<T0>(v6, v3, v2));
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_withdrew_from_integrator_vault(0x2::object::id<ClearingHouse<T0>>(arg0), arg1, v7);
        0x2::balance::split<T0>(&mut v6.collateral_balance, v7)
    }

    public(friend) fun withdraw_insurance_fund<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg2: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::price_feed_storage::PriceFeedStorage, arg3: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::config::Config, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg5 != 0, 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::deposit_or_withdraw_amount_zero());
        let v0 = &arg0.market_params;
        let v1 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_scaling_factor(v0);
        let v2 = 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_collateral_oracle_price(v0, arg2, arg3, arg4);
        let v3 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::abs(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_open_interest(&arg0.market_state)), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::market::get_base_oracle_price(v0, arg1, arg3, arg4));
        let v4 = get_market_vault_mut<T0>(arg0);
        let v5 = 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::sub(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::from_balance(0x2::balance::value<T0>(&v4.insurance_fund_balance), v1), v2), 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::mul(0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::constants::insurance_open_interest_fraction(), v3));
        assert!(!0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::is_neg(v5), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::deposit_or_withdraw_amount_zero());
        assert!(arg5 <= 0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::to_balance(0x46234ba81f3a5ba6571383233df0f9ea5fe60a3a327537be1f5fec447bced693::ifixed::div(v5, v2), v1), 0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::errors::insufficient_insurance_surplus());
        0x6fa23473ffed570bbbe95c21939ce9853c5f97dbe4c97664e67580aedb20268b::events::emit_withdrew_insurance_fund(0x2::tx_context::sender(arg6), 0x2::object::id<ClearingHouse<T0>>(arg0), arg5, 0x2::balance::value<T0>(&v4.insurance_fund_balance));
        0x2::coin::take<T0>(&mut v4.insurance_fund_balance, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

