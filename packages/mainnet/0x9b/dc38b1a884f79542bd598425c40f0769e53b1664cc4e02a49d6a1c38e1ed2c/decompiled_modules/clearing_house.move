module 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::clearing_house {
    struct ClearingHouse<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: u8,
        market_params: 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketParams,
        market_state: 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketState,
        orderbook: 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Orderbook,
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

    struct SettlementPrices has store {
        base_price: u256,
        collateral_price: u256,
        open_interest: u256,
        deallocate_collateral: bool,
        enabled: bool,
    }

    struct Executor has drop {
        sender: address,
        domain: 0x1::option::Option<address>,
    }

    struct SessionHotPotato<phantom T0> {
        clearing_house: ClearingHouse<T0>,
        account_id: u64,
        timestamp_ms: u64,
        collateral_price: u256,
        mark_price: u256,
        uses_priority_gas_price: bool,
        margin_before: u256,
        min_margin_before: u256,
        position_base_before: u256,
        total_open_interest: u256,
        total_fees: u256,
        taker_pending_cancelled: bool,
        maker_events: vector<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder>,
        integrator_info: 0x1::option::Option<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>,
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

    public fun position<T0>(arg0: &ClearingHouse<T0>, arg1: u64) : &0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position {
        0x2::dynamic_field::borrow<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::PositionKey, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::position(arg1))
    }

    public fun settle_position_funding<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_oracle_price(&arg0.market_params, arg1, arg3);
        let (v1, v2) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(&arg0.market_state);
        let v3 = 0x2::object::uid_to_inner(&arg0.id);
        let v4 = borrow_mut_position<T0>(arg0, arg2);
        settle_position_funding_and_emit(v4, v0, v1, v2, &v3, arg2);
    }

    public fun account_id<T0>(arg0: &SessionHotPotato<T0>) : u64 {
        arg0.account_id
    }

    public fun clearing_house<T0>(arg0: &SessionHotPotato<T0>) : &ClearingHouse<T0> {
        &arg0.clearing_house
    }

    fun add_position<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position) {
        assert!(!0x2::dynamic_field::exists<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::PositionKey>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::position(arg1)), 41);
        0x2::dynamic_field::add<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::PositionKey, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position>(&mut arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::position(arg1), arg2);
    }

    public fun admin_set_paused_market<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PACKAGE, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PAUSE_GUARDIAN>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: u8) {
        assert_package_version<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_authority_cap_is_authorized<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PACKAGE, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PAUSE_GUARDIAN>(arg2, arg1);
        assert_market_is_not_closed<T0>(arg0);
        assert_valid_pause_mode(arg3);
        arg0.paused = arg3;
    }

    public fun allocate_collateral<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: u64) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert!(arg3 != 0, 0);
        let v0 = borrow_mut_market_vault<T0>(arg0);
        0x2::balance::join<T0>(&mut v0.collateral_balance, 0x2::balance::split<T0>(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::borrow_mut_collateral<T0>(arg2), arg3));
        let v1 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(&arg0.market_params);
        let v2 = borrow_mut_position<T0>(arg0, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg2));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral(v2, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg3, v1));
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_allocated_collateral(0x2::object::uid_to_inner(&arg0.id), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg2), arg3);
    }

    fun assert_market_allows_order_cancellation<T0>(arg0: &ClearingHouse<T0>) {
        assert!(arg0.paused != 1, 32);
    }

    fun assert_market_is_closed<T0>(arg0: &ClearingHouse<T0>) {
        assert!(0x2::dynamic_field::exists<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::SettlementPricesKey>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::settlement_prices()), 34);
    }

    public(friend) fun assert_market_is_not_closed<T0>(arg0: &ClearingHouse<T0>) {
        assert!(!0x2::dynamic_field::exists<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::SettlementPricesKey>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::settlement_prices()), 35);
    }

    public(friend) fun assert_market_is_not_paused<T0>(arg0: &ClearingHouse<T0>) {
        assert!(arg0.paused == 0, 32);
    }

    fun assert_market_is_paused<T0>(arg0: &ClearingHouse<T0>) {
        assert!(is_market_paused<T0>(arg0), 33);
    }

    fun assert_order_value(arg0: u64, arg1: u256, arg2: u256) {
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg0, 1000000000), arg1) >= arg2, 3);
    }

    public(friend) fun assert_package_version<T0>(arg0: &ClearingHouse<T0>) {
        assert!(arg0.version <= 3, 10);
    }

    fun assert_reduce_only<T0>(arg0: &SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: bool) : u64 {
        if (arg3) {
            let v1 = if (arg0.session_summary.base_liquidated == 0) {
                0
            } else if (arg0.session_summary.is_liqee_long) {
                arg0.session_summary.base_liquidated
            } else {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::neg(arg0.session_summary.base_liquidated)
            };
            let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.position_base_before, v1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg0.session_summary.base_filled_bid, arg0.session_summary.base_filled_ask));
            assert!(v2 != 0 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v2) != arg1, 9);
            0x1::u64::min(arg2, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v2), 1000000000))
        } else {
            arg2
        }
    }

    fun assert_settlement_prices(arg0: u256, arg1: u256) {
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(arg0, 0) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(arg1, 0), 49);
    }

    fun assert_valid_pause_mode(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 53);
    }

    public fun base_filled_ask(arg0: &SessionSummary) : u256 {
        arg0.base_filled_ask
    }

    public fun base_filled_bid(arg0: &SessionSummary) : u256 {
        arg0.base_filled_bid
    }

    public fun best_price<T0>(arg0: &ClearingHouse<T0>, arg1: bool) : 0x1::option::Option<u256> {
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::best_price(orderbook<T0>(arg0), arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<u256>()
        };
        0x1::option::some<u256>(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x1::option::destroy_some<u64>(v0), 1000000000))
    }

    public fun best_price_u64<T0>(arg0: &ClearingHouse<T0>, arg1: bool) : 0x1::option::Option<u64> {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::best_price(orderbook<T0>(arg0), arg1)
    }

    public fun book_price<T0>(arg0: &ClearingHouse<T0>) : 0x1::option::Option<u256> {
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::book_price(orderbook<T0>(arg0));
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<u256>()
        };
        0x1::option::some<u256>(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x1::option::destroy_some<u64>(v0), 1000000000))
    }

    public(friend) fun borrow_mut_market_objects<T0>(arg0: &mut ClearingHouse<T0>) : (&0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketParams, &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketState) {
        (&arg0.market_params, &mut arg0.market_state)
    }

    public(friend) fun borrow_mut_market_params<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketParams {
        &mut arg0.market_params
    }

    public(friend) fun borrow_mut_market_state<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketState {
        &mut arg0.market_state
    }

    public(friend) fun borrow_mut_market_vault<T0>(arg0: &mut ClearingHouse<T0>) : &mut Vault<T0> {
        0x2::dynamic_field::borrow_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarketVaultKey, Vault<T0>>(&mut arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::market_vault())
    }

    public(friend) fun borrow_mut_orderbook<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Orderbook {
        &mut arg0.orderbook
    }

    public fun orderbook<T0>(arg0: &ClearingHouse<T0>) : &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Orderbook {
        &arg0.orderbook
    }

    public(friend) fun borrow_mut_position<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64) : &mut 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position {
        0x2::dynamic_field::borrow_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::PositionKey, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position>(&mut arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::position(arg1))
    }

    fun borrow_mut_position_from_id(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position {
        0x2::dynamic_field::borrow_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::PositionKey, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position>(arg0, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::position(arg1))
    }

    public(friend) fun borrow_mut_settlement_prices<T0>(arg0: &mut ClearingHouse<T0>) : &mut SettlementPrices {
        0x2::dynamic_field::borrow_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::SettlementPricesKey, SettlementPrices>(&mut arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::settlement_prices())
    }

    public fun cancel_orders<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: vector<u128>) {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(arg0);
        assert_market_allows_order_cancellation<T0>(arg0);
        cancel_orders_<T0>(arg0, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg2), &arg3, 0);
    }

    fun cancel_orders_<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: &vector<u128>, arg3: u8) {
        let v0 = 0x1::vector::length<u128>(arg2);
        assert!(v0 != 0, 6);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = borrow_mut_orderbook<T0>(arg0);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u128>(arg2)) {
            let v6 = *0x1::vector::borrow<u128>(arg2, v5);
            let (v7, v8) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::cancel_limit_order(v2, arg1, v6);
            if (v6 < 170141183460469231731687303715884105728) {
                v3 = v3 + v7;
            } else {
                v4 = v4 + v7;
            };
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_canceled_order(v1, arg1, v6, v8, v7, arg3);
            v5 = v5 + 1;
        };
        let v9 = borrow_mut_position<T0>(arg0, arg1);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v9, true, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v3, 1000000000));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v9, false, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v4, 1000000000));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::update_pending_orders(v9, false, v0);
    }

    public fun clip_size_to_liquidate(arg0: u256, arg1: u256, arg2: u64) : u128 {
        if (arg2 != 1) {
            0x1::u128::min(0x1::u128::div_ceil(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_u128balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg0), 1000000000) + 1, (arg2 as u128)) * (arg2 as u128), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_u128balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg1), 1000000000))
        } else {
            0x1::u128::min(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_u128balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg0), 1000000000) + 1, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_u128balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(arg1), 1000000000))
        }
    }

    public fun close_market<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: u256, arg6: u256, arg7: bool) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        assert_market_is_not_closed<T2>(arg0);
        assert_settlement_prices(arg5, arg6);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::try_update_funding(&arg0.market_params, &mut arg0.market_state, arg3, arg4, &v0, book_price<T2>(arg0));
        arg0.paused = 1;
        let v1 = SettlementPrices{
            base_price            : arg5,
            collateral_price      : arg6,
            open_interest         : 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::open_interest(&arg0.market_state),
            deallocate_collateral : arg7,
            enabled               : false,
        };
        0x2::dynamic_field::add<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::SettlementPricesKey, SettlementPrices>(&mut arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::settlement_prices(), v1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_closed_market(0x2::object::uid_to_inner(&arg0.id), arg5, arg6, arg7, false);
    }

    public fun close_position_at_settlement_prices<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: &vector<u128>) {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::assert_is_admin_or_assistant<T1>();
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        close_position_at_settlement_prices_<T0>(arg0, arg2, arg3, true);
    }

    fun close_position_at_settlement_prices_<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg2: &vector<u128>, arg3: bool) {
        assert_package_version<T0>(arg0);
        assert_market_is_paused<T0>(arg0);
        assert_market_is_closed<T0>(arg0);
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg1);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = settlement_prices<T0>(arg0);
        let v3 = v2.base_price;
        let v4 = v2.collateral_price;
        let v5 = v2.open_interest;
        let v6 = v2.deallocate_collateral;
        assert!(!arg3 || v2.enabled, 36);
        if (!0x1::vector::is_empty<u128>(arg2)) {
            cancel_orders_<T0>(arg0, v0, arg2, 3);
        };
        let (v7, v8) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(&arg0.market_state);
        let v9 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(&arg0.market_params);
        let v10 = borrow_mut_position<T0>(arg0, v0);
        let (v11, v12) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_base_amounts_by_side(v10);
        let v13 = if (v11 == 0) {
            if (v12 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v10) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v13, 48);
        settle_position_funding_and_emit(v10, v4, v7, v8, &v1, v0);
        let (v14, v15) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v10);
        let v16 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v14);
        let v17 = 0;
        let v18 = 0;
        if (v14 != 0) {
            let v19 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v14);
            let (v20, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_base_to_position(v10, !v16, v19, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v19, v3));
            v18 = v20;
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral_usd(v10, v20, v4);
            if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v10))) {
                v17 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::reset_collateral(v10);
            };
        };
        let (v22, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v10);
        let v24 = if (v6) {
            let v25 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v10);
            let v26 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v25, v9);
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_collateral(v10, v25);
            let v27 = borrow_mut_market_vault<T0>(arg0);
            assert!(0x2::balance::value<T0>(&v27.collateral_balance) >= v26, 23);
            0x2::balance::join<T0>(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::borrow_mut_collateral<T0>(arg1), 0x2::balance::split<T0>(&mut v27.collateral_balance, v26));
            v26
        } else {
            0
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::add_to_open_interest(&mut arg0.market_state, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(v22, 0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(v14, 0)));
        if (v17 != 0) {
            handle_bad_debt<T0>(arg0, v17, v3, v4, !v16, &v1, 0x1::option::some<u256>(v5));
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_closed_position_at_settlement_prices(v1, v0, v18, v14, v15, v24, v17);
    }

    public fun close_position_at_settlement_prices_as_admin<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T2>, arg4: &vector<u128>) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        assert_market_is_paused<T2>(arg0);
        assert_market_is_closed<T2>(arg0);
        close_position_at_settlement_prices_<T2>(arg0, arg3, arg4, false);
    }

    public fun collateral_and_insurance_fund_balances<T0>(arg0: &ClearingHouse<T0>) : (u64, u64) {
        let v0 = market_vault<T0>(arg0);
        (0x2::balance::value<T0>(&v0.collateral_balance), 0x2::balance::value<T0>(&v0.insurance_fund_balance))
    }

    fun collateral_for_margin_increase(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        if (arg2 == 0) {
            return 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div_up(arg3, arg1)
        };
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg0, arg1);
        let v1 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0)) {
            let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::neg(v0);
            if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg3, v2)) {
                arg3
            } else {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v2, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div_up(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg3, v2), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, arg2)))
            }
        } else {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div_up(arg3, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, arg2))
        };
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div_up(v1, arg1)
    }

    fun collateral_symbol<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())))
    }

    public fun collateral_to_deallocate_for_margin_ratio<T0>(arg0: &ClearingHouse<T0>, arg1: u64, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u256>) : u64 {
        let v0 = market_params<T0>(arg0);
        let v1 = market_state<T0>(arg0);
        let (v2, v3) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(v1);
        let (v4, v5) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::base_oracle_price_and_twap_price(v0, arg2, arg4);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::assert_index_twap_divergence_within_limit(v0, v4, v5);
        let v6 = position<T0>(arg0, arg1);
        let v7 = if (0x1::option::is_some<u256>(&arg5)) {
            0x1::option::destroy_some<u256>(arg5)
        } else {
            0x1::option::destroy_none<u256>(arg5);
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::initial_margin_ratio(v6)
        };
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v7, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::margin_ratio_initial(v0)), 42);
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_free_collateral_with_fundings(v6, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_oracle_price(v0, arg3, arg4), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::calculate_mark_price(v1, v0, v5, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::book_price_or_index(orderbook<T0>(arg0), v4), 0x2::clock::timestamp_ms(arg4)), v7, v2, v3, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_haircut(v0)), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(v0))
    }

    public fun commit_margin_ratios_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x2::clock::Clock) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::margin_ratio_proposal();
        assert!(0x2::dynamic_field::exists<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarginRatioProposalKey>(&arg0.id, v0), 28);
        let MarginRatioProposal {
            maturity                 : v1,
            margin_ratio_initial     : v2,
            margin_ratio_maintenance : v3,
        } = 0x2::dynamic_field::remove<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarginRatioProposalKey, MarginRatioProposal>(&mut arg0.id, v0);
        assert!(v1 <= 0x2::clock::timestamp_ms(arg1), 26);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::update_margin_ratios(&mut arg0.market_params, v2, v3);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_updated_margin_ratios(0x2::object::uid_to_inner(&arg0.id), v2, v3);
    }

    public fun compute_liquidation_size_and_mode(arg0: &0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : (u256, bool) {
        let (v0, v1) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(arg0);
        let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v0);
        let (v3, v4) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_and_requirement(arg0, arg1, arg2, arg3, arg6);
        if (arg6 == 0) {
            return compute_liquidation_size_no_haircut(v0, v1, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(arg0), v2, arg1, arg2, arg4, arg5, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg3, arg2), v2), v3, v4)
        };
        compute_liquidation_size_with_haircut(v0, v1, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(arg0), v2, arg1, arg2, arg4, arg5, arg6, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg3, arg2), v2), v3, v4)
    }

    fun compute_liquidation_size_no_haircut(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256) : (u256, bool) {
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(arg9, arg10)) {
            return (0, true)
        };
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg9, 0)) {
            return (arg3, false)
        };
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div_up(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg8, liquidation_collateral_rounding_cushion(arg4)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg5, arg0), arg1), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg4, arg2))), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg8, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg6, arg7), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg5, arg3))));
        if (!valid_liquidation_alpha(v0)) {
            return (arg3, false)
        };
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v0, arg3), false)
    }

    fun compute_liquidation_size_with_haircut(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256) : (u256, bool) {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(1000000000000000000, arg8);
        let v1 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg5, arg0), arg1);
        let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg6, arg7), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg5, arg3));
        let v3 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg4, arg2);
        let v4 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v3, v1);
        let v5 = liquidation_collateral_rounding_cushion(arg4);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(arg10, arg11)) {
            return (0, true)
        };
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v4, 0)) {
            return (arg3, false)
        };
        let v6 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v1, v2);
        let v7 = 0;
        let v8 = false;
        let v9 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg9, v2);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v9, 0)) {
            let v10 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div_up(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg9, v5), v4), v9);
            if (valid_liquidation_alpha(v10) && !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v3, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v10, v6)), 0)) {
                v7 = v10;
                v8 = true;
            };
        };
        let v11 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg9, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg8, v1)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v2, v0));
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v11, 0)) {
            let v12 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div_up(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg9, v5), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v1, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v3, v0))), v11);
            let v13 = if (valid_liquidation_alpha(v12)) {
                if (!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v3, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v12, v6)))) {
                    !v8 || 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(v12, v7)
                } else {
                    false
                }
            } else {
                false
            };
            if (v13) {
                v7 = v12;
                v8 = true;
            };
        };
        if (!v8) {
            return (arg3, false)
        };
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v7, arg3), false)
    }

    public fun create_clearing_house<T0, T1, T2>(arg0: 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Orderbook, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, T2>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::clock::Clock, arg5: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg6: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg7: u16, arg8: u16, arg9: u256, arg10: u256, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u256, arg18: u256, arg19: u256, arg20: u256, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) : ClearingHouse<T0> {
        create_clearing_house_<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, (0x2::coin::get_decimals<T0>(arg3) as u64), arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23)
    }

    fun create_clearing_house_<T0, T1, T2>(arg0: 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Orderbook, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, T2>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &0x2::clock::Clock, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg6: u16, arg7: u16, arg8: u64, arg9: u256, arg10: u256, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u256, arg18: u256, arg19: u256, arg20: u256, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) : ClearingHouse<T0> {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, T2>(arg2, arg1);
        assert!(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::contains(arg4, arg6), 17);
        assert!(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::contains(arg5, arg7), 17);
        let v0 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::storage_id(arg4);
        let v1 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::storage_id(arg5);
        let v2 = Vault<T0>{
            collateral_balance     : 0x2::balance::zero<T0>(),
            insurance_fund_balance : 0x2::balance::zero<T0>(),
        };
        let (v3, v4) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::create_market_objects(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::config(arg2), arg3, arg9, arg10, v0, v1, arg6, arg7, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::decimal_scalar_from_decimals(arg8) as u256));
        let v5 = ClearingHouse<T0>{
            id            : 0x2::object::new(arg23),
            version       : 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::version(arg2),
            paused        : 0,
            market_params : v3,
            market_state  : v4,
            orderbook     : arg0,
        };
        0x2::dynamic_field::add<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarketVaultKey, Vault<T0>>(&mut v5.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::market_vault(), v2);
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_created_clearing_house(v6, collateral_symbol<T0>(), arg8, arg9, arg10, v0, arg6, v1, arg7, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22);
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::VendorClearingHouseKey<T1>, vector<0x2::object::ID>>(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::borrow_mut_id(arg2), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::vendor_clearing_house_key<T1>()), v6);
        v5
    }

    public fun create_clearing_house_with_currency<T0, T1, T2>(arg0: 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Orderbook, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, T2>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::clock::Clock, arg5: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg6: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg7: u16, arg8: u16, arg9: u256, arg10: u256, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u256, arg18: u256, arg19: u256, arg20: u256, arg21: u64, arg22: u64, arg23: &mut 0x2::tx_context::TxContext) : ClearingHouse<T0> {
        create_clearing_house_<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, (0x2::coin_registry::decimals<T0>(arg3) as u64), arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21, arg22, arg23)
    }

    public fun create_client_order_id(arg0: u64) : 0x1::option::Option<u64> {
        0x1::option::some<u64>(arg0)
    }

    public fun create_margin_ratios_proposal<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: u64, arg4: u256, arg5: u256, arg6: &0x2::clock::Clock) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        assert!(!0x2::dynamic_field::exists<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarginRatioProposalKey>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::margin_ratio_proposal()), 25);
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::config(arg2);
        assert!(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::min_proposal_delay_ms(v0) <= arg3 && arg3 <= 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::max_proposal_delay_ms(v0), 27);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::assert_margin_ratios(arg4, arg5);
        let (v1, v2) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::liquidation_fee_rates(&arg0.market_params);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::assert_liquidation_fees_against_mmr(arg5, v1, v2);
        let v3 = MarginRatioProposal{
            maturity                 : 0x2::clock::timestamp_ms(arg6) + arg3,
            margin_ratio_initial     : arg4,
            margin_ratio_maintenance : arg5,
        };
        0x2::dynamic_field::add<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarginRatioProposalKey, MarginRatioProposal>(&mut arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::margin_ratio_proposal(), v3);
    }

    public fun create_market_position<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>) {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let (v0, v1) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(&arg0.market_state);
        let v2 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg2);
        add_position<T0>(arg0, v2, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::create_position(v0, v1));
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_created_position(0x2::object::uid_to_inner(&arg0.id), v2, v0, v1);
    }

    public fun create_orderbook<T0, T1>(arg0: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg1: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Orderbook {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg1, arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::create_orderbook(arg2, arg3, arg4, arg5, arg6, arg7, arg8)
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

    public fun deallocate_collateral<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        deallocate_collateral_<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<u64>(arg5), arg6)
    }

    fun deallocate_collateral_<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock) : u64 {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        deallocate_collateral_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public(friend) fun deallocate_collateral_internal<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg1);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = market_params<T0>(arg0);
        let v4 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_oracle_price(v3, arg3, arg5);
        let (v5, v6) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::base_oracle_price_and_twap_price(v3, arg2, arg5);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::assert_index_twap_divergence_within_limit(v3, v5, v6);
        let v7 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::book_price_or_index(orderbook<T0>(arg0), v5);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::try_update_fundings_and_twaps(&arg0.market_params, &mut arg0.market_state, v2, v5, v7, &v1);
        let v8 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::borrow_mut_collateral<T0>(arg1);
        let v9 = withdraw_free_collateral_to_account_balance<T0>(arg0, v8, v2, v4, v6, v7, v0, arg4);
        if (v9 != 0) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_deallocated_collateral(v1, v0, v9);
        };
        v9
    }

    public fun deallocate_free_collateral<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) : u64 {
        deallocate_collateral_<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<u64>(), arg5)
    }

    public fun delete_margin_ratios_proposal<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &0x2::clock::Clock) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::margin_ratio_proposal();
        assert!(0x2::dynamic_field::exists<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarginRatioProposalKey>(&arg0.id, v0), 28);
        let MarginRatioProposal {
            maturity                 : v1,
            margin_ratio_initial     : _,
            margin_ratio_maintenance : _,
        } = 0x2::dynamic_field::remove<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarginRatioProposalKey, MarginRatioProposal>(&mut arg0.id, v0);
        assert!(0x2::clock::timestamp_ms(arg3) < v1, 31);
    }

    public fun domain_executor(arg0: &0x2::object::UID, arg1: &0x2::tx_context::TxContext) : Executor {
        Executor{
            sender : 0x2::tx_context::sender(arg1),
            domain : 0x1::option::some<address>(0x2::object::uid_to_address(arg0)),
        }
    }

    public fun donate_to_insurance_fund<T0>(arg0: &mut ClearingHouse<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_package_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 != 0, 0);
        let v1 = borrow_mut_market_vault<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_donated_to_insurance_fund(0x2::tx_context::sender(arg2), 0x2::object::uid_to_inner(&arg0.id), v0, 0x2::balance::join<T0>(&mut v1.insurance_fund_balance, 0x2::coin::into_balance<T0>(arg1)));
    }

    public fun end_session<T0, T1>(arg0: SessionHotPotato<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: bool, arg4: bool) : (ClearingHouse<T0>, SessionSummary) {
        assert_package_version<T0>(&arg0.clearing_house);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        end_session_<T0>(arg0, arg2, arg3, arg4, false)
    }

    public(friend) fun end_session_<T0>(arg0: SessionHotPotato<T0>, arg1: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg2: bool, arg3: bool, arg4: bool) : (ClearingHouse<T0>, SessionSummary) {
        assert!(account_id<T0>(&arg0) == 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg1), 18);
        let SessionHotPotato {
            clearing_house          : v0,
            account_id              : v1,
            timestamp_ms            : _,
            collateral_price        : v3,
            mark_price              : v4,
            uses_priority_gas_price : v5,
            margin_before           : v6,
            min_margin_before       : v7,
            position_base_before    : v8,
            total_open_interest     : v9,
            total_fees              : v10,
            taker_pending_cancelled : v11,
            maker_events            : v12,
            integrator_info         : v13,
            liqee_account_id        : v14,
            liquidator_fees         : v15,
            session_summary         : v16,
        } = arg0;
        let v17 = v16;
        let v18 = v14;
        let v19 = v13;
        let v20 = v12;
        let v21 = v9;
        let v22 = v0;
        let v23 = 0x2::object::uid_to_inner(&v22.id);
        let v24 = 0x1::option::is_some<u64>(&v18);
        assert!(arg4 || session_has_activity(&v17, &v20, &v18), 11);
        let (v25, v26) = market_objects<T0>(&v22);
        let v27 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_haircut(v25);
        let v28 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::taker_fee(v25);
        let v29 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(v25);
        let (v30, v31) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::max_open_interest_position_params(v25);
        let v32 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::open_interest(v26);
        let v33 = v17.bad_debt != 0;
        let (v34, v35) = if (v33) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(v26)
        } else {
            (0, 0)
        };
        let v36 = &mut v22;
        let v37 = borrow_mut_position<T0>(v36, v1);
        let v38 = v8;
        if (v24) {
            let (v39, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v37);
            if (v33) {
                settle_position_funding_and_emit(v37, v3, v34, v35, &v23, v1);
            };
            let v41 = if (v17.base_liquidated != 0) {
                let (v42, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_base_to_position(v37, !v17.is_liqee_long, v17.base_liquidated, v17.quote_liquidated);
                v42
            } else {
                0
            };
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral_usd(v37, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v41, v15), v3);
            let (v44, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v37);
            v38 = v44;
            v21 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v9, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(v44, 0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(v39, 0)));
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_performed_liquidation(v23, 0x1::option::destroy_some<u64>(v18), v1, v17.is_liqee_long, v17.base_liquidated, v17.quote_liquidated, v41, v15, v4);
        };
        if (!0x1::vector::is_empty<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder>(&v20)) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_filled_maker_orders(v20);
        };
        let v46;
        let v47;
        let v48;
        if (v17.base_filled_ask != 0) {
        } else if (v17.base_filled_bid != 0) {
        } else {
            v46 = 0;
            v48 = 0;
            v47 = 0;
            /* goto 31 */
        };
        let v49 = v28;
        if (v5) {
            let v50 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::resolve_priority_taker_fee(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::priority_taker_fee(v25));
            if (v50 != 0) {
                v49 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v28, v50);
            };
        };
        let (v51, v52) = if (0x1::option::is_some<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>(&v19)) {
            let v53 = 0x1::option::borrow<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>(&v19);
            (0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::integrator_fee(v53), 0x1::option::some<u32>(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::integrator_id(v53)))
        } else {
            (0, 0x1::option::none<u32>())
        };
        let (v54, v55, v56, v57) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::apply_taker_fills_and_settle(v37, v3, v17.base_filled_ask, v17.quote_filled_ask, v17.base_filled_bid, v17.quote_filled_bid, v49, v51);
        v48 = v57;
        v47 = v56;
        v46 = v55;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_filled_taker_order(v23, v1, v54, v55, v52, v56, v17.base_filled_ask, v17.quote_filled_ask, v17.base_filled_bid, v17.quote_filled_bid, v4);
        /* label 31 */
        process_post(v37, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::max_pending_orders(v25), &v17);
        let (v58, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v37);
        let (v60, v61, v62) = if (arg3) {
            let (v63, v64, v65) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_and_free_collateral(v37, v3, v4, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v37, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::margin_ratio_initial(v25)), v27);
            (v65, v63, v64)
        } else {
            let (v66, v67) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_and_requirement(v37, v3, v4, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v37, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::margin_ratio_initial(v25)), v27);
            (0, v66, v67)
        };
        let (v68, v69) = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v62, v61)) {
            if (arg2) {
                assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v6), 39);
                let v70 = ((collateral_for_margin_increase(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(v37), v3, v27, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v62, v61)) / v29) as u64);
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral(v37, (v70 as u256) * v29);
                (v70, true)
            } else {
                assert!(!v24, 52);
                let v71 = v11 && v17.posted_orders != 0;
                assert!(!v71, 54);
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::ensure_margin_requirements(v6, v7, v61, v62, v8, v58);
                (0, false)
            }
        } else if (arg3) {
            let v72 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(v60, v29);
            if (v72 != 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_collateral(v37, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v72, v29));
            };
            (v72, false)
        } else {
            (0, false)
        };
        if (v68 != 0) {
            if (v69) {
                let v73 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::borrow_mut_collateral<T0>(arg1);
                assert!(v68 <= 0x2::balance::value<T0>(v73), 30);
                let v74 = &mut v22;
                0x2::balance::join<T0>(&mut borrow_mut_market_vault<T0>(v74).collateral_balance, 0x2::balance::split<T0>(v73, v68));
                0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_allocated_collateral(v23, v1, v68);
            } else {
                let v75 = &mut v22;
                let v76 = borrow_mut_market_vault<T0>(v75);
                let v77 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::borrow_mut_collateral<T0>(arg1);
                withdraw_vault_collateral<T0>(v76, v77, v68);
                0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_deallocated_collateral(v23, v1, v68);
            };
        };
        if (0x1::option::is_some<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>(&v19)) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::validate_session_integrator_info<T0>(arg1, 0x1::option::borrow<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>(&v19));
        };
        let v78 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v10, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v46, v47));
        let v79 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v21, v48);
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v78), 13);
        let v80 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v32, v79);
        if (v78 != 0 || v79 != 0) {
            let v81 = &mut v22;
            let v82 = borrow_mut_market_state<T0>(v81);
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::add_fees_accrued_usd(v82, v78, v3);
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::add_to_open_interest(v82, v79);
            assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v80, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::max_open_interest(v25)) || 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v80, v32), 15);
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_updated_open_interest_and_fees_accrued(v23, v80, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::fees_accrued(v82));
        };
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v80, v30) && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v58), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v38))) {
            assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v58), v80), v31), 16);
        };
        (v22, v17)
    }

    fun execute_limit_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: bool, arg7: 0x1::option::Option<u64>) : (u64, 0x1::option::Option<u128>) {
        assert!(arg4 < 4, 44);
        let v0 = &arg0.clearing_house.market_params;
        let v1 = &arg0.clearing_house.market_state;
        let (v2, _) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::liquidation_fee_rates(v0);
        let (v4, v5) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(v1);
        let v6 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::open_interest(v1);
        let (v7, v8) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::max_open_interest_position_params(v0);
        let v9 = arg1 && false || true;
        let v10 = &mut arg0.clearing_house.id;
        let v11 = &mut arg0.clearing_house.orderbook;
        let v12 = &mut arg0.session_summary;
        let v13 = &mut arg0.taker_pending_cancelled;
        let v14 = &mut arg0.maker_events;
        let v15 = arg0.account_id;
        let v16 = arg0.timestamp_ms;
        let v17 = arg0.mark_price;
        assert!(0x1::option::get_with_default<u64>(&arg7, 18446744073709551615) >= v16, 14);
        let (v18, v19) = if (arg1) {
            let v19 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::borrow_mut_bids(v11);
            (((arg3 ^ 18446744073709551615) as u128), v19)
        } else {
            let v19 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::borrow_mut_asks(v11);
            ((arg3 as u128), v19)
        };
        let v20 = 0;
        let v21 = true;
        let v22 = false;
        let v23 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::first_leaf_ptr<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19);
        while (v23 != 0) {
            let v24 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::get_leaf_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19, v23);
            v23 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::next<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v24);
            let v25 = 0;
            while (v25 < 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::size<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v24)) {
                let (v26, v27) = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::elem_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v24, v25);
                if (v26 >> 64 > v18) {
                    v22 = true;
                    break
                };
                v20 = v26;
                let (v28, v29, v30, v31) = process_fill_maker(v12, v10, v26, v27, v16, arg0.collateral_price, v17, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::maker_fee(v0), v2, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_haircut(v0), v4, v5, v6, v7, v8, v15, arg2, v13);
                let v32 = v30;
                let v33 = arg2 - v28;
                arg2 = v33;
                v21 = v29;
                arg0.total_fees = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.total_fees, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::maker_fees_paid_usd(&v32), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::maker_integrator_fee_paid_usd(&v32)));
                arg0.total_open_interest = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.total_open_interest, v31);
                0x1::vector::push_back<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder>(v14, v32);
                if (v33 == 0) {
                    break
                };
                v25 = v25 + 1;
            };
            if (v22 || arg2 == 0) {
                break
            };
        };
        if (arg4 == 1) {
            assert!(arg2 == 0, 46);
        };
        if (arg4 == 2) {
            assert!(arg2 == arg2, 47);
        };
        if (arg4 == 3) {
            arg2 = 0;
        };
        if (v20 > 0) {
            0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::batch_drop<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19, v20, v21);
            let v34 = if (0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::is_empty<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19)) {
                0x1::option::none<u64>()
            } else {
                let v35 = if (v9) {
                    ((0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::min_key<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19) >> 64) as u64)
                } else {
                    ((0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::min_key<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19) >> 64) as u64) ^ 18446744073709551615
                };
                0x1::option::some<u64>(v35)
            };
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::set_best_price(v11, v9, v34);
        };
        let v36 = 0x1::option::none<u128>();
        if (arg2 != 0) {
            let (v37, v38) = if (0x1::option::is_some<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>(&arg0.integrator_info)) {
                let v39 = 0x1::option::borrow<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>(&arg0.integrator_info);
                (0x1::option::some<u32>(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::integrator_id(v39)), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::integrator_fee_b9(v39))
            } else {
                (0x1::option::none<u32>(), 0)
            };
            let v40 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::post_order(v11, v15, arg1, arg2, arg3, arg5, arg6, arg7, arg0.integrator_info);
            v36 = 0x1::option::some<u128>(v40);
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_posted_order(0x2::object::uid_to_inner(&arg0.clearing_house.id), v15, v40, arg5, arg2, arg6, arg7, v37, v38, v17);
            arg0.session_summary.posted_orders = arg0.session_summary.posted_orders + 1;
            if (arg1) {
                arg0.session_summary.base_posted_ask = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.session_summary.base_posted_ask, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg2, 1000000000));
            } else {
                arg0.session_summary.base_posted_bid = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.session_summary.base_posted_bid, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg2, 1000000000));
            };
        };
        (arg2, v36)
    }

    fun execute_liquidation<T0>(arg0: &mut SessionHotPotato<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::object::uid_to_inner(&arg0.clearing_house.id);
        let v1 = &v0;
        settle_liquidated_position<T0>(arg0, arg1, arg2, arg3, arg4, v1);
        if (arg0.session_summary.bad_debt != 0) {
            let v2 = &mut arg0.clearing_house;
            handle_bad_debt<T0>(v2, arg0.session_summary.bad_debt, arg0.mark_price, arg0.collateral_price, arg0.session_summary.is_liqee_long, v1, 0x1::option::none<u256>());
        };
    }

    fun execute_market_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64) {
        let v0 = &arg0.clearing_house.market_params;
        let v1 = &arg0.clearing_house.market_state;
        let (v2, _) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::liquidation_fee_rates(v0);
        let (v4, v5) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(v1);
        let v6 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::open_interest(v1);
        let (v7, v8) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::max_open_interest_position_params(v0);
        let v9 = arg1 && false || true;
        let v10 = &mut arg0.clearing_house.id;
        let v11 = &mut arg0.clearing_house.orderbook;
        let v12 = &mut arg0.session_summary;
        let v13 = &mut arg0.taker_pending_cancelled;
        let v14 = &mut arg0.maker_events;
        let v15 = if (arg1) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::borrow_mut_bids(v11)
        } else {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::borrow_mut_asks(v11)
        };
        let v16 = 0;
        let v17 = true;
        let v18 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::first_leaf_ptr<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v15);
        while (v18 != 0) {
            let v19 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::get_leaf_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v15, v18);
            v18 = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::next<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19);
            let v20 = 0;
            while (v20 < 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::size<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19)) {
                let (v21, v22) = 0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::elem_mut<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v19, v20);
                v16 = v21;
                let (v23, v24, v25, v26) = process_fill_maker(v12, v10, v21, v22, arg0.timestamp_ms, arg0.collateral_price, arg0.mark_price, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::maker_fee(v0), v2, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_haircut(v0), v4, v5, v6, v7, v8, arg0.account_id, arg2, v13);
                let v27 = v25;
                let v28 = arg2 - v23;
                arg2 = v28;
                v17 = v24;
                arg0.total_fees = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.total_fees, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::maker_fees_paid_usd(&v27), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::maker_integrator_fee_paid_usd(&v27)));
                arg0.total_open_interest = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.total_open_interest, v26);
                0x1::vector::push_back<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder>(v14, v27);
                if (v28 == 0) {
                    break
                };
                v20 = v20 + 1;
            };
            if (arg2 == 0) {
                break
            };
        };
        assert!(arg2 == 0, 45);
        if (v16 > 0) {
            0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::batch_drop<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v15, v16, v17);
            let v29 = if (0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::is_empty<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v15)) {
                0x1::option::none<u64>()
            } else {
                let v30 = if (v9) {
                    ((0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::min_key<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v15) >> 64) as u64)
                } else {
                    ((0xf453864f39b7c6122551f665d4fe961b8625853cf89bcae55be4b3b99e848126::ordered_map::min_key<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order>(v15) >> 64) as u64) ^ 18446744073709551615
                };
                0x1::option::some<u64>(v30)
            };
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::set_best_price(v11, v9, v29);
        };
    }

    public fun execution_price(arg0: &SessionSummary, arg1: bool) : u256 {
        if (arg1 && arg0.base_filled_ask != 0) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(arg0.quote_filled_ask, arg0.base_filled_ask)
        } else if (!arg1 && arg0.base_filled_bid != 0) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(arg0.quote_filled_bid, arg0.base_filled_bid)
        } else {
            0
        }
    }

    public fun executor_domain(arg0: &Executor) : 0x1::option::Option<address> {
        arg0.domain
    }

    public fun executor_sender(arg0: &Executor) : address {
        arg0.sender
    }

    public fun exists_position<T0>(arg0: &ClearingHouse<T0>, arg1: u64) : bool {
        0x2::dynamic_field::exists<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::PositionKey>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::position(arg1))
    }

    public fun fill_base_and_quote_deltas(arg0: u64, arg1: u64) : (u256, u256) {
        (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg1, 1000000000), (arg1 as u256) * (arg0 as u256))
    }

    public fun filled_base_and_quote(arg0: &SessionSummary, arg1: bool) : (u256, u256) {
        if (arg1) {
            (arg0.base_filled_ask, arg0.quote_filled_ask)
        } else {
            (arg0.base_filled_bid, arg0.quote_filled_bid)
        }
    }

    public(friend) fun force_cancel_orders(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Orderbook, arg1: u64, arg2: &vector<u128>, arg3: 0x2::object::ID, arg4: u8) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v0 < 0x1::vector::length<u128>(arg2)) {
            let v3 = *0x1::vector::borrow<u128>(arg2, v0);
            let (v4, v5) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::cancel_limit_order(arg0, arg1, v3);
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_canceled_order(arg3, arg1, v3, v5, v4, arg4);
            if (v3 < 170141183460469231731687303715884105728) {
                v1 = v1 + v4;
            } else {
                v2 = v2 + v4;
            };
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    public fun freeze_clearing_house<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PACKAGE, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::FREEZE_GUARDIAN>) {
        assert_package_version<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_authority_cap_is_authorized<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PACKAGE, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::FREEZE_GUARDIAN>(arg1, arg2);
        let v0 = arg0.version;
        0x2::dynamic_field::add<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::FrozenVersionKey, u64>(&mut arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::frozen_version(), v0);
        arg0.version = 18446744073709551615;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_froze(0x2::object::uid_to_inner(&arg0.id), v0, 0x2::object::id<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PACKAGE, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::FREEZE_GUARDIAN>>(arg2));
    }

    fun handle_bad_debt<T0>(arg0: &mut ClearingHouse<T0>, arg1: u256, arg2: u256, arg3: u256, arg4: bool, arg5: &0x2::object::ID, arg6: 0x1::option::Option<u256>) {
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(&arg0.market_params);
        let (v1, v2) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::max_bad_debt_thresholds(&arg0.market_params);
        let v3 = borrow_mut_market_vault<T0>(arg0);
        let v4 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x2::balance::value<T0>(&v3.insurance_fund_balance), v0);
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than_eq(v4, arg1)) {
            transfer_from_insurance_fund_to_vault<T0>(v3, arg1, v0);
        } else {
            transfer_from_insurance_fund_to_vault<T0>(v3, v4, v0);
            let v5 = &mut arg0.market_state;
            try_socialize_bad_debt(v5, arg2, arg4, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(arg1, v4), arg3), v1, v2, arg5, arg6);
        };
    }

    public fun is_frozen<T0>(arg0: &ClearingHouse<T0>) : bool {
        0x2::dynamic_field::exists_with_type<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::FrozenVersionKey, u64>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::frozen_version())
    }

    public fun is_market_cancel_only<T0>(arg0: &ClearingHouse<T0>) : bool {
        arg0.paused == 2
    }

    public fun is_market_paused<T0>(arg0: &ClearingHouse<T0>) : bool {
        arg0.paused != 0
    }

    public fun liquidate<T0>(arg0: &mut SessionHotPotato<T0>, arg1: u64, arg2: &vector<u128>) {
        assert_package_version<T0>(&arg0.clearing_house);
        assert!(arg0.account_id != arg1, 8);
        let v0 = &mut arg0.clearing_house.orderbook;
        let v1 = &arg0.session_summary;
        let v2 = if (0x1::vector::length<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder>(&arg0.maker_events) == 0) {
            if (v1.posted_orders == 0) {
                0x1::option::is_none<u64>(&arg0.liqee_account_id)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 5);
        let v3 = 0x1::vector::length<u128>(arg2);
        let (v4, v5) = if (v3 != 0) {
            let (v6, v7) = force_cancel_orders(v0, arg1, arg2, 0x2::object::uid_to_inner(&arg0.clearing_house.id), 1);
            (v7, v6)
        } else {
            (0, 0)
        };
        execute_liquidation<T0>(arg0, arg1, v5, v4, v3);
    }

    public fun liquidated_size(arg0: &SessionSummary) : u64 {
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(arg0.base_liquidated, 1000000000)
    }

    public fun liquidation_bad_debt(arg0: &SessionSummary) : u256 {
        arg0.bad_debt
    }

    public fun liquidation_base_quote_and_side(arg0: &SessionSummary) : (u256, u256, bool) {
        (arg0.base_liquidated, arg0.quote_liquidated, arg0.is_liqee_long)
    }

    fun liquidation_collateral_rounding_cushion(arg0: u256) : u256 {
        (arg0 + 999999999999999999) / 1000000000000000000
    }

    public fun liquidation_mark_price(arg0: &SessionSummary) : u256 {
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(arg0.quote_liquidated, arg0.base_liquidated)
    }

    public fun liquidation_mark_price_b9(arg0: &SessionSummary) : u64 {
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(arg0.quote_liquidated, arg0.base_liquidated), 1000000000)
    }

    public fun mark_price<T0>(arg0: &ClearingHouse<T0>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) : u256 {
        let (v0, v1) = market_objects<T0>(arg0);
        let (v2, v3) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::base_oracle_price_and_twap_price(v0, arg1, arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::assert_index_twap_divergence_within_limit(v0, v2, v3);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::calculate_mark_price(v1, v0, v3, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::book_price_or_index(orderbook<T0>(arg0), v2), 0x2::clock::timestamp_ms(arg2))
    }

    public fun mark_price_in_session<T0>(arg0: &SessionHotPotato<T0>) : u256 {
        arg0.mark_price
    }

    public fun market_objects<T0>(arg0: &ClearingHouse<T0>) : (&0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketParams, &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketState) {
        (&arg0.market_params, &arg0.market_state)
    }

    public fun market_params<T0>(arg0: &ClearingHouse<T0>) : &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketParams {
        &arg0.market_params
    }

    public fun market_pause_mode<T0>(arg0: &ClearingHouse<T0>) : u8 {
        arg0.paused
    }

    public fun market_state<T0>(arg0: &ClearingHouse<T0>) : &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketState {
        &arg0.market_state
    }

    public fun market_vault<T0>(arg0: &ClearingHouse<T0>) : &Vault<T0> {
        0x2::dynamic_field::borrow<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::MarketVaultKey, Vault<T0>>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::market_vault())
    }

    public fun no_domain_executor(arg0: &0x2::tx_context::TxContext) : Executor {
        Executor{
            sender : 0x2::tx_context::sender(arg0),
            domain : 0x1::option::none<address>(),
        }
    }

    public fun place_limit_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: bool, arg7: 0x1::option::Option<u64>) : 0x1::option::Option<u128> {
        assert_package_version<T0>(&arg0.clearing_house);
        assert!(arg3 != 0 && arg3 < 9223372036854775808, 3900);
        assert!(arg3 % 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::tick_size(&arg0.clearing_house.market_params) == 0, 20);
        let v0 = assert_reduce_only<T0>(arg0, arg1, arg2, arg6);
        assert!(v0 % 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::lot_size(&arg0.clearing_house.market_params) == 0, 19);
        assert!(v0 != 0, 1);
        let (v1, v2) = execute_limit_order<T0>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7);
        if (v1 != 0) {
            assert_order_value(v1, arg0.mark_price, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::min_order_usd_value(&arg0.clearing_house.market_params));
        };
        v2
    }

    public fun place_market_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: bool) {
        assert_package_version<T0>(&arg0.clearing_house);
        let v0 = assert_reduce_only<T0>(arg0, arg1, arg2, arg3);
        assert!(v0 % 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::lot_size(&arg0.clearing_house.market_params) == 0, 19);
        assert!(v0 != 0, 1);
        execute_market_order<T0>(arg0, arg1, v0);
    }

    public fun posted_base_by_side(arg0: &SessionSummary) : (u256, u256) {
        (arg0.base_posted_ask, arg0.base_posted_bid)
    }

    public fun posted_orders(arg0: &SessionSummary) : u64 {
        arg0.posted_orders
    }

    fun process_fill_maker(arg0: &mut SessionSummary, arg1: &mut 0x2::object::UID, arg2: u128, arg3: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::Order, arg4: u64, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u64, arg16: u64, arg17: &mut bool) : (u64, bool, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder, u256) {
        let v0 = 0x2::object::uid_to_inner(arg1);
        let (v1, v2, v3, v4, v5, v6) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::order_snapshot(arg3);
        let v7 = v6;
        let v8 = borrow_mut_position_from_id(arg1, v1);
        settle_position_funding_and_emit(v8, arg5, arg10, arg11, &v0, v1);
        let (v9, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v8);
        let v11 = arg2 < 170141183460469231731687303715884105728;
        let v12 = 0x1::option::none<u8>();
        let v13 = 0x1::option::none<u8>();
        let v14 = if (v4) {
            v12 = 0x1::option::some<u8>(4);
            if (v9 != 0 && (v11 && !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v9) || !v11 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v9))) {
                0x1::u64::min(v3, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v9), 1000000000))
            } else {
                0
            }
        } else {
            v3
        };
        let v15 = v14;
        if (arg4 >= 0x1::option::destroy_with_default<u64>(v5, 18446744073709551615)) {
            v15 = 0;
            v12 = 0x1::option::some<u8>(5);
        } else if (arg15 == v1) {
            v15 = 0;
            v12 = 0x1::option::some<u8>(6);
        };
        let (v16, v17, v18, v19, v20, v21, v22) = if (v15 != 0 && arg16 != 0) {
            let v23 = if (arg2 < 170141183460469231731687303715884105728) {
                ((arg2 >> 64) as u64)
            } else {
                ((arg2 >> 64) as u64) ^ 18446744073709551615
            };
            let (v24, v25) = fill_base_and_quote_deltas(v23, 0x1::u64::min(v15, arg16));
            let v26 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg12, v24);
            let v27 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v26, arg13)) {
                0x1::option::some<u256>(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v26, arg14))
            } else {
                0x1::option::none<u256>()
            };
            let v28 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg7, v25);
            let (v29, v30) = if (0x1::option::is_some<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>(&v7)) {
                let v31 = 0x1::option::borrow<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>(&v7);
                (0x1::option::some<u32>(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::integrator_id(v31)), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::integrator_fee(v31), v25))
            } else {
                (0x1::option::none<u32>(), 0)
            };
            let (v32, v33, v34) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::apply_maker_fill_or_restore_if_bad_debt(v8, v11, v24, v25, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v28, v30), arg8, arg5, arg6, arg9, v27);
            if (v32) {
                (v24, v25, v33, v28, v29, v30, v34)
            } else {
                v15 = 0;
                v12 = 0x1::option::some<u8>(7);
                (0, 0, 0, 0, 0x1::option::none<u32>(), 0, v9)
            }
        } else {
            (0, 0, 0, 0, 0x1::option::none<u32>(), 0, v9)
        };
        let v35 = 0;
        let v36 = true;
        let v37 = if (v15 == v3) {
            if (arg16 >= v15) {
                v15
            } else {
                0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::reduce_order_size(arg3, arg16);
                v36 = false;
                arg16
            }
        } else if (arg16 >= v15) {
            let v38 = v3 - v15;
            v35 = v38;
            v13 = v12;
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v8, v11, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v38, 1000000000));
            if (arg15 == v1 && v38 != 0) {
                *arg17 = true;
            };
            v15
        } else {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::reduce_order_size(arg3, arg16);
            v36 = false;
            arg16
        };
        if (v36) {
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::update_pending_orders(v8, false, 1);
        };
        let v39 = if (v37 != 0) {
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v8, v11, v16);
            if (v11) {
                assert!(arg0.base_filled_ask == 0, 51);
                arg0.base_filled_bid = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.base_filled_bid, v16);
                arg0.quote_filled_bid = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.quote_filled_bid, v17);
            } else {
                assert!(arg0.base_filled_bid == 0, 51);
                arg0.base_filled_ask = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.base_filled_ask, v16);
                arg0.quote_filled_ask = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.quote_filled_ask, v17);
            };
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(v22, 0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::max(v9, 0))
        } else {
            0
        };
        (v37, v36, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::create_filled_maker_order(v0, v1, arg15, arg2, v2, v37, v3 - v37 - v35, v35, v13, v18, v19, arg6, v20, v21), v39)
    }

    fun process_post(arg0: &mut 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position, arg1: u64, arg2: &SessionSummary) {
        if (arg2.posted_orders == 0) {
            return
        };
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::update_pending_orders(arg0, true, arg2.posted_orders);
        assert!(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(arg0) <= arg1, 37);
        if (arg2.base_posted_ask != 0) {
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_pending_amount(arg0, true, arg2.base_posted_ask);
        };
        if (arg2.base_posted_bid != 0) {
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_pending_amount(arg0, false, arg2.base_posted_bid);
        };
    }

    public(friend) fun reduce_liquidated_position(arg0: &mut 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position, arg1: u128, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256) : (u256, u256, bool, u256, u256, u256, u256, u256, u256, u256) {
        let (v0, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(arg0);
        let v2 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_u128balance(arg1, 1000000000);
        let v3 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v2, arg2);
        let v4 = !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v0);
        let (v5, v6, v7) = if (arg1 != 0) {
            let (v8, v9) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_base_to_position(arg0, v4, v2, v3);
            let v10 = if (v4) {
                0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::neg(v2)
            } else {
                0
            };
            (v8, v10, v9)
        } else {
            (0, 0, v0)
        };
        let v11 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg4, v3);
        let v12 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(arg5, v3);
        let v13 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v5, v12);
        let v14 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::collateral(arg0), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v13, arg3));
        let v15 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(v14, arg3);
        let v16 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v15, 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::unrealized_pnl(arg0, arg2));
        let v17 = 0;
        let v18 = v7 == 0 && 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v14);
        let v19 = if (!v18) {
            if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(v16, 0)) {
                !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v14)
            } else {
                false
            }
        } else {
            false
        };
        let v20 = if (v19) {
            0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::min(v15, v16)
        } else {
            0
        };
        let v21 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(v11, v20)) {
            v11
        } else {
            v20
        };
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::add_to_collateral_usd(arg0, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(v13, v21), arg3);
        if (v18) {
            v17 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::reset_collateral(arg0);
        };
        let (v22, v23) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_and_requirement(arg0, arg3, arg2, arg6, arg7);
        (v22, v23, v4, v2, v3, v5, v12, v21, v17, v6)
    }

    public fun register_market<T0, T1, T2>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &ClearingHouse<T2>) {
        assert_package_version<T2>(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg0, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg0, arg1, 0x2::object::uid_as_inner(&arg2.id));
        let v0 = market_params<T2>(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::register_market<T2>(arg0, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::base_storage_id(v0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::base_source_id(v0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_storage_id(v0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_source_id(v0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(v0), 0x2::object::uid_to_inner(&arg2.id));
    }

    public fun remove_registered_market<T0, T1, T2>(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &ClearingHouse<T2>) {
        assert_package_version<T2>(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg0, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg0, arg1, 0x2::object::uid_as_inner(&arg2.id));
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::remove_registered_market<T2>(arg0, 0x2::object::uid_to_inner(&arg2.id));
    }

    fun session_has_activity(arg0: &SessionSummary, arg1: &vector<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder>, arg2: &0x1::option::Option<u64>) : bool {
        if (0x1::option::is_some<u64>(arg2)) {
            true
        } else if (arg0.posted_orders != 0) {
            true
        } else {
            !0x1::vector::is_empty<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder>(arg1)
        }
    }

    public fun set_base_oracle_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u64>) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::storage_id(arg3);
        let v1 = if (0x1::option::is_some<u16>(&arg4)) {
            *0x1::option::borrow<u16>(&arg4)
        } else {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::base_source_id(market_params<T2>(arg0))
        };
        assert!(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::contains(arg3, v1), 17);
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::set_base_oracle_params(borrow_mut_market_params<T2>(arg0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::config(arg2), &v2, v0, 0x1::option::some<u16>(v1), arg5);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::set_base_oracle_params_<T2>(arg2, v2, v0, v1);
    }

    public fun set_collateral_oracle_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u64>) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::storage_id(arg3);
        let v1 = if (0x1::option::is_some<u16>(&arg4)) {
            *0x1::option::borrow<u16>(&arg4)
        } else {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_source_id(market_params<T2>(arg0))
        };
        assert!(0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::contains(arg3, v1), 17);
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::set_collateral_oracle_params(borrow_mut_market_params<T2>(arg0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::config(arg2), &v2, v0, 0x1::option::some<u16>(v1), arg5);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::set_collateral_oracle_params_<T2>(arg2, v2, v0, v1);
    }

    public fun set_core_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u256>) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::set_core_params(borrow_mut_market_params<T2>(arg0), &v0, arg3, arg4, arg5);
    }

    public fun set_fee_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u256>, arg5: 0x1::option::Option<u256>, arg6: 0x1::option::Option<u256>, arg7: 0x1::option::Option<0x1::option::Option<u256>>) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::set_fee_params(borrow_mut_market_params<T2>(arg0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::config(arg2), &v0, arg3, arg4, arg5, arg6, arg7);
    }

    public fun set_paused_market<T0, T1, T2>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, T2>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: u8) {
        assert_package_version<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        assert_market_is_not_closed<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T1, T2>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = if (v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ASSISTANT>()) {
            true
        } else {
            v0 == 0x1::type_name::with_defining_ids<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PAUSE_GUARDIAN>()
        };
        assert!(v1, 50);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_authority_cap_is_authorized<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, T2>(arg2, arg1);
        assert_valid_pause_mode(arg3);
        arg0.paused = arg3;
    }

    public fun set_position_initial_margin_ratio<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: u256) {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let (v0, _) = market_objects<T0>(arg0);
        let v2 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::margin_ratio_initial(v0);
        let v3 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg2);
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::set_initial_margin_ratio(borrow_mut_position<T0>(arg0, v3), arg3, v2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_set_position_initial_margin_ratio(v4, v3, arg3);
    }

    public fun set_risk_limit_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u256>, arg6: 0x1::option::Option<u256>, arg7: 0x1::option::Option<u256>, arg8: 0x1::option::Option<u256>, arg9: 0x1::option::Option<u256>, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::set_risk_limit_params(borrow_mut_market_params<T2>(arg0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::config(arg2), &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun set_settlement_prices<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u256>, arg5: 0x1::option::Option<bool>, arg6: 0x1::option::Option<bool>) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        assert_market_is_closed<T2>(arg0);
        let v0 = borrow_mut_settlement_prices<T2>(arg0);
        let v1 = if (0x1::option::is_some<u256>(&arg3)) {
            *0x1::option::borrow<u256>(&arg3)
        } else {
            v0.base_price
        };
        let v2 = if (0x1::option::is_some<u256>(&arg4)) {
            *0x1::option::borrow<u256>(&arg4)
        } else {
            v0.collateral_price
        };
        let v3 = 0x1::option::is_some<bool>(&arg5) && *0x1::option::borrow<bool>(&arg5) || v0.deallocate_collateral;
        let v4 = 0x1::option::is_some<bool>(&arg6) && *0x1::option::borrow<bool>(&arg6) || v0.enabled;
        assert_settlement_prices(v1, v2);
        v0.base_price = v1;
        v0.collateral_price = v2;
        v0.deallocate_collateral = v3;
        v0.enabled = v4;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_updated_settlement_prices(0x2::object::uid_to_inner(&arg0.id), v1, v2, v3, v4);
    }

    public fun set_twap_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>) {
        assert_package_version<T2>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_or_maintenance_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::set_twap_params(borrow_mut_market_params<T2>(arg0), 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::config(arg2), &v0, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun settle_liquidated_position<T0>(arg0: &mut SessionHotPotato<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::object::ID) {
        let (v0, v1) = market_objects<T0>(&arg0.clearing_house);
        let (v2, v3) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::liquidation_fee_rates(v0);
        let v4 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(v0);
        let v5 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::margin_ratio_initial(v0);
        let v6 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::margin_ratio_maintenance(v0);
        let v7 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_haircut(v0);
        let (v8, v9) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(v1);
        let v10 = arg0.mark_price;
        let v11 = &mut arg0.clearing_house;
        let v12 = borrow_mut_position<T0>(v11, arg1);
        settle_position_funding_and_emit(v12, arg0.collateral_price, v8, v9, arg5, arg1);
        let (v13, v14) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_and_requirement(v12, arg0.collateral_price, v10, v6, v7);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(v13, v14), 38);
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v12, true, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg2, 1000000000));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v12, false, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(arg3, 1000000000));
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::update_pending_orders(v12, false, arg4);
        let (v15, v16) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_base_amounts_by_side(v12);
        let v17 = if (v15 == 0) {
            if (v16 == 0) {
                0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::pending_order_count(v12) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v17, 4);
        let (v18, v19) = compute_liquidation_size_and_mode(v12, arg0.collateral_price, v10, v5, v2, v3, v7);
        let (v20, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v12);
        let v22 = if (v19) {
            0
        } else {
            clip_size_to_liquidate(v18, v20, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::lot_size(v0))
        };
        let (v23, v24, v25, v26, v27, v28, v29, v30, v31, v32) = reduce_liquidated_position(v12, v22, v10, arg0.collateral_price, v3, v2, v5, v7);
        let v33 = v32;
        let v34 = v31;
        let v35 = v30;
        let v36 = v29;
        let v37 = v28;
        let v38 = v27;
        let v39 = v26;
        if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(v23, v24)) {
            let (v40, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v12);
            let (_, _, _, v45, v46, v47, v48, v49, v50, v51) = reduce_liquidated_position(v12, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_u128balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(v40), 1000000000), v10, arg0.collateral_price, v3, v2, v5, v7);
            v39 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v26, v45);
            v38 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v27, v46);
            v37 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v28, v47);
            v36 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v29, v48);
            v35 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v30, v49);
            v34 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v31, v50);
            v33 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(v32, v51);
        };
        if (v35 != 0) {
            let v52 = &mut arg0.clearing_house;
            let v53 = borrow_mut_market_vault<T0>(v52);
            transfer_from_vault_to_insurance_fund<T0>(v53, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v35, arg0.collateral_price), v4);
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_liquidated_position(*arg5, arg1, arg0.account_id, v25, v39, v38, v37, v36, v35, v34, v10);
        arg0.total_open_interest = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::add(arg0.total_open_interest, v33);
        arg0.liqee_account_id = 0x1::option::some<u64>(arg1);
        arg0.liquidator_fees = v36;
        arg0.session_summary.base_liquidated = v39;
        arg0.session_summary.quote_liquidated = v38;
        arg0.session_summary.is_liqee_long = v25;
        arg0.session_summary.bad_debt = v34;
    }

    public(friend) fun settle_position_funding_and_emit(arg0: &mut 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::Position, arg1: u256, arg2: u256, arg3: u256, arg4: &0x2::object::ID, arg5: u64) {
        let (v0, v1, v2) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::settle_position_funding(arg0, arg1, arg2, arg3);
        if (v0) {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_settled_funding(*arg4, arg5, v1, v2, arg2, arg3);
        };
    }

    public fun settlement_prices<T0>(arg0: &ClearingHouse<T0>) : &SettlementPrices {
        0x2::dynamic_field::borrow<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::SettlementPricesKey, SettlementPrices>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::settlement_prices())
    }

    public fun share<T0>(arg0: ClearingHouse<T0>) {
        0x2::transfer::share_object<ClearingHouse<T0>>(arg0);
    }

    public fun start_session<T0, T1>(arg0: ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: 0x1::option::Option<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : SessionHotPotato<T0> {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(&arg0);
        assert_market_is_not_paused<T0>(&arg0);
        start_session_<T0>(arg0, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg2), arg3, arg4, 0x2::tx_context::gas_price(arg7) > 0x2::tx_context::reference_gas_price(arg7), arg5, arg6)
    }

    public(friend) fun start_session_<T0>(arg0: ClearingHouse<T0>, arg1: u64, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: bool, arg5: 0x1::option::Option<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::IntegratorInfo>, arg6: &0x2::clock::Clock) : SessionHotPotato<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = market_params<T0>(&arg0);
        let v3 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_oracle_price(v2, arg3, arg6);
        let (v4, v5) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::base_oracle_price_and_twap_price(v2, arg2, arg6);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::assert_index_twap_divergence_within_limit(v2, v4, v5);
        let v6 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::book_price_or_index(&arg0.orderbook, v4);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::try_update_fundings_and_twaps(&arg0.market_params, &mut arg0.market_state, v1, v4, v6, &v0);
        let (v7, v8) = market_objects<T0>(&arg0);
        let (v9, v10) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(v8);
        let v11 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::calculate_mark_price(v8, v7, v5, v6, v1);
        let v12 = &mut arg0;
        let v13 = borrow_mut_position<T0>(v12, arg1);
        let v14 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v13, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::margin_ratio_initial(v7));
        let (v15, _) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::base_and_quote_amounts(v13);
        settle_position_funding_and_emit(v13, v3, v9, v10, &v0, arg1);
        let (v17, v18) = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_margin_and_requirement(v13, v3, v11, v14, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_haircut(v7));
        SessionHotPotato<T0>{
            clearing_house          : arg0,
            account_id              : arg1,
            timestamp_ms            : v1,
            collateral_price        : v3,
            mark_price              : v11,
            uses_priority_gas_price : arg4,
            margin_before           : v17,
            min_margin_before       : v18,
            position_base_before    : v15,
            total_open_interest     : 0,
            total_fees              : 0,
            taker_pending_cancelled : false,
            maker_events            : 0x1::vector::empty<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::FilledMakerOrder>(),
            integrator_info         : arg5,
            liqee_account_id        : 0x1::option::none<u64>(),
            liquidator_fees         : 0,
            session_summary         : create_session_summary(),
        }
    }

    public fun summary<T0>(arg0: &SessionHotPotato<T0>) : &SessionSummary {
        &arg0.session_summary
    }

    public fun tick_rounded_liquidation_mark_price<T0>(arg0: &SessionHotPotato<T0>) : u64 {
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::tick_size(&arg0.clearing_house.market_params);
        0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(arg0.session_summary.quote_liquidated, arg0.session_summary.base_liquidated), 1000000000) / v0 * v0
    }

    fun transfer_from_insurance_fund_to_vault<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u256) {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(arg1, arg2);
        let v1 = if (0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v0, arg2) == arg1) {
            v0
        } else {
            v0 + 1
        };
        0x2::balance::join<T0>(&mut arg0.collateral_balance, 0x2::balance::split<T0>(&mut arg0.insurance_fund_balance, v1));
    }

    fun transfer_from_vault_to_insurance_fund<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u256) {
        let v0 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(arg1, arg2);
        assert!(0x2::balance::value<T0>(&arg0.collateral_balance) >= v0, 23);
        0x2::balance::join<T0>(&mut arg0.insurance_fund_balance, 0x2::balance::split<T0>(&mut arg0.collateral_balance, v0));
    }

    public fun try_cancel_orders<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::ACCOUNT, T1>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::Account<T0>, arg3: &vector<u128>) : vector<bool> {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(arg0);
        assert_market_allows_order_cancellation<T0>(arg0);
        let v0 = vector[];
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = borrow_mut_orderbook<T0>(arg0);
        let v3 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::account::account_id<T0>(arg2);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u128>(arg3)) {
            let v8 = *0x1::vector::borrow<u128>(arg3, v7);
            let (v9, v10, v11) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::orderbook::try_cancel_limit_order(v2, v3, v8);
            0x1::vector::push_back<bool>(&mut v0, v9);
            if (v9) {
                v6 = v6 + 1;
                if (v8 < 170141183460469231731687303715884105728) {
                    v4 = v4 + v10;
                } else {
                    v5 = v5 + v10;
                };
                0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_canceled_order(v1, v3, v8, v11, v10, 0);
            };
            v7 = v7 + 1;
        };
        if (v6 != 0) {
            let v12 = borrow_mut_position<T0>(arg0, v3);
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v12, true, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v4, 1000000000));
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_pending_amount(v12, false, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v5, 1000000000));
            0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::update_pending_orders(v12, false, v6);
        };
        v0
    }

    fun try_socialize_bad_debt(arg0: &mut 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::MarketState, arg1: u256, arg2: bool, arg3: u256, arg4: u256, arg5: u256, arg6: &0x2::object::ID, arg7: 0x1::option::Option<u256>) {
        let v0 = if (0x1::option::is_some<u256>(&arg7)) {
            0x1::option::destroy_some<u256>(arg7)
        } else {
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::open_interest(arg0)
        };
        assert!(v0 != 0, 21);
        let v1 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(arg3, v0);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(arg3, arg4), 22);
        assert!(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than_eq(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v1, arg1), arg5), 24);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::add_bad_debt_to_market(arg0, arg6, !arg2, arg3, v1);
    }

    public fun unfreeze_clearing_house<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PACKAGE, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>) {
        assert!(is_frozen<T0>(arg0), 55);
        let v0 = 0x2::dynamic_field::remove<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::FrozenVersionKey, u64>(&mut arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::frozen_version());
        assert!(v0 == 3, 56);
        arg0.version = v0;
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_unfroze(0x2::object::uid_to_inner(&arg0.id), v0);
    }

    public fun update_funding<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::try_update_funding(&arg0.market_params, &mut arg0.market_state, arg1, arg2, &v0, book_price<T0>(arg0));
    }

    public fun update_twaps<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::try_update_twaps(&arg0.market_params, &mut arg0.market_state, arg1, arg2, &v0, book_price<T0>(arg0));
    }

    entry fun upgrade_version<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg2: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PACKAGE, T1>) {
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_admin_or_authorized_assistant_authority_cap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::PACKAGE, T1>(arg1, arg2);
        assert!(arg0.version < 3, 2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_upgraded_version(0x2::object::uid_to_inner(&arg0.id), 3);
        arg0.version = 3;
    }

    fun valid_liquidation_alpha(arg0: u256) : bool {
        !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::less_than(arg0, 0) && !0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::greater_than(arg0, 1000000000000000000)
    }

    public fun version<T0>(arg0: &ClearingHouse<T0>) : u64 {
        arg0.version
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::TREASURY>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_package_version<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_authority_cap_is_authorized<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::TREASURY>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T1, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::TREASURY>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(&arg0.market_params);
        let v1 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::fees_accrued(&arg0.market_state), v0);
        if (v1 == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::sub_fees_accrued(&mut arg0.market_state, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v1, v0));
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        let v3 = borrow_mut_market_vault<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_withdrew_fees(0x2::tx_context::sender(arg3), v2, v1, 0x2::balance::value<T0>(&v3.collateral_balance));
        0x2::coin::take<T0>(&mut v3.collateral_balance, v1, arg3)
    }

    public(friend) fun withdraw_free_collateral_to_account_balance<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: u256, arg4: u256, arg5: u256, arg6: u64, arg7: 0x1::option::Option<u64>) : u64 {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let (v1, v2) = market_objects<T0>(arg0);
        let v3 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(v1);
        let v4 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::calculate_mark_price(v2, v1, arg4, arg5, arg2);
        let v5 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::margin_ratio_initial(v1);
        let (v6, v7) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::cum_funding_rates(v2);
        let v8 = borrow_mut_position<T0>(arg0, arg6);
        let v9 = 0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::effective_initial_margin_ratio(v8, v5);
        settle_position_funding_and_emit(v8, arg3, v6, v7, &v0, arg6);
        let v10 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::compute_free_collateral(v8, arg3, v4, v9, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_haircut(v1)), v3);
        let v11 = if (0x1::option::is_some<u64>(&arg7)) {
            let v12 = 0x1::option::destroy_some<u64>(arg7);
            assert!(v12 != 0, 0);
            assert!(v10 >= v12, 40);
            v12
        } else {
            if (v10 == 0) {
                return 0
            };
            v10
        };
        0x9196fffe0341b2f0ca7424926b22d9e9e35b4807a1f625fc20eeea1382d08dec::position::sub_from_collateral(v8, 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(v11, v3));
        if (v11 != 0) {
            let v13 = borrow_mut_market_vault<T0>(arg0);
            withdraw_vault_collateral<T0>(v13, arg1, v11);
        };
        v11
    }

    public fun withdraw_insurance_fund<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::TREASURY>, arg2: &0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::Registry, arg3: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_package_version<T0>(arg0);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_package_version(arg2);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_authority_cap_is_authorized<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::VENDOR<T1>, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::TREASURY>(arg2, arg1);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::assert_vendor_has_ownership_over_clearing_house<T1, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::authority::TREASURY>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        if (arg6 == 0) {
            return 0x2::coin::zero<T0>(arg7)
        };
        let v0 = &arg0.market_params;
        let v1 = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::scaling_factor(v0);
        let (v2, v3) = if (0x2::dynamic_field::exists<0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::SettlementPricesKey>(&arg0.id, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::keys::settlement_prices())) {
            let v4 = settlement_prices<T0>(arg0);
            (v4.base_price, v4.collateral_price)
        } else {
            let (v5, v6) = 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::base_oracle_price_and_twap_price(v0, arg3, arg5);
            0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::assert_index_twap_divergence_within_limit(v0, v5, v6);
            (v5, 0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::collateral_oracle_price(v0, arg4, arg5))
        };
        let v7 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::abs(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::market::open_interest(&arg0.market_state)), v2);
        let v8 = borrow_mut_market_vault<T0>(arg0);
        let v9 = 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::sub(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::from_balance(0x2::balance::value<T0>(&v8.insurance_fund_balance), v1), v3), 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::mul(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::insurance_open_interest_fraction(0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::registry::config(arg2)), v7));
        assert!(!0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::is_neg(v9), 0);
        assert!(arg6 <= 0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::to_balance(0x4b4703a7581781d74a4c7b0fb0836b2a67f34f1a377fb81aab6f5cad29d78760::ifixed::div(v9, v3), v1), 29);
        0x9bdc38b1a884f79542bd598425c40f0769e53b1664cc4e02a49d6a1c38e1ed2c::events::emit_withdrew_insurance_fund(0x2::tx_context::sender(arg7), 0x2::object::uid_to_inner(&arg0.id), arg6, 0x2::balance::value<T0>(&v8.insurance_fund_balance));
        0x2::coin::take<T0>(&mut v8.insurance_fund_balance, arg6, arg7)
    }

    fun withdraw_vault_collateral<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        assert!(0x2::balance::value<T0>(&arg0.collateral_balance) >= arg2, 23);
        0x2::balance::join<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.collateral_balance, arg2));
    }

    // decompiled from Move bytecode v7
}

