module 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::clearing_house {
    struct ClearingHouse<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: u8,
        market_params: 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketParams,
        market_state: 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketState,
        orderbook: 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Orderbook,
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
        base_price: 0x1::option::Option<u256>,
        collateral_price: 0x1::option::Option<u256>,
        enabled: bool,
    }

    struct Executor has drop {
        sender: address,
        domain: 0x1::option::Option<address>,
    }

    struct FeeMultiplier has copy, drop, store {
        taker: u256,
        maker: u256,
        expires_ms: u64,
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
        maker_events: vector<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::FilledMakerOrder>,
        integrator_info: 0x1::option::Option<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>,
        liqee_account_id: 0x1::option::Option<u64>,
        liquidator_fees: u256,
        session_summary: SessionSummary,
    }

    struct LiquidationOutcome has copy, drop {
        margin: u256,
        min_margin: u256,
        is_long: bool,
        base_liquidated: u256,
        quote_liquidated: u256,
        pnl: u256,
        liquidation_fees: u256,
        insurance_fund_fees: u256,
        bad_debt: u256,
        open_interest_delta: u256,
    }

    struct MakerFill has copy, drop {
        account_id: u64,
        quote: u256,
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
        maker_fills: vector<MakerFill>,
    }

    fun add(arg0: &mut LiquidationOutcome, arg1: &LiquidationOutcome) {
        arg0.margin = arg1.margin;
        arg0.min_margin = arg1.min_margin;
        arg0.base_liquidated = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.base_liquidated, arg1.base_liquidated);
        arg0.quote_liquidated = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.quote_liquidated, arg1.quote_liquidated);
        arg0.pnl = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.pnl, arg1.pnl);
        arg0.liquidation_fees = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.liquidation_fees, arg1.liquidation_fees);
        arg0.insurance_fund_fees = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.insurance_fund_fees, arg1.insurance_fund_fees);
        arg0.bad_debt = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.bad_debt, arg1.bad_debt);
        arg0.open_interest_delta = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.open_interest_delta, arg1.open_interest_delta);
    }

    public fun account_id<T0>(arg0: &SessionHotPotato<T0>) : u64 {
        arg0.account_id
    }

    public fun clearing_house<T0>(arg0: &SessionHotPotato<T0>) : &ClearingHouse<T0> {
        &arg0.clearing_house
    }

    public fun add_extension_field_as_extension<T0, T1: drop, T2: copy + drop + store, T3: store>(arg0: &mut ClearingHouse<T0>, arg1: &T1, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: T2, arg4: T3) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_extension_authorized<T1>(arg2);
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::ExtensionFieldKey<T1, T2>, T3>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::extension_field<T1, T2>(arg3), arg4);
    }

    fun add_position<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position) {
        assert!(!0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::PositionKey>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::position(arg1)), 41);
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::PositionKey, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::position(arg1), arg2);
    }

    public fun position<T0>(arg0: &ClearingHouse<T0>, arg1: u64) : &0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position {
        0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::PositionKey, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::position(arg1))
    }

    public fun admin_pause_market<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PAUSE_GUARDIAN>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u8) {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PAUSE_GUARDIAN>(arg2, arg1);
        assert_market_is_not_closed<T0>(arg0);
        assert_valid_pause_mode(arg3);
        arg0.paused = arg3;
    }

    public fun admin_resume_market<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry) {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        assert_market_is_not_closed<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T1>(arg2, arg1);
        arg0.paused = 0;
    }

    public fun allocate_collateral<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: u64) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert!(arg3 != 0, 0);
        let v0 = borrow_mut_market_vault<T0>(arg0);
        0x2::balance::join<T0>(&mut v0.collateral_balance, 0x2::balance::split<T0>(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::borrow_mut_collateral<T0>(arg2), arg3));
        let v1 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(&arg0.market_params);
        let v2 = borrow_mut_position<T0>(arg0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg2));
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_collateral(v2, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(arg3, v1));
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::allocated_collateral(0x2::object::uid_to_inner(&arg0.id), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg2), arg3);
    }

    fun assert_market_allows_order_cancellation<T0>(arg0: &ClearingHouse<T0>) {
        assert!(arg0.paused != 1, 32);
    }

    fun assert_market_is_closed<T0>(arg0: &ClearingHouse<T0>) {
        assert!(0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::SettlementPricesKey>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::settlement_prices()), 34);
    }

    public(friend) fun assert_market_is_not_closed<T0>(arg0: &ClearingHouse<T0>) {
        assert!(!0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::SettlementPricesKey>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::settlement_prices()), 35);
    }

    public fun assert_market_is_not_paused<T0>(arg0: &ClearingHouse<T0>) {
        assert!(arg0.paused == 0, 32);
    }

    fun assert_market_is_paused<T0>(arg0: &ClearingHouse<T0>) {
        assert!(is_market_paused<T0>(arg0), 33);
    }

    fun assert_order_value(arg0: u64, arg1: u256, arg2: u256) {
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(arg0, 1000000000), arg1) >= arg2, 3);
    }

    public fun assert_package_version<T0>(arg0: &ClearingHouse<T0>) {
        assert!(arg0.version <= 1, 10);
    }

    fun assert_reduce_only<T0>(arg0: &SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: bool) : u64 {
        if (arg3) {
            let v1 = if (arg0.session_summary.base_liquidated == 0) {
                0
            } else if (arg0.session_summary.is_liqee_long) {
                arg0.session_summary.base_liquidated
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(arg0.session_summary.base_liquidated)
            };
            let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.position_base_before, v1), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg0.session_summary.base_filled_bid, arg0.session_summary.base_filled_ask));
            assert!(v2 != 0 && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v2) != arg1, 9);
            let v3 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v2);
            if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v3, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(arg2, 1000000000))) {
                arg2
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(v3, 1000000000)
            }
        } else {
            arg2
        }
    }

    fun assert_settlement_prices(arg0: u256, arg1: u256) {
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(arg0, 0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(arg1, 0), 49);
    }

    fun assert_valid_pause_mode(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 53);
    }

    public fun base_filled_ask(arg0: &SessionSummary) : u256 {
        arg0.base_filled_ask
    }

    public fun base_filled_bid(arg0: &SessionSummary) : u256 {
        arg0.base_filled_bid
    }

    public fun best_price<T0>(arg0: &ClearingHouse<T0>, arg1: bool) : 0x1::option::Option<u256> {
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::best_price(orderbook<T0>(arg0), arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<u256>()
        };
        0x1::option::some<u256>(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(0x1::option::destroy_some<u64>(v0), 1000000000))
    }

    public fun best_price_u64<T0>(arg0: &ClearingHouse<T0>, arg1: bool) : 0x1::option::Option<u64> {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::best_price(orderbook<T0>(arg0), arg1)
    }

    public fun book_price<T0>(arg0: &ClearingHouse<T0>) : 0x1::option::Option<u256> {
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price(orderbook<T0>(arg0));
        if (0x1::option::is_none<u64>(&v0)) {
            return 0x1::option::none<u256>()
        };
        0x1::option::some<u256>(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(0x1::option::destroy_some<u64>(v0), 1000000000))
    }

    public fun borrow_extension_field<T0, T1: drop, T2: copy + drop + store, T3: store>(arg0: &ClearingHouse<T0>, arg1: T2) : &T3 {
        0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::ExtensionFieldKey<T1, T2>, T3>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::extension_field<T1, T2>(arg1))
    }

    public fun borrow_mut_extension_field_as_extension<T0, T1: drop, T2: copy + drop + store, T3: store>(arg0: &mut ClearingHouse<T0>, arg1: &T1, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: T2) : &mut T3 {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_extension_authorized<T1>(arg2);
        0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::ExtensionFieldKey<T1, T2>, T3>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::extension_field<T1, T2>(arg3))
    }

    public(friend) fun borrow_mut_market_objects<T0>(arg0: &mut ClearingHouse<T0>) : (&0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketParams, &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketState) {
        (&arg0.market_params, &mut arg0.market_state)
    }

    public(friend) fun borrow_mut_market_params<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketParams {
        &mut arg0.market_params
    }

    public(friend) fun borrow_mut_market_state<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketState {
        &mut arg0.market_state
    }

    public(friend) fun borrow_mut_market_vault<T0>(arg0: &mut ClearingHouse<T0>) : &mut Vault<T0> {
        0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarketVaultKey, Vault<T0>>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::market_vault())
    }

    public(friend) fun borrow_mut_orderbook<T0>(arg0: &mut ClearingHouse<T0>) : &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Orderbook {
        &mut arg0.orderbook
    }

    public fun orderbook<T0>(arg0: &ClearingHouse<T0>) : &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Orderbook {
        &arg0.orderbook
    }

    public(friend) fun borrow_mut_position<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64) : &mut 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position {
        0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::PositionKey, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::position(arg1))
    }

    fun borrow_mut_position_from_id(arg0: &mut 0x2::object::UID, arg1: u64) : &mut 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position {
        0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::PositionKey, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position>(arg0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::position(arg1))
    }

    public(friend) fun borrow_mut_settlement_prices<T0>(arg0: &mut ClearingHouse<T0>) : &mut SettlementPrices {
        0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::SettlementPricesKey, SettlementPrices>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::settlement_prices())
    }

    public fun cancel_orders<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: vector<u128>) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(arg0);
        assert_market_allows_order_cancellation<T0>(arg0);
        cancel_orders_<T0>(arg0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg2), &arg3, 0);
    }

    fun cancel_orders_<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: &vector<u128>, arg3: u8) {
        assert!(!0x1::vector::is_empty<u128>(arg2), 6);
        let v0 = try_cancel_orders_<T0>(arg0, arg1, arg2, 0x1::option::none<u64>(), 0, arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<bool>(&v0)) {
            assert!(*0x1::vector::borrow<bool>(&v0, v1), 58);
            v1 = v1 + 1;
        };
    }

    public fun clip_size_to_liquidate(arg0: u256, arg1: u256, arg2: u64) : u128 {
        if (arg2 != 1) {
            0x1::u128::min(0x1::u128::div_ceil(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_u128balance(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg0), 1000000000) + 1, (arg2 as u128)) * (arg2 as u128), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_u128balance(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg1), 1000000000))
        } else {
            0x1::u128::min(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_u128balance(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg0), 1000000000) + 1, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_u128balance(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg1), 1000000000))
        }
    }

    public fun close_market<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &0x2::clock::Clock) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        assert_market_is_not_closed<T2>(arg0);
        arg0.paused = 1;
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::try_update_fundings(&arg0.market_params, &mut arg0.market_state, 0x2::clock::timestamp_ms(arg3), &v0);
        let v1 = SettlementPrices{
            base_price       : 0x1::option::none<u256>(),
            collateral_price : 0x1::option::none<u256>(),
            enabled          : false,
        };
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::SettlementPricesKey, SettlementPrices>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::settlement_prices(), v1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::closed_market(0x2::object::uid_to_inner(&arg0.id));
    }

    public fun close_position_at_settlement_prices<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg2: &vector<u128>) {
        assert_package_version<T0>(arg0);
        assert_market_is_paused<T0>(arg0);
        assert_market_is_closed<T0>(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg1);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = settlement_prices<T0>(arg0);
        assert!(v2.enabled, 36);
        let v3 = *0x1::option::borrow<u256>(&v2.base_price);
        let v4 = *0x1::option::borrow<u256>(&v2.collateral_price);
        if (!0x1::vector::is_empty<u128>(arg2)) {
            cancel_orders_<T0>(arg0, v0, arg2, 3);
        };
        let (v5, v6) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(&arg0.market_state);
        let v7 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(&arg0.market_params);
        let v8 = borrow_mut_position<T0>(arg0, v0);
        let (v9, v10) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::pending_base_amounts_by_side(v8);
        let v11 = if (v9 == 0) {
            if (v10 == 0) {
                0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::pending_order_count(v8) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v11, 48);
        settle_position_funding_and_emit(v8, v4, v5, v6, &v1, v0);
        let (v12, v13) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v8);
        let v14 = 0;
        let v15 = 0;
        if (v12 != 0) {
            let v16 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v12);
            let (v17, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_base_to_position(v8, !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v12), v16, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v16, v3));
            v15 = v17;
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_collateral_usd(v8, v17, v4);
        };
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::collateral(v8))) {
            v14 = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::reset_collateral(v8);
        };
        let v19 = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::collateral(v8);
        let v20 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(v19, v7);
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_collateral(v8, v19);
        if (v14 != 0) {
            let v21 = borrow_mut_market_vault<T0>(arg0);
            assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(0x2::balance::value<T0>(&v21.insurance_fund_balance), v7), v14), 31);
            transfer_from_insurance_fund_to_vault<T0>(v21, v14, v7);
        };
        let v22 = borrow_mut_market_vault<T0>(arg0);
        assert!(0x2::balance::value<T0>(&v22.collateral_balance) >= v20, 23);
        0x2::balance::join<T0>(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::borrow_mut_collateral<T0>(arg1), 0x2::balance::split<T0>(&mut v22.collateral_balance, v20));
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::add_to_open_interest(&mut arg0.market_state, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v12, 0)));
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::closed_position_at_settlement_prices(v1, v0, v15, v12, v13, v20, v14);
    }

    public(friend) fun closed_market_adl_prices<T0>(arg0: &ClearingHouse<T0>) : (u256, u256) {
        assert_market_is_closed<T0>(arg0);
        let v0 = settlement_prices<T0>(arg0);
        assert!(0x1::option::is_some<u256>(&v0.base_price) && 0x1::option::is_some<u256>(&v0.collateral_price), 7);
        (*0x1::option::borrow<u256>(&v0.base_price), *0x1::option::borrow<u256>(&v0.collateral_price))
    }

    public fun collateral_and_insurance_fund_balances<T0>(arg0: &ClearingHouse<T0>) : (u64, u64) {
        let v0 = market_vault<T0>(arg0);
        (0x2::balance::value<T0>(&v0.collateral_balance), 0x2::balance::value<T0>(&v0.insurance_fund_balance))
    }

    fun collateral_for_margin_increase(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        if (arg2 == 0) {
            return 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div_up(arg3, arg1)
        };
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg0, arg1);
        let v1 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v0)) {
            let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(v0);
            if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg3, v2)) {
                arg3
            } else {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v2, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div_up(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg3, v2), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(1000000000000000000, arg2)))
            }
        } else {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div_up(arg3, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(1000000000000000000, arg2))
        };
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div_up(v1, arg1)
    }

    fun collateral_symbol<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())))
    }

    public fun collateral_to_deallocate_for_margin_ratio<T0>(arg0: &ClearingHouse<T0>, arg1: u64, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u256>) : u64 {
        let v0 = market_params<T0>(arg0);
        let v1 = market_state<T0>(arg0);
        let (v2, v3) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(v1);
        let (v4, v5) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_oracle_price_and_twap_price(v0, arg2, arg4);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::assert_index_twap_divergence_within_limit(v0, v4, v5);
        let v6 = position<T0>(arg0, arg1);
        let v7 = if (0x1::option::is_some<u256>(&arg5)) {
            0x1::option::destroy_some<u256>(arg5)
        } else {
            0x1::option::destroy_none<u256>(arg5);
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::initial_margin_ratio(v6)
        };
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v7, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_initial(v0)), 42);
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::compute_free_collateral_with_fundings(v6, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_oracle_price(v0, arg3, arg4), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::calculate_mark_price(v1, v0, v5, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price_or_index(orderbook<T0>(arg0), v4), 0x2::clock::timestamp_ms(arg4)), v7, v2, v3, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_haircut(v0)), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(v0))
    }

    public fun commit_margin_ratios_proposal<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x2::clock::Clock) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::margin_ratio_proposal();
        assert!(0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarginRatioProposalKey>(&arg0.id, v0), 28);
        let MarginRatioProposal {
            maturity                 : v1,
            margin_ratio_initial     : v2,
            margin_ratio_maintenance : v3,
        } = 0x2::dynamic_field::remove<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarginRatioProposalKey, MarginRatioProposal>(&mut arg0.id, v0);
        assert!(v1 <= 0x2::clock::timestamp_ms(arg1), 26);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::update_margin_ratios(&mut arg0.market_params, v2, v3);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::updated_margin_ratios(0x2::object::uid_to_inner(&arg0.id), v2, v3);
    }

    public fun compute_liquidation_size_and_mode(arg0: &0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : (u256, bool) {
        let (v0, v1) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(arg0);
        let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v0);
        let (v3, v4) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::compute_margin_and_requirement(arg0, arg1, arg2, arg3, arg6);
        if (arg6 == 0) {
            return compute_liquidation_size_no_haircut(v0, v1, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::collateral(arg0), v2, arg1, arg2, arg4, arg5, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v2, arg2), arg3), v3, v4)
        };
        compute_liquidation_size_with_haircut(v0, v1, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::collateral(arg0), v2, arg1, arg2, arg4, arg5, arg6, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v2, arg2), arg3), v3, v4)
    }

    fun compute_liquidation_size_no_haircut(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256) : (u256, bool) {
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(arg9, arg10)) {
            return (0, true)
        };
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg9, 0)) {
            return (arg3, false)
        };
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg5, arg0), arg1);
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg4, arg2);
        let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg5, arg3);
        let v3 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg8, liquidation_collateral_rounding_cushion(arg4)), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v0, v1));
        let (v4, v5) = waived_fee_liquidation_alpha(v3, arg8, v1, v0, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg6, v2));
        if (v4) {
            return (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v5, arg3), false)
        };
        let v6 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div_up(v3, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg8, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg6, arg7), v2)));
        if (!valid_liquidation_alpha(v6)) {
            return (arg3, false)
        };
        (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v6, arg3), false)
    }

    fun compute_liquidation_size_with_haircut(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256) : (u256, bool) {
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(1000000000000000000, arg8);
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg5, arg0), arg1);
        let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg6, arg7), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg5, arg3));
        let v3 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg4, arg2);
        let v4 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v3, v1);
        let v5 = liquidation_collateral_rounding_cushion(arg4);
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(arg10, arg11)) {
            return (0, true)
        };
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v4, 0)) {
            return (arg3, false)
        };
        let v6 = 0;
        let v7 = false;
        let (v8, v9) = waived_fee_liquidation_alpha(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg9, v5), v4), arg9, v3, v1, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg6, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg5, arg3)));
        if (v8) {
            v6 = v9;
            v7 = true;
        };
        let v10 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg9, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg8, v1)), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v2, v0));
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v10, 0)) {
            let v11 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div_up(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg9, v5), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v1, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v3, v0))), v10);
            let v12 = if (valid_liquidation_alpha(v11)) {
                if (!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v3, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v11, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v1, v2))))) {
                    !v7 || 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(v11, v6)
                } else {
                    false
                }
            } else {
                false
            };
            if (v12) {
                v6 = v11;
                v7 = true;
            };
        };
        if (!v7) {
            return (arg3, false)
        };
        (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v6, arg3), false)
    }

    public fun create_clearing_house<T0, T1, T2>(arg0: 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Orderbook, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, T2>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::clock::Clock, arg5: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg6: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg7: u16, arg8: u16, arg9: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketCreationParams, arg10: &mut 0x2::tx_context::TxContext) : ClearingHouse<T0> {
        create_clearing_house_<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, (0x2::coin::get_decimals<T0>(arg3) as u64), arg9, arg10)
    }

    fun create_clearing_house_<T0, T1, T2>(arg0: 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Orderbook, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, T2>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &0x2::clock::Clock, arg4: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg5: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg6: u16, arg7: u16, arg8: u64, arg9: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketCreationParams, arg10: &mut 0x2::tx_context::TxContext) : ClearingHouse<T0> {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, T2>(arg2, arg1);
        assert!(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::contains(arg4, arg6), 17);
        assert!(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::contains(arg5, arg7), 17);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg4);
        let v1 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg5);
        let v2 = Vault<T0>{
            collateral_balance     : 0x2::balance::zero<T0>(),
            insurance_fund_balance : 0x2::balance::zero<T0>(),
        };
        let (v3, v4) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::create_market_objects(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::config(arg2), arg3, v0, v1, arg6, arg7, arg9, (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::decimal_scalar_from_decimals(arg8) as u256));
        let v5 = v3;
        let v6 = ClearingHouse<T0>{
            id            : 0x2::object::new(arg10),
            version       : 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::version(arg2),
            paused        : 0,
            market_params : v5,
            market_state  : v4,
            orderbook     : arg0,
        };
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarketVaultKey, Vault<T0>>(&mut v6.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::market_vault(), v2);
        let v7 = 0x2::object::uid_to_inner(&v6.id);
        let (v8, v9) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::maker_taker_fees(&v5);
        let (v10, v11) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::liquidation_fee_rates(&v5);
        let (v12, v13) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::funding_params(&v5);
        let (v14, v15) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::premium_twap_params(&v5);
        let (v16, v17) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::spread_twap_params(&v5);
        let (v18, v19) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::max_bad_debt_thresholds(&v5);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::created_clearing_house(v7, collateral_symbol<T0>(), arg8, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_initial(&v5), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_maintenance(&v5), v0, arg6, v1, arg7, v12, v13, v14, v15, v16, v17, v8, v9, v10, v11, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::lot_size(&v5), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::tick_size(&v5), v18, v19, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::priority_taker_fee(&v5));
        0x1::vector::push_back<0x2::object::ID>(0x2::dynamic_field::borrow_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::VendorClearingHouseKey<T1>, vector<0x2::object::ID>>(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::borrow_mut_id(arg2), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::vendor_clearing_house_key<T1>()), v7);
        v6
    }

    public fun create_clearing_house_with_currency<T0, T1, T2>(arg0: 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Orderbook, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, T2>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &0x2::coin_registry::Currency<T0>, arg4: &0x2::clock::Clock, arg5: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg6: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg7: u16, arg8: u16, arg9: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketCreationParams, arg10: &mut 0x2::tx_context::TxContext) : ClearingHouse<T0> {
        create_clearing_house_<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, (0x2::coin_registry::decimals<T0>(arg3) as u64), arg9, arg10)
    }

    public fun create_margin_ratios_proposal<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u64, arg4: u256, arg5: u256, arg6: &0x2::clock::Clock) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        assert!(!0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarginRatioProposalKey>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::margin_ratio_proposal()), 25);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::config(arg2);
        assert!(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::min_proposal_delay_ms(v0) <= arg3 && arg3 <= 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::max_proposal_delay_ms(v0), 27);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::assert_margin_ratios(arg4, arg5);
        let (v1, v2) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::liquidation_fee_rates(&arg0.market_params);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::assert_liquidation_fees_against_mmr(arg5, v1, v2);
        let v3 = MarginRatioProposal{
            maturity                 : 0x2::clock::timestamp_ms(arg6) + arg3,
            margin_ratio_initial     : arg4,
            margin_ratio_maintenance : arg5,
        };
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarginRatioProposalKey, MarginRatioProposal>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::margin_ratio_proposal(), v3);
    }

    public fun create_market_position<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let (v0, v1) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(&arg0.market_state);
        let v2 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg2);
        add_position<T0>(arg0, v2, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::create_position(v0, v1));
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::created_position(0x2::object::uid_to_inner(&arg0.id), v2, v0, v1);
    }

    public fun create_orderbook<T0, T1>(arg0: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg1: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Orderbook {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg1, arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::create_orderbook(arg2, arg3, arg4, arg5, arg6, arg7, arg8)
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
            maker_fills      : 0x1::vector::empty<MakerFill>(),
        }
    }

    public fun deallocate_collateral<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        deallocate_collateral_<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<u64>(arg5), arg6)
    }

    fun deallocate_collateral_<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock) : u64 {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        deallocate_collateral_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun deallocate_collateral_as_extension<T0, T1: drop>(arg0: &mut ClearingHouse<T0>, arg1: &T1, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg4: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg5: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock) : u64 {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_extension_authorized<T1>(arg2);
        deallocate_collateral_internal<T0>(arg0, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun deallocate_collateral_internal<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg1);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        let v3 = market_params<T0>(arg0);
        let v4 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_oracle_price(v3, arg3, arg5);
        let (v5, v6) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_oracle_price_and_twap_price(v3, arg2, arg5);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::assert_index_twap_divergence_within_limit(v3, v5, v6);
        let v7 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price_or_index(orderbook<T0>(arg0), v5);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::try_update_fundings_and_twaps(&arg0.market_params, &mut arg0.market_state, v2, v5, v7, &v1);
        let v8 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::borrow_mut_collateral<T0>(arg1);
        let v9 = withdraw_free_collateral_to_account_balance<T0>(arg0, v8, v2, v4, v6, v7, v0, arg4);
        if (v9 != 0) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::deallocated_collateral(v1, v0, v9);
        };
        v9
    }

    public fun deallocate_free_collateral<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock) : u64 {
        deallocate_collateral_<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<u64>(), arg5)
    }

    public fun delete_margin_ratios_proposal<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::margin_ratio_proposal();
        assert!(0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarginRatioProposalKey>(&arg0.id, v0), 28);
        let MarginRatioProposal {
            maturity                 : _,
            margin_ratio_initial     : _,
            margin_ratio_maintenance : _,
        } = 0x2::dynamic_field::remove<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarginRatioProposalKey, MarginRatioProposal>(&mut arg0.id, v0);
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
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::donated_to_insurance_fund(0x2::tx_context::sender(arg2), 0x2::object::uid_to_inner(&arg0.id), v0, 0x2::balance::join<T0>(&mut v1.insurance_fund_balance, 0x2::coin::into_balance<T0>(arg1)));
    }

    public fun enable_settlement<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        assert_market_is_closed<T2>(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = borrow_mut_settlement_prices<T2>(arg0);
        assert!(0x1::option::is_some<u256>(&v1.base_price) && 0x1::option::is_some<u256>(&v1.collateral_price), 7);
        v1.enabled = true;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::updated_settlement_prices(v0, *0x1::option::borrow<u256>(&v1.base_price), *0x1::option::borrow<u256>(&v1.collateral_price), true);
    }

    public fun end_session<T0, T1>(arg0: SessionHotPotato<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: bool, arg4: bool) : (ClearingHouse<T0>, SessionSummary) {
        assert_package_version<T0>(&arg0.clearing_house);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        end_session_<T0>(arg0, arg2, arg3, arg4, false)
    }

    public(friend) fun end_session_<T0>(arg0: SessionHotPotato<T0>, arg1: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg2: bool, arg3: bool, arg4: bool) : (ClearingHouse<T0>, SessionSummary) {
        assert!(account_id<T0>(&arg0) == 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg1), 18);
        let SessionHotPotato {
            clearing_house          : v0,
            account_id              : v1,
            timestamp_ms            : v2,
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
        let (v24, _) = fee_multipliers(&v22.id, v1, v2);
        let v26 = !0x1::vector::is_empty<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::FilledMakerOrder>(&v20);
        let v27 = 0x1::option::is_some<u64>(&v18);
        assert!(arg4 || session_has_activity(&v17, &v20, &v18), 11);
        let v28 = if (v26) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price(&v22.orderbook)
        } else {
            0x1::option::none<u64>()
        };
        let (v29, v30) = market_objects<T0>(&v22);
        let v31 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_haircut(v29);
        let v32 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul_toward_zero(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::taker_fee(v29), v24);
        let v33 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(v29);
        let (v34, v35) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::max_open_interest_position_params(v29);
        let v36 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::open_interest(v30);
        let v37 = v17.bad_debt != 0;
        let (v38, v39) = if (v37) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(v30)
        } else {
            (0, 0)
        };
        let v40 = &mut v22;
        let v41 = borrow_mut_position<T0>(v40, v1);
        let v42 = v8;
        if (v27) {
            let (v43, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v41);
            if (v37) {
                settle_position_funding_and_emit(v41, v3, v38, v39, &v23, v1);
            };
            let v45 = if (v17.base_liquidated != 0) {
                let (v46, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_base_to_position(v41, !v17.is_liqee_long, v17.base_liquidated, v17.quote_liquidated);
                v46
            } else {
                0
            };
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_collateral_usd(v41, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v45, v15), v3);
            let (v48, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v41);
            v42 = v48;
            v21 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v9, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v48, 0), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v43, 0)));
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::performed_liquidation(v23, 0x1::option::destroy_some<u64>(v18), v1, v17.is_liqee_long, v17.base_liquidated, v17.quote_liquidated, v45, v15, v4);
        };
        if (v26) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::filled_maker_orders(v20, v28);
        };
        let (v50, v51, v52) = if (v17.base_filled_ask != 0 || v17.base_filled_bid != 0) {
            let v53 = v32;
            if (v5) {
                let v54 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::resolve_priority_taker_fee(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::priority_taker_fee(v29));
                if (v54 != 0) {
                    v53 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v32, v54);
                };
            };
            let (v55, v56) = if (0x1::option::is_some<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>(&v19)) {
                let v57 = 0x1::option::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>(&v19);
                (0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::integrator_fee(v57), 0x1::option::some<u32>(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::integrator_id(v57)))
            } else {
                (0, 0x1::option::none<u32>())
            };
            let (v58, v59, v60, v61) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::apply_taker_fills_and_settle(v41, v3, v17.base_filled_ask, v17.quote_filled_ask, v17.base_filled_bid, v17.quote_filled_bid, v53, v55);
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::filled_taker_order(v23, v1, v58, v59, v56, v60, v17.base_filled_ask, v17.quote_filled_ask, v17.base_filled_bid, v17.quote_filled_bid, v4);
            (v61, v59, v60)
        } else {
            (0, 0, 0)
        };
        process_post(v41, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::max_pending_orders(v29), &v17);
        let (v62, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v41);
        let (v64, v65, v66) = if (arg3) {
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::compute_margin_and_free_collateral(v41, v3, v4, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::effective_initial_margin_ratio(v41, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_initial(v29)), v31)
        } else {
            let (v67, v68) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::compute_margin_and_requirement(v41, v3, v4, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::effective_initial_margin_ratio(v41, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_initial(v29)), v31);
            (v67, v68, 0)
        };
        let (v69, v70) = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v65, v64)) {
            if (arg2) {
                assert!(!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v6), 39);
                let v71 = (((collateral_for_margin_increase(0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::collateral(v41), v3, v31, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v65, v64)) + v33 - 1) / v33) as u64);
                0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_collateral(v41, (v71 as u256) * v33);
                (v71, true)
            } else {
                assert!(!v27, 52);
                assert!(!v11, 54);
                assert!(v17.posted_orders == 0 || 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v64, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::margin_requirement(v41, v4, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_maintenance(v29))), 57);
                0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::ensure_margin_requirements(v6, v7, v64, v65, v8, v62);
                (0, false)
            }
        } else if (arg3) {
            if (v66 != 0) {
                0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_collateral(v41, v66);
            };
            (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(v66, v33), false)
        } else {
            (0, false)
        };
        if (v69 != 0) {
            if (v70) {
                let v72 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::borrow_mut_collateral<T0>(arg1);
                assert!(v69 <= 0x2::balance::value<T0>(v72), 30);
                let v73 = &mut v22;
                0x2::balance::join<T0>(&mut borrow_mut_market_vault<T0>(v73).collateral_balance, 0x2::balance::split<T0>(v72, v69));
                0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::allocated_collateral(v23, v1, v69);
            } else {
                let v74 = &mut v22;
                let v75 = borrow_mut_market_vault<T0>(v74);
                let v76 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::borrow_mut_collateral<T0>(arg1);
                withdraw_vault_collateral<T0>(v75, v76, v69);
                0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::deallocated_collateral(v23, v1, v69);
            };
        };
        if (0x1::option::is_some<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>(&v19)) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::validate_session_integrator_info<T0>(arg1, 0x1::option::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>(&v19));
        };
        let v77 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v10, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v51, v52));
        let v78 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v21, v50);
        assert!(!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v77), 13);
        let v79 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v36, v78);
        if (v77 != 0 || v78 != 0) {
            let v80 = &mut v22;
            let v81 = borrow_mut_market_state<T0>(v80);
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::add_fees_accrued_usd(v81, v77, v3);
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::add_to_open_interest(v81, v78);
            assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v79, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::max_open_interest(v29)) || 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v79, v36), 15);
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::updated_open_interest_and_fees_accrued(v23, v79, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::fees_accrued(v81));
        };
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v79, v34) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v62), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v42))) {
            assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v62), v79), v35), 16);
        };
        (v22, v17)
    }

    public fun end_session_as_extension<T0, T1: drop>(arg0: SessionHotPotato<T0>, arg1: &T1, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg4: bool, arg5: bool, arg6: bool) : (ClearingHouse<T0>, SessionSummary) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_extension_authorized<T1>(arg2);
        end_session_<T0>(arg0, arg3, arg4, arg5, arg6)
    }

    fun execute_limit_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: bool, arg7: 0x1::option::Option<u64>) : (u64, 0x1::option::Option<u128>) {
        assert!(arg4 < 4, 44);
        assert!(0x1::option::get_with_default<u64>(&arg7, 18446744073709551615) > arg0.timestamp_ms, 14);
        let v0 = if (arg1) {
            ((arg3 ^ 18446744073709551615) as u128)
        } else {
            (arg3 as u128)
        };
        let (v1, v2) = match_taker<T0>(arg0, arg1, arg2, 0x1::option::some<u128>(v0));
        let v3 = v1;
        if (arg4 == 1) {
            assert!(v1 == 0, 46);
        };
        if (arg4 == 2) {
            assert!(v1 == arg2, 47);
        };
        if (arg4 == 3 || v2) {
            v3 = 0;
        };
        if (v3 == 0) {
            return (0, 0x1::option::none<u128>())
        };
        let v4 = arg0.account_id;
        let (v5, v6) = if (0x1::option::is_some<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>(&arg0.integrator_info)) {
            let v7 = 0x1::option::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>(&arg0.integrator_info);
            (0x1::option::some<u32>(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::integrator_id(v7)), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::integrator_fee_b9(v7))
        } else {
            (0x1::option::none<u32>(), 0)
        };
        let v8 = &mut arg0.clearing_house.orderbook;
        let v9 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::post_order(v8, v4, arg1, v3, arg3, arg5, arg6, arg7, arg0.integrator_info);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::posted_order(0x2::object::uid_to_inner(&arg0.clearing_house.id), v4, v9, arg5, v3, arg6, arg7, v5, v6, arg0.mark_price, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price(v8));
        let v10 = &mut arg0.session_summary;
        v10.posted_orders = v10.posted_orders + 1;
        if (arg1) {
            v10.base_posted_ask = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v10.base_posted_ask, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v3, 1000000000));
        } else {
            v10.base_posted_bid = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v10.base_posted_bid, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v3, 1000000000));
        };
        (v3, 0x1::option::some<u128>(v9))
    }

    fun execute_liquidation<T0>(arg0: &mut SessionHotPotato<T0>, arg1: u64, arg2: u128, arg3: u128, arg4: u64) {
        let v0 = 0x2::object::uid_to_inner(&arg0.clearing_house.id);
        let v1 = &v0;
        settle_liquidated_position<T0>(arg0, arg1, arg2, arg3, arg4, v1);
        if (arg0.session_summary.bad_debt != 0) {
            let v2 = &mut arg0.clearing_house;
            handle_bad_debt<T0>(v2, arg0.session_summary.bad_debt, arg0.mark_price, arg0.collateral_price, arg0.session_summary.is_liqee_long, v1, 0x1::option::none<u256>());
        };
    }

    fun execute_market_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64) {
        let (v0, _) = match_taker<T0>(arg0, arg1, arg2, 0x1::option::none<u128>());
        assert!(v0 == 0, 45);
    }

    public fun execution_price(arg0: &SessionSummary, arg1: bool) : u256 {
        if (arg1 && arg0.base_filled_ask != 0) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(arg0.quote_filled_ask, arg0.base_filled_ask)
        } else if (!arg1 && arg0.base_filled_bid != 0) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(arg0.quote_filled_bid, arg0.base_filled_bid)
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
        0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::PositionKey>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::position(arg1))
    }

    public fun fee_multiplier<T0>(arg0: &ClearingHouse<T0>, arg1: u64, arg2: u64) : (u256, u256) {
        fee_multipliers(&arg0.id, arg1, arg2)
    }

    fun fee_multipliers(arg0: &0x2::object::UID, arg1: u64, arg2: u64) : (u256, u256) {
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::fee_multiplier(arg1);
        if (!0x2::dynamic_field::exists_with_type<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FeeMultiplierKey, FeeMultiplier>(arg0, v0)) {
            return (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::one(), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::one())
        };
        let v1 = 0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FeeMultiplierKey, FeeMultiplier>(arg0, v0);
        if (arg2 >= v1.expires_ms) {
            return (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::one(), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::one())
        };
        (v1.taker, v1.maker)
    }

    public fun fill_base_and_quote_deltas(arg0: u64, arg1: u64) : (u256, u256) {
        (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(arg1, 1000000000), (arg1 as u256) * (arg0 as u256))
    }

    public fun filled_base_and_quote(arg0: &SessionSummary, arg1: bool) : (u256, u256) {
        if (arg1) {
            (arg0.base_filled_ask, arg0.quote_filled_ask)
        } else {
            (arg0.base_filled_bid, arg0.quote_filled_bid)
        }
    }

    public(friend) fun force_cancel_orders(arg0: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Orderbook, arg1: u64, arg2: &vector<u128>, arg3: 0x2::object::ID, arg4: u8) : (u128, u128, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v0 < 0x1::vector::length<u128>(arg2)) {
            let v4 = *0x1::vector::borrow<u128>(arg2, v0);
            let (v5, v6, v7) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::try_cancel_limit_order(arg0, arg1, v4);
            if (v5) {
                v3 = v3 + 1;
                0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::canceled_order(arg3, arg1, v4, v7, v6, arg4, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price(arg0));
                if (v4 < 170141183460469231731687303715884105728) {
                    v1 = v1 + (v6 as u128);
                } else {
                    v2 = v2 + (v6 as u128);
                };
            };
            v0 = v0 + 1;
        };
        (v1, v2, v3)
    }

    public fun freeze_clearing_house<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::FREEZE_GUARDIAN>) {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::FREEZE_GUARDIAN>(arg1, arg2);
        let v0 = arg0.version;
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FrozenVersionKey, u64>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::frozen_version(), v0);
        arg0.version = 18446744073709551615;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::froze(0x2::object::uid_to_inner(&arg0.id), v0, 0x2::object::id<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::FREEZE_GUARDIAN>>(arg2));
    }

    fun handle_bad_debt<T0>(arg0: &mut ClearingHouse<T0>, arg1: u256, arg2: u256, arg3: u256, arg4: bool, arg5: &0x2::object::ID, arg6: 0x1::option::Option<u256>) {
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(&arg0.market_params);
        let (v1, v2) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::max_bad_debt_thresholds(&arg0.market_params);
        let v3 = borrow_mut_market_vault<T0>(arg0);
        let v4 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(0x2::balance::value<T0>(&v3.insurance_fund_balance), v0);
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v4, arg1)) {
            transfer_from_insurance_fund_to_vault<T0>(v3, arg1, v0);
        } else {
            transfer_from_insurance_fund_to_vault<T0>(v3, v4, v0);
            let v5 = &mut arg0.market_state;
            try_socialize_bad_debt(v5, arg2, arg4, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg1, v4), arg3), v1, v2, arg5, arg6);
        };
    }

    public fun has_extension_field<T0, T1: drop, T2: copy + drop + store>(arg0: &ClearingHouse<T0>, arg1: T2) : bool {
        0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::ExtensionFieldKey<T1, T2>>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::extension_field<T1, T2>(arg1))
    }

    fun is_discount(arg0: u256) : bool {
        !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(arg0) && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg0, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::one())
    }

    public fun is_frozen<T0>(arg0: &ClearingHouse<T0>) : bool {
        0x2::dynamic_field::exists_with_type<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FrozenVersionKey, u64>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::frozen_version())
    }

    fun is_maker_multiplier(arg0: u256) : bool {
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(arg0), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::one())
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
        let v2 = if (0x1::vector::length<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::FilledMakerOrder>(&arg0.maker_events) == 0) {
            if (v1.posted_orders == 0) {
                0x1::option::is_none<u64>(&arg0.liqee_account_id)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 5);
        let (v3, v4, v5) = if (0x1::vector::length<u128>(arg2) != 0) {
            force_cancel_orders(v0, arg1, arg2, 0x2::object::uid_to_inner(&arg0.clearing_house.id), 1)
        } else {
            (0, 0, 0)
        };
        execute_liquidation<T0>(arg0, arg1, v3, v4, v5);
    }

    public fun liquidated_size(arg0: &SessionSummary) : u64 {
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(arg0.base_liquidated, 1000000000)
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

    public fun liquidation_mark_price_b9(arg0: &SessionSummary) : u64 {
        0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(arg0.quote_liquidated, arg0.base_liquidated), 1000000000)
    }

    public fun maker_fill_account_id(arg0: &MakerFill) : u64 {
        arg0.account_id
    }

    public fun maker_fill_quote(arg0: &MakerFill) : u256 {
        arg0.quote
    }

    public fun maker_fills(arg0: &SessionSummary) : &vector<MakerFill> {
        &arg0.maker_fills
    }

    public fun mark_price<T0>(arg0: &ClearingHouse<T0>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) : u256 {
        let (v0, v1) = market_objects<T0>(arg0);
        let (v2, v3) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_oracle_price_and_twap_price(v0, arg1, arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::assert_index_twap_divergence_within_limit(v0, v2, v3);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::calculate_mark_price(v1, v0, v3, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price_or_index(orderbook<T0>(arg0), v2), 0x2::clock::timestamp_ms(arg2))
    }

    public fun mark_price_in_session<T0>(arg0: &SessionHotPotato<T0>) : u256 {
        arg0.mark_price
    }

    public fun market_objects<T0>(arg0: &ClearingHouse<T0>) : (&0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketParams, &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketState) {
        (&arg0.market_params, &arg0.market_state)
    }

    public fun market_params<T0>(arg0: &ClearingHouse<T0>) : &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketParams {
        &arg0.market_params
    }

    public fun market_pause_mode<T0>(arg0: &ClearingHouse<T0>) : u8 {
        arg0.paused
    }

    public fun market_state<T0>(arg0: &ClearingHouse<T0>) : &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketState {
        &arg0.market_state
    }

    public fun market_vault<T0>(arg0: &ClearingHouse<T0>) : &Vault<T0> {
        0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::MarketVaultKey, Vault<T0>>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::market_vault())
    }

    fun match_taker<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: 0x1::option::Option<u128>) : (u64, bool) {
        let v0 = &arg0.clearing_house.market_params;
        let v1 = &arg0.clearing_house.market_state;
        let (v2, _) = fee_multipliers(&arg0.clearing_house.id, arg0.account_id, arg0.timestamp_ms);
        let (v4, _) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::liquidation_fee_rates(v0);
        let (v6, v7) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(v1);
        let (v8, v9) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::max_open_interest_position_params(v0);
        let v10 = !arg1;
        let v11 = &mut arg0.clearing_house.id;
        let v12 = &mut arg0.clearing_house.orderbook;
        let v13 = &mut arg0.session_summary;
        let v14 = &mut arg0.taker_pending_cancelled;
        let v15 = &mut arg0.maker_events;
        let v16 = if (arg1) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::borrow_mut_bids(v12)
        } else {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::borrow_mut_asks(v12)
        };
        let v17 = 0;
        let v18 = true;
        let v19 = false;
        let v20 = 0;
        let v21 = false;
        let v22 = 0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::first_leaf_ptr<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v16);
        while (v22 != 0) {
            let v23 = 0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::get_leaf_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v16, v22);
            v22 = 0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::next<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v23);
            let v24 = 0;
            while (v24 < 0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::size<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v23)) {
                let (v25, v26) = 0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::elem_mut<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v23, v24);
                let v27 = &arg3;
                if (0x1::option::is_some<u128>(v27) && v25 >> 64 > *0x1::option::borrow<u128>(v27)) {
                    v19 = true;
                    break
                };
                v17 = v25;
                let (v28, v29, v30, v31) = process_fill_maker(v13, v11, v25, v26, arg0.timestamp_ms, arg0.collateral_price, arg0.mark_price, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::maker_fee(v0), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul_toward_zero(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::taker_fee(v0), v2)), v4, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_haircut(v0), v6, v7, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::open_interest(v1), v8, v9, arg0.account_id, arg2, v14);
                let v32 = v30;
                let v33 = arg2 - v28;
                arg2 = v33;
                v18 = v29;
                let (v34, v35) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::maker_and_integrator_fees(&v32);
                arg0.total_fees = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.total_fees, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v34, v35));
                arg0.total_open_interest = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.total_open_interest, v31);
                0x1::vector::push_back<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::FilledMakerOrder>(v15, v32);
                if (v33 == 0) {
                    v19 = true;
                    break
                };
                if (v28 == 0) {
                    let v36 = v20 + 1;
                    v20 = v36;
                    if (v36 == 200) {
                        v21 = true;
                        v19 = true;
                        break
                    };
                };
                v24 = v24 + 1;
            };
            if (v19) {
                break
            };
        };
        if (v17 > 0) {
            0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::batch_drop<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v16, v17, v18);
            let v37 = if (0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::is_empty<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v16)) {
                0x1::option::none<u64>()
            } else {
                let v38 = if (v10) {
                    ((0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::min_key<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v16) >> 64) as u64)
                } else {
                    ((0x9d829768ca05b68bce5e71d42da1a75f1886ebb5030a8ba7ed66be1397f2d53::ordered_map::min_key<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order>(v16) >> 64) as u64) ^ 18446744073709551615
                };
                0x1::option::some<u64>(v38)
            };
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::set_best_price(v12, v10, v37);
        };
        (arg2, v21)
    }

    public fun no_domain_executor(arg0: &0x2::tx_context::TxContext) : Executor {
        Executor{
            sender : 0x2::tx_context::sender(arg0),
            domain : 0x1::option::none<address>(),
        }
    }

    public fun pause_market<T0, T1, T2>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, T2>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u8) {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        assert_market_is_not_closed<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T1, T2>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = if (v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>()) {
            true
        } else if (v0 == 0x1::type_name::with_defining_ids<0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ASSISTANT>()) {
            true
        } else {
            v0 == 0x1::type_name::with_defining_ids<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PAUSE_GUARDIAN>()
        };
        assert!(v1, 50);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, T2>(arg2, arg1);
        assert_valid_pause_mode(arg3);
        arg0.paused = arg3;
    }

    public fun place_limit_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: bool, arg7: 0x1::option::Option<u64>) : 0x1::option::Option<u128> {
        assert_package_version<T0>(&arg0.clearing_house);
        assert!(arg3 != 0 && arg3 < 9223372036854775808, 3900);
        assert!(arg3 % 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::tick_size(&arg0.clearing_house.market_params) == 0, 20);
        let v0 = assert_reduce_only<T0>(arg0, arg1, arg2, arg6);
        assert!(v0 % 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::lot_size(&arg0.clearing_house.market_params) == 0, 19);
        assert!(v0 != 0, 1);
        let (v1, v2) = execute_limit_order<T0>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg7);
        if (v1 == v0) {
            assert_order_value(v1, arg0.mark_price, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::min_order_usd_value(&arg0.clearing_house.market_params));
        };
        v2
    }

    public fun place_market_order<T0>(arg0: &mut SessionHotPotato<T0>, arg1: bool, arg2: u64, arg3: bool) {
        assert_package_version<T0>(&arg0.clearing_house);
        let v0 = assert_reduce_only<T0>(arg0, arg1, arg2, arg3);
        assert!(v0 % 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::lot_size(&arg0.clearing_house.market_params) == 0, 19);
        assert!(v0 != 0, 1);
        execute_market_order<T0>(arg0, arg1, v0);
    }

    public fun posted_base_by_side(arg0: &SessionSummary) : (u256, u256) {
        (arg0.base_posted_ask, arg0.base_posted_bid)
    }

    public fun posted_orders(arg0: &SessionSummary) : u64 {
        arg0.posted_orders
    }

    fun process_fill_maker(arg0: &mut SessionSummary, arg1: &mut 0x2::object::UID, arg2: u128, arg3: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::Order, arg4: u64, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u256, arg16: u64, arg17: u64, arg18: &mut bool) : (u64, bool, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::FilledMakerOrder, u256) {
        let v0 = 0x2::object::uid_to_inner(arg1);
        let (v1, v2, v3, v4, v5, v6) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::order_snapshot(arg3);
        let v7 = v6;
        let (_, v9) = fee_multipliers(arg1, v1, arg4);
        let v10 = borrow_mut_position_from_id(arg1, v1);
        settle_position_funding_and_emit(v10, arg5, arg11, arg12, &v0, v1);
        let (v11, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v10);
        let v13 = arg2 < 170141183460469231731687303715884105728;
        let v14 = 0x1::option::none<u8>();
        let v15 = 0x1::option::none<u8>();
        let v16 = if (v4) {
            v14 = 0x1::option::some<u8>(4);
            if (v11 != 0 && (v13 && !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v11) || !v13 && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v11))) {
                let v17 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v11);
                if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than_eq(v17, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v3, 1000000000))) {
                    v3
                } else {
                    0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(v17, 1000000000)
                }
            } else {
                0
            }
        } else {
            v3
        };
        let v18 = v16;
        if (arg4 >= 0x1::option::destroy_with_default<u64>(v5, 18446744073709551615)) {
            v18 = 0;
            v14 = 0x1::option::some<u8>(5);
        } else if (arg16 == v1) {
            v18 = 0;
            v14 = 0x1::option::some<u8>(6);
        };
        let (v19, v20, v21, v22, v23, v24, v25) = if (v18 != 0 && arg17 != 0) {
            let v26 = if (arg2 < 170141183460469231731687303715884105728) {
                ((arg2 >> 64) as u64)
            } else {
                ((arg2 >> 64) as u64) ^ 18446744073709551615
            };
            let (v27, v28) = fill_base_and_quote_deltas(v26, 0x1::u64::min(v18, arg17));
            let v29 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg13, v27);
            let v30 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v29, arg14)) {
                0x1::option::some<u256>(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v29, arg15))
            } else {
                0x1::option::none<u256>()
            };
            let v31 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul_toward_zero(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul_toward_zero(arg7, v9), arg8), v28);
            let (v32, v33) = if (0x1::option::is_some<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>(&v7)) {
                let v34 = 0x1::option::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>(&v7);
                (0x1::option::some<u32>(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::integrator_id(v34)), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::integrator_fee(v34), v28))
            } else {
                (0x1::option::none<u32>(), 0)
            };
            let (v35, v36, v37) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::apply_maker_fill_or_restore_if_bad_debt(v10, v13, v27, v28, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v31, v33), arg9, arg5, arg6, arg10, v30);
            if (v35) {
                let v38 = MakerFill{
                    account_id : v1,
                    quote      : 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v28),
                };
                0x1::vector::push_back<MakerFill>(&mut arg0.maker_fills, v38);
                (v27, v28, v36, v31, v32, v33, v37)
            } else {
                v18 = 0;
                v14 = 0x1::option::some<u8>(7);
                (0, 0, 0, 0, 0x1::option::none<u32>(), 0, v11)
            }
        } else {
            (0, 0, 0, 0, 0x1::option::none<u32>(), 0, v11)
        };
        let v39 = 0;
        let v40 = true;
        let v41 = if (v18 == v3) {
            if (arg17 >= v18) {
                v18
            } else {
                0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::reduce_order_size(arg3, arg17);
                v40 = false;
                arg17
            }
        } else if (arg17 >= v18) {
            let v42 = v3 - v18;
            v39 = v42;
            v15 = v14;
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_pending_amount(v10, v13, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v42, 1000000000));
            if (arg16 == v1 && v42 != 0) {
                *arg18 = true;
            };
            v18
        } else {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::reduce_order_size(arg3, arg17);
            v40 = false;
            arg17
        };
        if (v40) {
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::update_pending_orders(v10, false, 1);
        };
        let v43 = if (v41 != 0) {
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_pending_amount(v10, v13, v19);
            if (v13) {
                assert!(arg0.base_filled_ask == 0, 51);
                arg0.base_filled_bid = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.base_filled_bid, v19);
                arg0.quote_filled_bid = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.quote_filled_bid, v20);
            } else {
                assert!(arg0.base_filled_bid == 0, 51);
                arg0.base_filled_ask = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.base_filled_ask, v19);
                arg0.quote_filled_ask = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.quote_filled_ask, v20);
            };
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v25, 0), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::max(v11, 0))
        } else {
            0
        };
        (v41, v40, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::filled_maker_order(v0, v1, arg16, arg2, v2, v41, v3 - v41 - v39, v39, v15, v21, v22, arg6, v23, v24), v43)
    }

    fun process_post(arg0: &mut 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position, arg1: u64, arg2: &SessionSummary) {
        if (arg2.posted_orders == 0) {
            return
        };
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::update_pending_orders(arg0, true, arg2.posted_orders);
        assert!(0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::pending_order_count(arg0) <= arg1, 37);
        if (arg2.base_posted_ask != 0) {
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_pending_amount(arg0, true, arg2.base_posted_ask);
        };
        if (arg2.base_posted_bid != 0) {
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_pending_amount(arg0, false, arg2.base_posted_bid);
        };
    }

    public(friend) fun reduce_liquidated_position(arg0: &mut 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position, arg1: u128, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256) : LiquidationOutcome {
        let (v0, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(arg0);
        let v2 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(arg1, 1000000000);
        let v3 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v2, arg2);
        let v4 = !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v0);
        let (v5, v6, v7) = if (arg1 != 0) {
            let (v8, v9) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_base_to_position(arg0, v4, v2, v3);
            let v10 = if (v4) {
                0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::neg(v2)
            } else {
                0
            };
            (v8, v10, v9)
        } else {
            (0, 0, v0)
        };
        let v11 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg4, v3);
        let v12 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(arg5, v3);
        let v13 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v5, v12);
        let v14 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::collateral(arg0), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(v13, arg3));
        let v15 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v14, arg3);
        let v16 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(v15, 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::unrealized_pnl(arg0, arg2));
        let v17 = 0;
        let v18 = v7 == 0 && 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v14);
        let v19 = if (!v18) {
            if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v16, 0)) {
                !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v14)
            } else {
                false
            }
        } else {
            false
        };
        let v20 = if (v19) {
            0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::min(v15, v16)
        } else {
            0
        };
        let v21 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(v11, v20)) {
            v11
        } else {
            v20
        };
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::add_to_collateral_usd(arg0, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(v13, v21), arg3);
        if (v18) {
            v17 = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::reset_collateral(arg0);
        };
        let (v22, v23) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::compute_margin_and_requirement(arg0, arg3, arg2, arg6, arg7);
        LiquidationOutcome{
            margin              : v22,
            min_margin          : v23,
            is_long             : v4,
            base_liquidated     : v2,
            quote_liquidated    : v3,
            pnl                 : v5,
            liquidation_fees    : v12,
            insurance_fund_fees : v21,
            bad_debt            : v17,
            open_interest_delta : v6,
        }
    }

    public fun register_market<T0, T1, T2>(arg0: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &ClearingHouse<T2>) {
        assert_package_version<T2>(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg0, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg0, arg1, 0x2::object::uid_as_inner(&arg2.id));
        let v0 = market_params<T2>(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::register_market<T2>(arg0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_storage_id(v0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_source_id(v0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_storage_id(v0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_source_id(v0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(v0), 0x2::object::uid_to_inner(&arg2.id));
    }

    public fun remove_extension_field_as_extension<T0, T1: drop, T2: copy + drop + store, T3: store>(arg0: &mut ClearingHouse<T0>, arg1: &T1, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: T2) : T3 {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_extension_authorized<T1>(arg2);
        0x2::dynamic_field::remove<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::ExtensionFieldKey<T1, T2>, T3>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::extension_field<T1, T2>(arg3))
    }

    public fun remove_registered_market<T0, T1, T2>(arg0: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &ClearingHouse<T2>) {
        assert_package_version<T2>(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg0, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg0, arg1, 0x2::object::uid_as_inner(&arg2.id));
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::remove_registered_market<T2>(arg0, 0x2::object::uid_to_inner(&arg2.id));
    }

    public fun resume_market<T0, T1, T2>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, T2>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry) {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        assert_market_is_not_closed<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, T2>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T1, T2>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        arg0.paused = 0;
    }

    fun session_has_activity(arg0: &SessionSummary, arg1: &vector<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::FilledMakerOrder>, arg2: &0x1::option::Option<u64>) : bool {
        if (0x1::option::is_some<u64>(arg2)) {
            true
        } else if (arg0.posted_orders != 0) {
            true
        } else {
            !0x1::vector::is_empty<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::FilledMakerOrder>(arg1)
        }
    }

    public fun set_base_oracle_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u64>) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg3);
        let v1 = if (0x1::option::is_some<u16>(&arg4)) {
            *0x1::option::borrow<u16>(&arg4)
        } else {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_source_id(market_params<T2>(arg0))
        };
        assert!(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::contains(arg3, v1), 17);
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::set_base_oracle_params(borrow_mut_market_params<T2>(arg0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::config(arg2), &v2, v0, 0x1::option::some<u16>(v1), arg5);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::set_base_oracle_params_<T2>(arg2, v2, v0, v1);
    }

    public fun set_collateral_oracle_params<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T1>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: 0x1::option::Option<u16>, arg5: 0x1::option::Option<u64>) {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T1>(arg2, arg1);
        let v0 = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg3);
        let v1 = if (0x1::option::is_some<u16>(&arg4)) {
            *0x1::option::borrow<u16>(&arg4)
        } else {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_source_id(market_params<T0>(arg0))
        };
        assert!(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::contains(arg3, v1), 17);
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::set_collateral_oracle_params(borrow_mut_market_params<T0>(arg0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::config(arg2), &v2, v0, 0x1::option::some<u16>(v1), arg5);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::set_collateral_oracle_params_<T0>(arg2, v2, v0, v1);
    }

    public fun set_core_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u256>) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::set_core_params(borrow_mut_market_params<T2>(arg0), &v0, arg3, arg4, arg5);
    }

    public fun set_fee_multiplier_as_extension<T0, T1: drop>(arg0: &mut ClearingHouse<T0>, arg1: &T1, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u64, arg4: u256, arg5: u256, arg6: u64) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_extension_authorized<T1>(arg2);
        assert_package_version<T0>(arg0);
        assert!(is_discount(arg4) && is_maker_multiplier(arg5), 59);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::fee_multiplier(arg3);
        if (0x2::dynamic_field::exists_with_type<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FeeMultiplierKey, FeeMultiplier>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FeeMultiplierKey, FeeMultiplier>(&mut arg0.id, v0);
        };
        let v1 = FeeMultiplier{
            taker      : arg4,
            maker      : arg5,
            expires_ms : arg6,
        };
        0x2::dynamic_field::add<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FeeMultiplierKey, FeeMultiplier>(&mut arg0.id, v0, v1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::set_fee_multiplier(0x2::object::uid_to_inner(&arg0.id), arg3, arg4, arg5, arg6);
    }

    public fun set_fee_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u256>, arg5: 0x1::option::Option<u256>, arg6: 0x1::option::Option<u256>, arg7: 0x1::option::Option<0x1::option::Option<u256>>) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::set_fee_params(borrow_mut_market_params<T2>(arg0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::config(arg2), &v0, arg3, arg4, arg5, arg6, arg7);
    }

    public fun set_position_initial_margin_ratio<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: u256) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let (v0, _) = market_objects<T0>(arg0);
        let v2 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_initial(v0);
        let v3 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg2);
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::set_initial_margin_ratio(borrow_mut_position<T0>(arg0, v3), arg3, v2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::set_position_initial_margin_ratio(v4, v3, arg3);
    }

    public fun set_risk_limit_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: 0x1::option::Option<u256>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u256>, arg6: 0x1::option::Option<u256>, arg7: 0x1::option::Option<u256>, arg8: 0x1::option::Option<u256>, arg9: 0x1::option::Option<u256>, arg10: 0x1::option::Option<u256>, arg11: 0x1::option::Option<u256>, arg12: 0x1::option::Option<u256>) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::set_risk_limit_params(borrow_mut_market_params<T2>(arg0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::config(arg2), &v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun set_settlement_prices<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u256, arg4: u256) {
        assert_package_version<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        assert_market_is_closed<T2>(arg0);
        assert_settlement_prices(arg3, arg4);
        assert!(!settlement_prices<T2>(arg0).enabled, 12);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = borrow_mut_settlement_prices<T2>(arg0);
        v1.base_price = 0x1::option::some<u256>(arg3);
        v1.collateral_price = 0x1::option::some<u256>(arg4);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::updated_settlement_prices(v0, arg3, arg4, false);
    }

    public fun set_twap_params<T0, T1, T2>(arg0: &mut ClearingHouse<T2>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock) {
        assert_package_version<T2>(arg0);
        assert_market_is_not_paused<T2>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_or_maintenance_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T0>, T1>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T0, T1>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::try_update_fundings(&arg0.market_params, &mut arg0.market_state, 0x2::clock::timestamp_ms(arg9), &v0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::set_twap_params(borrow_mut_market_params<T2>(arg0), 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::config(arg2), &v0, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun settle_liquidated_position<T0>(arg0: &mut SessionHotPotato<T0>, arg1: u64, arg2: u128, arg3: u128, arg4: u64, arg5: &0x2::object::ID) {
        let (v0, v1) = market_objects<T0>(&arg0.clearing_house);
        let (v2, v3) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::liquidation_fee_rates(v0);
        let v4 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(v0);
        let v5 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_initial(v0);
        let v6 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_maintenance(v0);
        let v7 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_haircut(v0);
        let (v8, v9) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(v1);
        let v10 = arg0.mark_price;
        let v11 = &mut arg0.clearing_house;
        let v12 = borrow_mut_position<T0>(v11, arg1);
        settle_position_funding_and_emit(v12, arg0.collateral_price, v8, v9, arg5, arg1);
        let (v13, v14) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::compute_margin_and_requirement(v12, arg0.collateral_price, v10, v6, v7);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(v13, v14), 38);
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_pending_amount(v12, true, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(arg2, 1000000000));
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_pending_amount(v12, false, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(arg3, 1000000000));
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::update_pending_orders(v12, false, arg4);
        let (v15, v16) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::pending_base_amounts_by_side(v12);
        let v17 = if (v15 == 0) {
            if (v16 == 0) {
                0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::pending_order_count(v12) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v17, 4);
        let (v18, v19) = compute_liquidation_size_and_mode(v12, arg0.collateral_price, v10, v5, v2, v3, v7);
        let (v20, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v12);
        let v22 = if (v19) {
            0
        } else {
            clip_size_to_liquidate(v18, v20, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::lot_size(v0))
        };
        let v23 = reduce_liquidated_position(v12, v22, v10, arg0.collateral_price, v3, v2, v5, v7);
        if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(v23.margin, v23.min_margin)) {
            let (v24, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v12);
            let v26 = reduce_liquidated_position(v12, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_u128balance(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(v24), 1000000000), v10, arg0.collateral_price, v3, v2, v5, v7);
            let v27 = &mut v23;
            add(v27, &v26);
        };
        if (v23.insurance_fund_fees != 0) {
            let v28 = &mut arg0.clearing_house;
            let v29 = borrow_mut_market_vault<T0>(v28);
            transfer_from_vault_to_insurance_fund<T0>(v29, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(v23.insurance_fund_fees, arg0.collateral_price), v4);
        };
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::liquidated_position(*arg5, arg1, arg0.account_id, v23.is_long, v23.base_liquidated, v23.quote_liquidated, v23.pnl, v23.liquidation_fees, v23.insurance_fund_fees, v23.bad_debt, v10);
        arg0.total_open_interest = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg0.total_open_interest, v23.open_interest_delta);
        arg0.liqee_account_id = 0x1::option::some<u64>(arg1);
        arg0.liquidator_fees = v23.liquidation_fees;
        arg0.session_summary.base_liquidated = v23.base_liquidated;
        arg0.session_summary.quote_liquidated = v23.quote_liquidated;
        arg0.session_summary.is_liqee_long = v23.is_long;
        arg0.session_summary.bad_debt = v23.bad_debt;
    }

    public fun settle_position_funding<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_oracle_price(&arg0.market_params, arg1, arg3);
        let (v1, v2) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(&arg0.market_state);
        let v3 = 0x2::object::uid_to_inner(&arg0.id);
        let v4 = borrow_mut_position<T0>(arg0, arg2);
        settle_position_funding_and_emit(v4, v0, v1, v2, &v3, arg2);
    }

    public(friend) fun settle_position_funding_and_emit(arg0: &mut 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::Position, arg1: u256, arg2: u256, arg3: u256, arg4: &0x2::object::ID, arg5: u64) {
        let (v0, v1, v2) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::settle_position_funding(arg0, arg1, arg2, arg3);
        if (v0) {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::settled_funding(*arg4, arg5, v1, v2, arg2, arg3);
        };
    }

    public(friend) fun settlement_prices<T0>(arg0: &ClearingHouse<T0>) : &SettlementPrices {
        0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::SettlementPricesKey, SettlementPrices>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::settlement_prices())
    }

    public fun settlement_valuation_prices<T0>(arg0: &ClearingHouse<T0>) : (bool, u256, u256) {
        if (!0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::SettlementPricesKey>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::settlement_prices())) {
            return (false, 0, 0)
        };
        let v0 = 0x2::dynamic_field::borrow<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::SettlementPricesKey, SettlementPrices>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::settlement_prices());
        if (!v0.enabled) {
            return (false, 0, 0)
        };
        (true, *0x1::option::borrow<u256>(&v0.base_price), *0x1::option::borrow<u256>(&v0.collateral_price))
    }

    public fun share<T0>(arg0: ClearingHouse<T0>) {
        0x2::transfer::share_object<ClearingHouse<T0>>(arg0);
    }

    public fun start_session<T0, T1>(arg0: ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg5: 0x1::option::Option<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : SessionHotPotato<T0> {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(&arg0);
        assert_market_is_not_paused<T0>(&arg0);
        start_session_<T0>(arg0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg2), arg3, arg4, 0x2::tx_context::gas_price(arg7) > 0x2::tx_context::reference_gas_price(arg7), arg5, arg6)
    }

    public(friend) fun start_session_<T0>(arg0: ClearingHouse<T0>, arg1: u64, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: bool, arg5: 0x1::option::Option<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>, arg6: &0x2::clock::Clock) : SessionHotPotato<T0> {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = market_params<T0>(&arg0);
        let v3 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_oracle_price(v2, arg3, arg6);
        let (v4, v5) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_oracle_price_and_twap_price(v2, arg2, arg6);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::assert_index_twap_divergence_within_limit(v2, v4, v5);
        let v6 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price_or_index(&arg0.orderbook, v4);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::try_update_fundings_and_twaps(&arg0.market_params, &mut arg0.market_state, v1, v4, v6, &v0);
        let (v7, v8) = market_objects<T0>(&arg0);
        let (v9, v10) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(v8);
        let v11 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::calculate_mark_price(v8, v7, v5, v6, v1);
        let v12 = &mut arg0;
        let v13 = borrow_mut_position<T0>(v12, arg1);
        let v14 = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::effective_initial_margin_ratio(v13, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_initial(v7));
        let (v15, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(v13);
        settle_position_funding_and_emit(v13, v3, v9, v10, &v0, arg1);
        let (v17, v18) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::compute_margin_and_requirement(v13, v3, v11, v14, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_haircut(v7));
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
            maker_events            : 0x1::vector::empty<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::FilledMakerOrder>(),
            integrator_info         : arg5,
            liqee_account_id        : 0x1::option::none<u64>(),
            liquidator_fees         : 0,
            session_summary         : create_session_summary(),
        }
    }

    public fun start_session_as_extension<T0, T1: drop>(arg0: ClearingHouse<T0>, arg1: &T1, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u64, arg4: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg5: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg6: bool, arg7: 0x1::option::Option<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::IntegratorInfo>, arg8: &0x2::clock::Clock) : SessionHotPotato<T0> {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_extension_authorized<T1>(arg2);
        start_session_<T0>(arg0, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun summary<T0>(arg0: &SessionHotPotato<T0>) : &SessionSummary {
        &arg0.session_summary
    }

    fun transfer_from_insurance_fund_to_vault<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u256) {
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(arg1, arg2);
        let v1 = if (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v0, arg2) == arg1) {
            v0
        } else {
            v0 + 1
        };
        0x2::balance::join<T0>(&mut arg0.collateral_balance, 0x2::balance::split<T0>(&mut arg0.insurance_fund_balance, v1));
    }

    fun transfer_from_vault_to_insurance_fund<T0>(arg0: &mut Vault<T0>, arg1: u256, arg2: u256) {
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(arg1, arg2);
        assert!(0x2::balance::value<T0>(&arg0.collateral_balance) >= v0, 23);
        0x2::balance::join<T0>(&mut arg0.insurance_fund_balance, 0x2::balance::split<T0>(&mut arg0.collateral_balance, v0));
    }

    public fun try_cancel_orders<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::ACCOUNT, T1>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::Account<T0>, arg3: &vector<u128>) : vector<bool> {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::assert_authority_cap_is_valid<T0, T1>(arg2, arg1);
        assert_package_version<T0>(arg0);
        assert_market_allows_order_cancellation<T0>(arg0);
        try_cancel_orders_<T0>(arg0, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::account::account_id<T0>(arg2), arg3, 0x1::option::none<u64>(), 0, 0)
    }

    fun try_cancel_orders_<T0>(arg0: &mut ClearingHouse<T0>, arg1: u64, arg2: &vector<u128>, arg3: 0x1::option::Option<u64>, arg4: u256, arg5: u8) : vector<bool> {
        let v0 = vector[];
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = borrow_mut_orderbook<T0>(arg0);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u128>(arg2)) {
            let v7 = *0x1::vector::borrow<u128>(arg2, v6);
            let (v8, v9, v10, v11) = if (0x1::option::is_some<u64>(&arg3)) {
                let (v12, v13, v14, v15) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::try_cancel_stale_limit_order(v2, arg1, v7, *0x1::option::borrow<u64>(&arg3), arg4);
                let v16 = if (v13) {
                    5
                } else {
                    4
                };
                (v12, v14, v15, v16)
            } else {
                let (v17, v18, v19) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::try_cancel_limit_order(v2, arg1, v7);
                (v17, v18, v19, arg5)
            };
            0x1::vector::push_back<bool>(&mut v0, v8);
            if (v8) {
                v5 = v5 + 1;
                if (v7 < 170141183460469231731687303715884105728) {
                    v3 = v3 + (v9 as u128);
                } else {
                    v4 = v4 + (v9 as u128);
                };
                0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::canceled_order(v1, arg1, v7, v10, v9, v11, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::orderbook::book_price(v2));
            };
            v6 = v6 + 1;
        };
        if (v5 != 0) {
            let v20 = borrow_mut_position<T0>(arg0, arg1);
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_pending_amount(v20, true, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(v3, 1000000000));
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_pending_amount(v20, false, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_u128balance(v4, 1000000000));
            0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::update_pending_orders(v20, false, v5);
        };
        v0
    }

    public fun try_cancel_stale_orders<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::MAINTENANCE>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u64, arg4: &vector<u128>, arg5: &0x2::clock::Clock) : vector<bool> {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::MAINTENANCE>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T1, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::MAINTENANCE>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let (v0, _) = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::base_and_quote_amounts(position<T0>(arg0, arg3));
        try_cancel_orders_<T0>(arg0, arg3, arg4, 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg5)), v0, 0)
    }

    fun try_socialize_bad_debt(arg0: &mut 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::MarketState, arg1: u256, arg2: bool, arg3: u256, arg4: u256, arg5: u256, arg6: &0x2::object::ID, arg7: 0x1::option::Option<u256>) {
        let v0 = if (0x1::option::is_some<u256>(&arg7)) {
            0x1::option::destroy_some<u256>(arg7)
        } else {
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::open_interest(arg0)
        };
        assert!(v0 != 0, 21);
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div_up(arg3, v0);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(arg3, arg4), 22);
        assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than_eq(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(v1, arg1), arg5), 24);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::add_bad_debt_to_market(arg0, arg6, !arg2, arg3, v1);
    }

    public fun unfreeze_clearing_house<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>) {
        assert!(is_frozen<T0>(arg0), 55);
        let v0 = 0x2::dynamic_field::remove<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::FrozenVersionKey, u64>(&mut arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::frozen_version());
        assert!(v0 <= 1, 56);
        arg0.version = v0;
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::unfroze(0x2::object::uid_to_inner(&arg0.id), v0);
    }

    public fun update_funding<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::try_update_funding(&arg0.market_params, &mut arg0.market_state, arg1, arg2, &v0, book_price<T0>(arg0));
    }

    public fun update_fundings_and_twaps_as_extension<T0, T1: drop>(arg0: &mut ClearingHouse<T0>, arg1: &T1, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: u256, arg4: u256, arg5: u64) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_extension_authorized<T1>(arg2);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::try_update_fundings_and_twaps(&arg0.market_params, &mut arg0.market_state, arg5, arg3, arg4, &v0);
    }

    public fun update_twaps<T0>(arg0: &mut ClearingHouse<T0>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock) {
        assert_package_version<T0>(arg0);
        assert_market_is_not_paused<T0>(arg0);
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::try_update_twaps(&arg0.market_params, &mut arg0.market_state, arg1, arg2, &v0, book_price<T0>(arg0));
    }

    entry fun upgrade_version<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T1>) {
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_admin_or_authorized_assistant_authority_cap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::PACKAGE, T1>(arg1, arg2);
        assert!(arg0.version < 1, 2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::upgraded_version(0x2::object::uid_to_inner(&arg0.id), 1);
        arg0.version = 1;
    }

    fun valid_liquidation_alpha(arg0: u256) : bool {
        !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::less_than(arg0, 0) && !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(arg0, 1000000000000000000)
    }

    public fun version<T0>(arg0: &ClearingHouse<T0>) : u64 {
        arg0.version
    }

    fun waived_fee_liquidation_alpha(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : (bool, u256) {
        let v0 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg1, arg4);
        if (!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(v0, 0)) {
            return (false, 0)
        };
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div_up(arg0, v0);
        let v2 = valid_liquidation_alpha(v1) && !0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::greater_than(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::add(arg2, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(v1, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(arg3, arg4))), 0);
        (v2, v1)
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::TREASURY>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::TREASURY>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T1, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::TREASURY>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        let v0 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(&arg0.market_params);
        let v1 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::fees_accrued(&arg0.market_state), v0);
        if (v1 == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::sub_fees_accrued(&mut arg0.market_state, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v1, v0));
        let v2 = 0x2::object::uid_to_inner(&arg0.id);
        let v3 = borrow_mut_market_vault<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::withdrew_fees(0x2::tx_context::sender(arg3), v2, v1, 0x2::balance::value<T0>(&v3.collateral_balance));
        0x2::coin::take<T0>(&mut v3.collateral_balance, v1, arg3)
    }

    public(friend) fun withdraw_free_collateral_to_account_balance<T0>(arg0: &mut ClearingHouse<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: u256, arg4: u256, arg5: u256, arg6: u64, arg7: 0x1::option::Option<u64>) : u64 {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let (v1, v2) = market_objects<T0>(arg0);
        let v3 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(v1);
        let v4 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::calculate_mark_price(v2, v1, arg4, arg5, arg2);
        let v5 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::margin_ratio_initial(v1);
        let (v6, v7) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::cum_funding_rates(v2);
        let v8 = borrow_mut_position<T0>(arg0, arg6);
        let v9 = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::effective_initial_margin_ratio(v8, v5);
        settle_position_funding_and_emit(v8, arg3, v6, v7, &v0, arg6);
        let v10 = 0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::compute_free_collateral(v8, arg3, v4, v9, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_haircut(v1));
        let (v11, v12) = if (0x1::option::is_some<u64>(&arg7)) {
            let v13 = 0x1::option::destroy_some<u64>(arg7);
            assert!(v13 != 0, 0);
            assert!(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(v10, v3) >= v13, 40);
            (v13, 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(v13, v3))
        } else {
            if (v10 == 0) {
                return 0
            };
            (0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(v10, v3), v10)
        };
        0xaedffd8aeff6ac5df6fc6071fd9bb602c03adf0919036c1e9fe39d27a5939f36::position::sub_from_collateral(v8, v12);
        let v14 = borrow_mut_market_vault<T0>(arg0);
        withdraw_vault_collateral<T0>(v14, arg1, v11);
        v11
    }

    public fun withdraw_insurance_fund<T0, T1>(arg0: &mut ClearingHouse<T0>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::TREASURY>, arg2: &0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::Registry, arg3: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_package_version<T0>(arg0);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_package_version(arg2);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_authority_cap_is_authorized<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::VENDOR<T1>, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::TREASURY>(arg2, arg1);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::assert_vendor_has_ownership_over_clearing_house<T1, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::authority::TREASURY>(arg2, arg1, 0x2::object::uid_as_inner(&arg0.id));
        if (arg6 == 0) {
            return 0x2::coin::zero<T0>(arg7)
        };
        let v0 = &arg0.market_params;
        let v1 = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::scaling_factor(v0);
        let (v2, v3) = if (0x2::dynamic_field::exists<0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::SettlementPricesKey>(&arg0.id, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::keys::settlement_prices())) {
            let v4 = settlement_prices<T0>(arg0);
            assert!(0x1::option::is_some<u256>(&v4.base_price) && 0x1::option::is_some<u256>(&v4.collateral_price), 7);
            (*0x1::option::borrow<u256>(&v4.base_price), *0x1::option::borrow<u256>(&v4.collateral_price))
        } else {
            let (v5, v6) = 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::base_oracle_price_and_twap_price(v0, arg3, arg5);
            0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::assert_index_twap_divergence_within_limit(v0, v5, v6);
            (v5, 0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::collateral_oracle_price(v0, arg4, arg5))
        };
        let v7 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::abs(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::market::open_interest(&arg0.market_state)), v2);
        let v8 = borrow_mut_market_vault<T0>(arg0);
        let v9 = 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::sub(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::from_balance(0x2::balance::value<T0>(&v8.insurance_fund_balance), v1), v3), 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::mul(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::insurance_open_interest_fraction(0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::registry::config(arg2)), v7));
        assert!(!0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::is_neg(v9), 29);
        assert!(arg6 <= 0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::to_balance(0xfef6e7c92ebda0a795db44d936819933150badad9b4efb2bf371bcd8b6633679::ifixed::div(v9, v3), v1), 29);
        0x278bfff240f37c7372a236cece0ae3b2462b71e909e3c7337366e902685195cb::events::withdrew_insurance_fund(0x2::tx_context::sender(arg7), 0x2::object::uid_to_inner(&arg0.id), arg6, 0x2::balance::value<T0>(&v8.insurance_fund_balance));
        0x2::coin::take<T0>(&mut v8.insurance_fund_balance, arg6, arg7)
    }

    fun withdraw_vault_collateral<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64) {
        assert!(0x2::balance::value<T0>(&arg0.collateral_balance) >= arg2, 23);
        0x2::balance::join<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.collateral_balance, arg2));
    }

    // decompiled from Move bytecode v7
}

