module 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        disabled_functions: 0x2::vec_set::VecSet<FunctionMask<T0>>,
        vaults_locked: bool,
        symbols_locked: bool,
        referral_rate: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate,
        rebase_fee_model: 0x2::object::ID,
        referrals: 0x2::table::Table<address, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::Referral>,
        vaults: 0x2::bag::Bag,
        symbols: 0x2::bag::Bag,
        positions: 0x2::bag::Bag,
        orders: 0x2::bag::Bag,
        lp_supply: 0x2::balance::Supply<T0>,
        version: u64,
    }

    struct FunctionMask<phantom T0> has copy, drop, store {
        name: u8,
    }

    struct WrappedPositionConfig<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        enabled: bool,
        inner: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::PositionConfig,
    }

    struct PositionCap<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
    }

    struct OrderCap<phantom T0, phantom T1, phantom T2, phantom T3> has key {
        id: 0x2::object::UID,
        position_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LONG has drop {
        dummy_field: bool,
    }

    struct SHORT has drop {
        dummy_field: bool,
    }

    struct VaultName<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SymbolName<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionName<phantom T0, phantom T1, phantom T2> has copy, drop, store {
        id: 0x2::object::ID,
        owner: address,
    }

    struct OrderName<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop, store {
        id: 0x2::object::ID,
        owner: address,
        position_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct MarketCreated has copy, drop {
        referrals_parent: 0x2::object::ID,
        vaults_parent: 0x2::object::ID,
        symbols_parent: 0x2::object::ID,
        positions_parent: 0x2::object::ID,
        orders_parent: 0x2::object::ID,
        version: u64,
    }

    struct FunctionStatusUpdated has copy, drop {
        func_name: u8,
        enabled: bool,
    }

    struct VaultCreated<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct SymbolCreated<phantom T0, phantom T1> has copy, drop {
        dummy_field: bool,
    }

    struct SymbolRemoved<phantom T0, phantom T1> has copy, drop {
        dummy_field: bool,
    }

    struct CollateralAdded<phantom T0, phantom T1, phantom T2> has copy, drop {
        dummy_field: bool,
    }

    struct CollateralRemoved<phantom T0, phantom T1, phantom T2> has copy, drop {
        dummy_field: bool,
    }

    struct SymbolStatusUpdated<phantom T0, phantom T1> has copy, drop {
        open_enabled: bool,
        decrease_enabled: bool,
        liquidate_enabled: bool,
    }

    struct VaultStatusUpdated has copy, drop {
        enabled: bool,
    }

    struct FeeConfigUpdated<phantom T0> has copy, drop {
        fee_rate_percent: u8,
        fee_collector: address,
    }

    struct VaultFeederUpdated<phantom T0> has copy, drop {
        vault_name: VaultName<T0>,
        feeder: 0x2::object::ID,
    }

    struct VaultWeightUpdated<phantom T0> has copy, drop {
        vault_name: VaultName<T0>,
        weight: u256,
    }

    struct SymbolFeederUpdated<phantom T0, phantom T1> has copy, drop {
        symbol_name: SymbolName<T0, T1>,
        feeder: 0x2::object::ID,
    }

    struct SymbolAggPriceConfigParamsUpdated<phantom T0, phantom T1> has copy, drop {
        symbol_name: SymbolName<T0, T1>,
        max_interval: u64,
        max_price_confidence: u64,
    }

    struct ForcePositionCleared<phantom T0, phantom T1, phantom T2> has copy, drop {
        position_name: PositionName<T0, T1, T2>,
    }

    struct PositionConfigReplaced<phantom T0, phantom T1> has copy, drop {
        max_leverage: u64,
        min_holding_duration: u64,
        max_reserved_multiplier: u64,
        min_collateral_value: u256,
        min_order_fee_value: u256,
        open_fee_bps: u128,
        decrease_fee_bps: u128,
        liquidation_threshold: u128,
        liquidation_bonus: u128,
    }

    struct ReferralRateUpdated has copy, drop {
        referral_rate: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate,
    }

    struct ReferralAdded has copy, drop {
        owner: address,
        referrer: address,
        referral_rate: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate,
    }

    struct PositionClaimed<T0: copy + drop, T1: copy + drop> has copy, drop {
        position_name: 0x1::option::Option<T0>,
        event: T1,
    }

    struct ForcePositionSettled<phantom T0, phantom T1, phantom T2> has copy, drop {
        position_name: PositionName<T0, T1, T2>,
        timestamp: u64,
    }

    struct Deposited<phantom T0> has copy, drop {
        minter: address,
        price: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        deposit_amount: u64,
        mint_amount: u64,
        fee_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        referrer: address,
    }

    struct Withdrawn<phantom T0> has copy, drop {
        burner: address,
        price: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        withdraw_amount: u64,
        burn_amount: u64,
        fee_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
    }

    struct Swapped<phantom T0, phantom T1> has copy, drop {
        swapper: address,
        source_price: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        dest_price: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        source_amount: u64,
        dest_amount: u64,
        fee_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
    }

    struct OrderCreated<T0: copy + drop, T1: copy + drop> has copy, drop {
        order_name: T0,
        event: T1,
    }

    struct OrderExecuted<T0: copy + drop, T1: copy + drop> has copy, drop {
        executor: address,
        order_name: T0,
        claim: T1,
    }

    struct OrderCleared<T0: copy + drop> has copy, drop {
        order_name: T0,
    }

    struct VaultInfo has drop {
        price: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice,
        value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
    }

    struct VaultsValuation {
        timestamp: u64,
        num: u64,
        handled: 0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>,
        total_weight: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
    }

    struct SymbolsValuation {
        timestamp: u64,
        num: u64,
        lp_supply_amount: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        handled: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal,
    }

    public fun swap<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 3)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<T2>(), 10015);
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2, v3) = finalize_vaults_valuation<T0>(arg0, arg4);
        let v4 = v1;
        let v5 = 0x1::type_name::get<VaultName<T1>>();
        let (_, v7) = 0x2::vec_map::remove<0x1::type_name::TypeName, VaultInfo>(&mut v4, &v5);
        let VaultInfo {
            price : v8,
            value : v9,
        } = v7;
        let v10 = v8;
        let v11 = 0x1::type_name::get<VaultName<T2>>();
        let (_, v13) = 0x2::vec_map::remove<0x1::type_name::TypeName, VaultInfo>(&mut v4, &v11);
        let VaultInfo {
            price : v14,
            value : v15,
        } = v13;
        let v16 = v14;
        let v17 = VaultName<T1>{dummy_field: false};
        let (v18, v19) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::swap_in<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg0.vaults, v17), arg1, &v10, 0x2::coin::into_balance<T1>(arg2), v9, v3, v2);
        let v20 = VaultName<T2>{dummy_field: false};
        let (v21, v22) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::swap_out<T2>(0x2::bag::borrow_mut<VaultName<T2>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T2>>(&mut arg0.vaults, v20), arg1, &v16, arg3, v18, v15, v3, v2);
        let v23 = v21;
        pay_from_balance<T2>(v23, v0, arg5);
        let v24 = Swapped<T1, T2>{
            swapper       : v0,
            source_price  : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v10),
            dest_price    : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v16),
            source_amount : 0x2::coin::value<T1>(&arg2),
            dest_amount   : 0x2::balance::value<T2>(&v23),
            fee_value     : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::add(v19, v22),
        };
        0x2::event::emit<Swapped<T1, T2>>(v24);
    }

    entry fun update_agg_price_config_params<T0, T1, T2>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::update_agg_price_config_params(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::mut_symbol_price_config(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v0)), arg2, arg3);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        let v2 = SymbolAggPriceConfigParamsUpdated<T1, T2>{
            symbol_name          : v1,
            max_interval         : arg2,
            max_price_confidence : arg3,
        };
        0x2::event::emit<SymbolAggPriceConfigParamsUpdated<T1, T2>>(v2);
    }

    entry fun add_collateral_to_symbol<T0, T1, T2, T3>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T2, T3>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::add_collateral_to_symbol<T1>(0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v0));
        let v1 = CollateralAdded<T1, T2, T3>{dummy_field: false};
        0x2::event::emit<CollateralAdded<T1, T2, T3>>(v1);
    }

    entry fun add_new_referral<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 21)), 10001);
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::Referral>(&arg0.referrals, v0), 10005);
        0x2::table::add<address, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::Referral>(&mut arg0.referrals, v0, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::new_referral(arg1, arg0.referral_rate));
        let v1 = ReferralAdded{
            owner         : v0,
            referrer      : arg1,
            referral_rate : arg0.referral_rate,
        };
        0x2::event::emit<ReferralAdded>(v1);
    }

    entry fun add_new_symbol<T0, T1, T2>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u256, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u256, arg12: u256, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        validate_fee_bps((arg13 as u256));
        validate_fee_bps((arg14 as u256));
        validate_liquidation_params((arg15 as u256), (arg16 as u256));
        validate_leverage(arg8);
        validate_holding_duration(arg9);
        assert!(!arg1.symbols_locked, 10003);
        let v0 = WrappedPositionConfig<T1, T2>{
            id      : 0x2::object::new(arg17),
            enabled : true,
            inner   : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::new_position_config(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16),
        };
        0x2::transfer::share_object<WrappedPositionConfig<T1, T2>>(v0);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::add<SymbolName<T1, T2>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v1, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::new_symbol(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::create_funding_fee_model(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg6), 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_raw(arg7), arg17), 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::new_agg_price_config<T1>(arg2, arg3, arg4, arg5)));
        let v2 = SymbolCreated<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolCreated<T1, T2>>(v2);
    }

    entry fun add_new_vault<T0, T1>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u64, arg4: u64, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        validate_vault_weight(arg2);
        assert!(!arg1.vaults_locked, 10004);
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::add<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v0, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::new_vault<T1>(arg2, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::create_reserving_fee_model(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg7), arg8), 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::new_agg_price_config<T1>(arg3, arg4, arg5, arg6)));
        let v1 = VaultCreated<T1>{dummy_field: false};
        0x2::event::emit<VaultCreated<T1>>(v1);
    }

    public fun calculate_market_lp_price<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation, arg2: SymbolsValuation) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal {
        check_version<T0>(arg0);
        let (_, _, _, v3) = validate_market_valuation<T0>(arg0, arg1, arg2);
        let v4 = lp_supply_amount<T0>(arg0);
        if (0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::is_zero(&v4)) {
            0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero()
        } else {
            0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::div(v3, v4)
        }
    }

    fun check_version<T0>(arg0: &Market<T0>) {
        assert!(arg0.version == 1, 10020);
    }

    public entry fun clear_closed_position<T0, T1, T2, T3>(arg0: &mut Market<T0>, arg1: PositionCap<T1, T2, T3>, arg2: &0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 12)), 10001);
        check_version<T0>(arg0);
        let PositionCap { id: v0 } = arg1;
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v0),
            owner : 0x2::tx_context::sender(arg2),
        };
        if (0x2::bag::contains<PositionName<T1, T2, T3>>(&arg0.positions, v1)) {
            0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg0.positions, v1));
        };
        0x2::object::delete(v0);
    }

    public entry fun clear_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 13)), 10001);
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let OrderCap {
            id          : v1,
            position_id : v2,
        } = arg1;
        let v3 = v1;
        let v4 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::uid_to_inner(&v3),
            owner       : v0,
            position_id : v2,
        };
        0x2::object::delete(v3);
        let v5 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v4};
        0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v5);
        pay_from_balance<T4>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::destroy_decrease_position_order<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::DecreasePositionOrder<T4>>(&mut arg0.orders, v4)), v0, arg2);
    }

    public entry fun clear_open_position_order<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 16)), 10001);
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let OrderCap {
            id          : v1,
            position_id : v2,
        } = arg1;
        let v3 = v1;
        let v4 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::uid_to_inner(&v3),
            owner       : v0,
            position_id : v2,
        };
        let (v5, v6) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::destroy_open_position_order<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::OpenPositionOrder<T1, T4>>(&mut arg0.orders, v4));
        0x2::object::delete(v3);
        let v7 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v4};
        0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v7);
        pay_from_balance<T1>(v5, v0, arg2);
        pay_from_balance<T4>(v6, v0, arg2);
    }

    public(friend) fun create_market<T0>(arg0: 0x2::balance::Supply<T0>, arg1: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Market<T0>{
            id                 : 0x2::object::new(arg2),
            disabled_functions : 0x2::vec_set::empty<FunctionMask<T0>>(),
            vaults_locked      : false,
            symbols_locked     : false,
            referral_rate      : arg1,
            rebase_fee_model   : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::create_rebase_fee_model(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_permyriad(1), 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(10000000000000000), arg2),
            referrals          : 0x2::table::new<address, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::Referral>(arg2),
            vaults             : 0x2::bag::new(arg2),
            symbols            : 0x2::bag::new(arg2),
            positions          : 0x2::bag::new(arg2),
            orders             : 0x2::bag::new(arg2),
            lp_supply          : arg0,
            version            : 1,
        };
        let v1 = MarketCreated{
            referrals_parent : 0x2::object::id<0x2::table::Table<address, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::Referral>>(&v0.referrals),
            vaults_parent    : 0x2::object::id<0x2::bag::Bag>(&v0.vaults),
            symbols_parent   : 0x2::object::id<0x2::bag::Bag>(&v0.symbols),
            positions_parent : 0x2::object::id<0x2::bag::Bag>(&v0.positions),
            orders_parent    : 0x2::object::id<0x2::bag::Bag>(&v0.orders),
            version          : v0.version,
        };
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<Market<T0>>(v0);
    }

    public fun create_symbols_valuation<T0>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>) : SymbolsValuation {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 18)), 10001);
        assert!(!arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        arg1.symbols_locked = true;
        SymbolsValuation{
            timestamp        : 0x2::clock::timestamp_ms(arg0) / 1000,
            num              : 0x2::bag::length(&arg1.symbols),
            lp_supply_amount : lp_supply_amount<T0>(arg1),
            handled          : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            value            : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::zero(),
        }
    }

    public fun create_vaults_valuation<T0>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>) : VaultsValuation {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 17)), 10001);
        check_version<T0>(arg1);
        assert!(!arg1.vaults_locked, 10002);
        arg1.vaults_locked = true;
        VaultsValuation{
            timestamp    : 0x2::clock::timestamp_ms(arg0) / 1000,
            num          : 0x2::bag::length(&arg1.vaults),
            handled      : 0x2::vec_map::empty<0x1::type_name::TypeName, VaultInfo>(),
            total_weight : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero(),
            value        : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero(),
        }
    }

    public entry fun decrease_position<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg4: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 6)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        decrease_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x1::option::none<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate>(), 0x1::option::none<0x2::object::ID>(), arg13);
    }

    fun decrease_position_common<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg4: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: 0x1::option::Option<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate>, arg14: 0x1::option::Option<0x2::object::ID>, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 6)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        assert!(arg10 > 0, 10018);
        assert!(0x2::coin::value<T4>(&arg7) > 0, 10019);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<T4>(), 10031);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg15);
        let v2 = parse_direction<T3>();
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v3);
        let v5 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v6 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::symbol_price_config(v4), arg6, v0);
        let v7 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg12);
        let (v8, v9) = get_referral_data(&arg1.referrals, v1);
        let v10 = if (v2) {
            let v11 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v6);
            0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::lt(&v11, &v7)
        } else {
            let v12 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v6);
            0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::gt(&v12, &v7)
        };
        if (v10 || !arg9) {
            assert!(arg8 < 2, 10007);
            let v13 = VaultName<T1>{dummy_field: false};
            let v14 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v13)), arg5, v0);
            let v15 = 0x2::coin::into_balance<T4>(arg7);
            let v16 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(&v14, 0x2::balance::value<T4>(&v15));
            let v17 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::config_min_order_fee_value(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::position_config<T1>(0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v5)));
            assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ge(&v16, &v17), 10032);
            let v18 = 0x2::object::new(arg15);
            let v19 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v18),
                owner       : v1,
                position_id : 0x1::option::some<0x2::object::ID>(v5.id),
            };
            let (v20, v21) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::new_decrease_position_order<T4>(v0, arg9, arg10, v7, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg11), v15, arg14, arg13, v9);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::DecreasePositionOrder<T4>>(&mut arg1.orders, v19, v20);
            let v22 = OrderCap<T1, T2, T3, T4>{
                id          : v18,
                position_id : v19.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v22, v1);
            let v23 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::CreateDecreasePositionOrderEvent>{
                order_name : v19,
                event      : v21,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::CreateDecreasePositionOrderEvent>>(v23);
        } else {
            assert!(arg8 > 0, 10008);
            let v24 = VaultName<T1>{dummy_field: false};
            let v25 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v24);
            let v26 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(v25), arg5, v0);
            let v27 = 0x2::dynamic_object_field::borrow<u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::FeeConfig>(&arg1.id, 10001);
            let (v28, v29, v30, v31, v32) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::unwrap_decrease_position_result<T1>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::decrease_position<T1>(v25, v4, v27, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v5), arg3, arg4, &v26, &v6, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg11), v8, arg13, v2, arg10, lp_supply_amount<T0>(arg1), v0, v9));
            let v33 = v31;
            pay_from_balance<T1>(v28, v1, arg15);
            pay_from_balance<T1>(v29, v9, arg15);
            let v34 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::get_fee_collector(v27);
            pay_from_balance<T1>(v30, v34, arg15);
            if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v33)) {
                if (0x1::option::is_some<0x2::object::ID>(&arg14)) {
                    let v35 = *0x1::option::borrow<0x2::object::ID>(&arg14);
                    pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v33), 0x2::object::id_to_address(&v35), arg15);
                } else {
                    pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v33), v34, arg15);
                };
            } else {
                0x1::option::destroy_none<0x2::balance::Balance<T1>>(v33);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg7, v1);
            let v36 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreasePositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v5),
                event         : v32,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreasePositionSuccessEvent>>(v36);
        };
    }

    public entry fun decrease_position_with_scard<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg4: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 7)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        assert!(arg10 > 0, 10018);
        assert!(0x2::coin::value<T4>(&arg7) > 0, 10019);
        decrease_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x1::option::some<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::scard::calculate_card_rebate_rate(arg13)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard>(arg13)), arg14);
    }

    public entry fun decrease_reserved_from_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 8)), 10001);
        assert!(arg4 > 0, 10018);
        assert!(!arg1.vaults_locked, 10002);
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : 0x2::tx_context::sender(arg5),
        };
        let v2 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreaseReservedFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v1),
            event         : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::decrease_reserved_from_position<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v0), 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v1), arg3, arg4, 0x2::clock::timestamp_ms(arg0) / 1000),
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreaseReservedFromPositionEvent>>(v2);
    }

    public fun deposit<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 1)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
        let v0 = 0x2::tx_context::sender(arg6);
        let (_, v2) = get_referral_data(&arg0.referrals, v0);
        let v3 = 0x2::balance::supply_value<T0>(&arg0.lp_supply);
        let (v4, v5, v6, v7) = finalize_market_valuation<T0>(arg0, arg4, arg5);
        let v8 = v4;
        let v9 = 0x1::type_name::get<VaultName<T1>>();
        let (_, v11) = 0x2::vec_map::remove<0x1::type_name::TypeName, VaultInfo>(&mut v8, &v9);
        let VaultInfo {
            price : v12,
            value : v13,
        } = v11;
        let v14 = v12;
        let v15 = VaultName<T1>{dummy_field: false};
        let (v16, v17) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::deposit<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg0.vaults, v15), arg1, &v14, 0x2::coin::into_balance<T1>(arg2), arg3, v3, v7, v13, v6, v5);
        pay_from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, v16), v0, arg6);
        let v18 = Deposited<T1>{
            minter         : v0,
            price          : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v14),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            mint_amount    : v16,
            fee_value      : v17,
            referrer       : v2,
        };
        0x2::event::emit<Deposited<T1>>(v18);
    }

    public fun deposit_ptb<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 24)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
        let v0 = 0x2::tx_context::sender(arg6);
        let (_, v2) = get_referral_data(&arg0.referrals, v0);
        let v3 = 0x2::balance::supply_value<T0>(&arg0.lp_supply);
        let (v4, v5, v6, v7) = finalize_market_valuation<T0>(arg0, arg4, arg5);
        let v8 = v4;
        let v9 = 0x1::type_name::get<VaultName<T1>>();
        let (_, v11) = 0x2::vec_map::remove<0x1::type_name::TypeName, VaultInfo>(&mut v8, &v9);
        let VaultInfo {
            price : v12,
            value : v13,
        } = v11;
        let v14 = v12;
        let v15 = VaultName<T1>{dummy_field: false};
        let (v16, v17) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::deposit<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg0.vaults, v15), arg1, &v14, 0x2::coin::into_balance<T1>(arg2), arg3, v3, v7, v13, v6, v5);
        let v18 = Deposited<T1>{
            minter         : v0,
            price          : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v14),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            mint_amount    : v16,
            fee_value      : v17,
            referrer       : v2,
        };
        0x2::event::emit<Deposited<T1>>(v18);
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, v16), arg6)
    }

    public entry fun execute_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 14)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg8),
            owner : arg6,
        };
        let v3 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg7),
            owner       : arg6,
            position_id : 0x1::option::some<0x2::object::ID>(v2.id),
        };
        let v4 = 0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::DecreasePositionOrder<T4>>(&mut arg1.orders, v3);
        let v5 = VaultName<T1>{dummy_field: false};
        let v6 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v5);
        let v7 = SymbolName<T2, T3>{dummy_field: false};
        let v8 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v7);
        let v9 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(v6), arg4, v0);
        let v10 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::symbol_price_config(v8), arg5, v0);
        let v11 = 0x2::dynamic_object_field::borrow<u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::FeeConfig>(&arg1.id, 10001);
        let (v12, v13) = get_referral_data(&arg1.referrals, arg6);
        let (v14, v15) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::execute_decrease_position_order<T1, T4>(v4, v6, v8, v11, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v2), arg2, arg3, &v9, &v10, v12, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        let (v16, v17, v18, v19, v20) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::unwrap_decrease_position_result<T1>(v14);
        let v21 = v19;
        let v22 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::get_fee_collector(v11);
        pay_from_balance<T1>(v16, arg6, arg9);
        pay_from_balance<T1>(v17, v13, arg9);
        pay_from_balance<T1>(v18, v22, arg9);
        if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v21)) {
            if (0x1::option::is_some<0x2::object::ID>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::get_scard_id_from_decrease_order<T4>(v4))) {
                let v23 = *0x1::option::borrow<0x2::object::ID>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::get_scard_id_from_decrease_order<T4>(v4));
                pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v21), 0x2::object::id_to_address(&v23), arg9);
            } else {
                pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v21), v22, arg9);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T1>>(v21);
        };
        let v24 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreasePositionSuccessEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v2),
            event         : v20,
        };
        let v25 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreasePositionSuccessEvent>>{
            executor   : v1,
            order_name : v3,
            claim      : v24,
        };
        0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreasePositionSuccessEvent>>>(v25);
        pay_from_balance<T4>(v15, v1, arg9);
    }

    public entry fun execute_open_position_order<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 15)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg7),
            owner       : arg6,
            position_id : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = 0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::OpenPositionOrder<T1, T4>>(&mut arg1.orders, v2);
        let v4 = VaultName<T1>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v4);
        let v6 = SymbolName<T2, T3>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v6);
        let v8 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(v5), arg4, v0);
        let v9 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::symbol_price_config(v7), arg5, v0);
        let v10 = 0x2::dynamic_object_field::borrow<u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::FeeConfig>(&arg1.id, 10001);
        let (v11, v12) = get_referral_data(&arg1.referrals, arg6);
        let (v13, v14) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::execute_open_position_order<T1, T4>(v3, v5, v7, v10, arg2, arg3, &v8, &v9, v11, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        let (v15, v16, v17, v18, v19) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::unwrap_open_position_result<T1>(v13);
        let v20 = v18;
        let v21 = 0x2::object::new(arg8);
        let v22 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v21),
            owner : arg6,
        };
        0x2::bag::add<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v22, v15);
        let v23 = PositionCap<T1, T2, T3>{id: v21};
        0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v23, arg6);
        let v24 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::get_fee_collector(v10);
        pay_from_balance<T1>(v16, v12, arg8);
        pay_from_balance<T1>(v17, v24, arg8);
        if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v20)) {
            if (0x1::option::is_some<0x2::object::ID>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::get_scard_id_from_open_order<T1, T4>(v3))) {
                let v25 = *0x1::option::borrow<0x2::object::ID>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::get_scard_id_from_open_order<T1, T4>(v3));
                pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v20), 0x2::object::id_to_address(&v25), arg8);
            } else {
                pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v20), v24, arg8);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T1>>(v20);
        };
        let v26 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::OpenPositionSuccessEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v22),
            event         : v19,
        };
        let v27 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::OpenPositionSuccessEvent>>{
            executor   : v1,
            order_name : v2,
            claim      : v26,
        };
        0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::OpenPositionSuccessEvent>>>(v27);
        pay_from_balance<T4>(v14, v1, arg8);
    }

    fun finalize_market_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation, arg2: SymbolsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal) {
        check_version<T0>(arg0);
        let (v0, v1, v2) = finalize_vaults_valuation<T0>(arg0, arg1);
        let v3 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::add_with_decimal(finalize_symbols_valuation<T0>(arg0, arg2), v2);
        assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::is_positive(&v3), 10013);
        (v0, v1, v2, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::value(&v3))
    }

    fun finalize_symbols_valuation<T0>(arg0: &mut Market<T0>, arg1: SymbolsValuation) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal {
        check_version<T0>(arg0);
        let SymbolsValuation {
            timestamp        : _,
            num              : v1,
            lp_supply_amount : _,
            handled          : v3,
            value            : v4,
        } = arg1;
        let v5 = v3;
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&v5) == v1, 10012);
        arg0.symbols_locked = false;
        v4
    }

    fun finalize_vaults_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal) {
        check_version<T0>(arg0);
        let VaultsValuation {
            timestamp    : _,
            num          : v1,
            handled      : v2,
            total_weight : v3,
            value        : v4,
        } = arg1;
        let v5 = v2;
        assert!(0x2::vec_map::size<0x1::type_name::TypeName, VaultInfo>(&v5) == v1, 10011);
        arg0.vaults_locked = false;
        (v5, v3, v4)
    }

    entry fun force_clear_closed_position<T0, T1, T2, T3>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: address, arg3: address, arg4: &0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg2),
            owner : arg3,
        };
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v0));
        let v1 = ForcePositionCleared<T1, T2, T3>{position_name: v0};
        0x2::event::emit<ForcePositionCleared<T1, T2, T3>>(v1);
    }

    entry fun force_clear_executed_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: address, arg3: address, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 23)), 10001);
        check_version<T0>(arg1);
        let v0 = if (0x1::option::is_some<address>(&arg4)) {
            0x1::option::some<0x2::object::ID>(0x2::object::id_from_address(0x1::option::destroy_some<address>(arg4)))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v1 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg3),
            owner       : arg2,
            position_id : v0,
        };
        if (0x2::bag::contains<OrderName<T1, T2, T3, T4>>(&arg1.orders, v1)) {
            pay_from_balance<T4>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::destroy_decrease_position_order<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::DecreasePositionOrder<T4>>(&mut arg1.orders, v1)), arg2, arg5);
            let v2 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v1};
            0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v2);
        };
    }

    entry fun force_clear_executed_open_position_order<T0, T1, T2, T3, T4>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 22)), 10001);
        check_version<T0>(arg1);
        let v0 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg3),
            owner       : arg2,
            position_id : 0x1::option::none<0x2::object::ID>(),
        };
        if (0x2::bag::contains<OrderName<T1, T2, T3, T4>>(&arg1.orders, v0)) {
            let (v1, v2) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::destroy_open_position_order<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::OpenPositionOrder<T1, T4>>(&mut arg1.orders, v0));
            pay_from_balance<T1>(v1, arg2, arg4);
            pay_from_balance<T4>(v2, arg2, arg4);
            let v3 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v0};
            0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v3);
        };
    }

    entry fun force_close_position<T0, T1, T2, T3>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Market<T0>, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg4: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.vaults_locked && !arg2.symbols_locked, 10002);
        check_version<T0>(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg2.vaults, v1);
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg2.symbols, v3);
        let v5 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg8),
            owner : arg7,
        };
        let v6 = 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg2.positions, v5);
        let v7 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::position_amount<T1>(v6);
        let v8 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(v2), arg5, v0);
        let v9 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::symbol_price_config(v4), arg6, v0);
        let v10 = 0x2::dynamic_object_field::borrow<u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::FeeConfig>(&arg2.id, 10001);
        let (v11, v12) = get_referral_data(&arg2.referrals, arg7);
        let (v13, v14, v15, v16, v17) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::unwrap_decrease_position_result<T1>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::decrease_position<T1>(v2, v4, v10, v6, arg3, arg4, &v8, &v9, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero(), v11, 0x1::option::none<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate>(), parse_direction<T3>(), v7, lp_supply_amount<T0>(arg2), v0, v12));
        0x1::option::destroy_none<0x2::balance::Balance<T1>>(v16);
        pay_from_balance<T1>(v13, arg7, arg9);
        pay_from_balance<T1>(v14, v12, arg9);
        pay_from_balance<T1>(v15, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::get_fee_collector(v10), arg9);
        let v18 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreasePositionSuccessEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v5),
            event         : v17,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::DecreasePositionSuccessEvent>>(v18);
    }

    entry fun force_settle_position<T0, T1, T2, T3>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Market<T0>, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.vaults_locked && !arg2.symbols_locked, 10002);
        check_version<T0>(arg2);
        let v0 = VaultName<T1>{dummy_field: false};
        let v1 = SymbolName<T2, T3>{dummy_field: false};
        let v2 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg4),
            owner : arg3,
        };
        pay_from_balance<T1>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::force_settle_position<T1>(arg0, 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg2.vaults, v0), 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg2.symbols, v1), 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg2.positions, v2)), arg3, arg5);
        let v3 = ForcePositionSettled<T1, T2, T3>{
            position_name : v2,
            timestamp     : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<ForcePositionSettled<T1, T2, T3>>(v3);
    }

    fun get_referral_data(arg0: &0x2::table::Table<address, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::Referral>, arg1: address) : (0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate, address) {
        if (0x2::table::contains<address, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::Referral>(arg0, arg1)) {
            let v2 = 0x2::table::borrow<address, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::Referral>(arg0, arg1);
            (0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::get_rebate_rate(v2), 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::referral::get_referrer(v2))
        } else {
            (0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::zero(), @0x0)
        }
    }

    public fun has_symbol<T0, T1, T2>(arg0: &Market<T0>) : bool {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::contains<SymbolName<T1, T2>>(&arg0.symbols, v0)
    }

    public fun has_vault<T0, T1>(arg0: &Market<T0>) : bool {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::contains<VaultName<T1>>(&arg0.vaults, v0)
    }

    fun is_function_disabled<T0>(arg0: &Market<T0>, arg1: FunctionMask<T0>) : bool {
        0x2::vec_set::contains<FunctionMask<T0>>(&arg0.disabled_functions, &arg1)
    }

    public entry fun liquidate_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 11)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg7),
            owner : arg6,
        };
        let v7 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(v3), arg4, v0);
        let v8 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::symbol_price_config(v5), arg5, v0);
        let (v9, v10) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::liquidate_position<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v6), arg2, arg3, &v7, &v8, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0, v1);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::LiquidatePositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::LiquidatePositionEvent>>(v11);
    }

    public fun lp_supply_amount<T0>(arg0: &Market<T0>) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal {
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::div_by_u64(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_u64(0x2::balance::supply_value<T0>(&arg0.lp_supply)), 1000000)
    }

    entry fun migrate_version<T0>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>) {
        assert!(arg1.version < 1, 10021);
        arg1.version = 1;
    }

    fun new_function_mask<T0>(arg0: &Market<T0>, arg1: u8) : FunctionMask<T0> {
        FunctionMask<T0>{name: arg1}
    }

    public entry fun open_position<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 4)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        open_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::option::none<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate>(), 0x1::option::none<0x2::object::ID>(), arg14);
    }

    fun open_position_common<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: 0x1::option::Option<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate>, arg15: 0x1::option::Option<0x2::object::ID>, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 4)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        assert!(arg10 > 0, 10016);
        assert!(0x2::coin::value<T1>(&arg7) > 0, 10017);
        assert!(0x2::coin::value<T4>(&arg8) > 0, 10019);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<T4>(), 10031);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg16);
        let v2 = parse_direction<T3>();
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v3);
        let v5 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::symbol_price_config(v4), arg6, v0);
        let v6 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg13);
        let (v7, v8) = get_referral_data(&arg1.referrals, v1);
        let v9 = if (v2) {
            let v10 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v5);
            0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::gt(&v10, &v6)
        } else {
            let v11 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v5);
            0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::lt(&v11, &v6)
        };
        if (v9) {
            assert!(arg9 < 2, 10007);
            let v12 = VaultName<T1>{dummy_field: false};
            let v13 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v12)), arg5, v0);
            let v14 = 0x2::coin::into_balance<T4>(arg8);
            let v15 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(&v13, 0x2::balance::value<T4>(&v14));
            let v16 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::config_min_order_fee_value(&arg4.inner);
            assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ge(&v15, &v16), 10032);
            let v17 = 0x2::object::new(arg16);
            let v18 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v17),
                owner       : v1,
                position_id : 0x1::option::none<0x2::object::ID>(),
            };
            let (v19, v20) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::new_open_position_order<T1, T4>(v0, arg10, arg11, v6, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg12), arg4.inner, 0x2::coin::into_balance<T1>(arg7), v14, arg15, arg14, v8);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::OpenPositionOrder<T1, T4>>(&mut arg1.orders, v18, v19);
            let v21 = OrderCap<T1, T2, T3, T4>{
                id          : v17,
                position_id : v18.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v21, v1);
            let v22 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::CreateOpenPositionOrderEvent>{
                order_name : v18,
                event      : v20,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::orders::CreateOpenPositionOrderEvent>>(v22);
        } else {
            assert!(arg9 > 0, 10008);
            let v23 = VaultName<T1>{dummy_field: false};
            let v24 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v23);
            let v25 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(v24), arg5, v0);
            let v26 = 0x2::dynamic_object_field::borrow<u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::FeeConfig>(&arg1.id, 10001);
            let v27 = 0x2::object::new(arg16);
            let v28 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v27),
                owner : v1,
            };
            let v29 = 0x2::coin::into_balance<T1>(arg7);
            0x2::balance::destroy_zero<T1>(v29);
            let (v30, v31, v32, v33, v34) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::unwrap_open_position_result<T1>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::open_position<T1>(v24, v4, v26, arg2, arg3, &arg4.inner, &v25, &v5, &mut v29, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg12), v7, arg14, v2, arg10, arg11, lp_supply_amount<T0>(arg1), v0, v8));
            let v35 = v33;
            0x2::bag::add<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v28, v30);
            let v36 = PositionCap<T1, T2, T3>{id: v27};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v36, v1);
            pay_from_balance<T1>(v31, v8, arg16);
            let v37 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::get_fee_collector(v26);
            pay_from_balance<T1>(v32, v37, arg16);
            if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v35)) {
                if (0x1::option::is_some<0x2::object::ID>(&arg15)) {
                    let v38 = *0x1::option::borrow<0x2::object::ID>(&arg15);
                    pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v35), 0x2::object::id_to_address(&v38), arg16);
                } else {
                    pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v35), v37, arg16);
                };
            } else {
                0x1::option::destroy_none<0x2::balance::Balance<T1>>(v35);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, v1);
            let v39 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::OpenPositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v28),
                event         : v34,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::OpenPositionSuccessEvent>>(v39);
        };
    }

    public entry fun open_position_with_scard<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 5)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        assert!(arg10 > 0, 10016);
        assert!(0x2::coin::value<T1>(&arg7) > 0, 10017);
        assert!(0x2::coin::value<T4>(&arg8) > 0, 10019);
        open_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::option::some<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate>(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::scard::calculate_card_rebate_rate(arg14)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard>(arg14)), arg15);
    }

    public fun parse_direction<T0>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<LONG>()) {
            true
        } else {
            assert!(v0 == 0x1::type_name::get<SHORT>(), 10006);
            false
        }
    }

    fun pay_from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public entry fun pledge_in_position<T0, T1, T2, T3>(arg0: &mut Market<T0>, arg1: &PositionCap<T1, T2, T3>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 9)), 10001);
        check_version<T0>(arg0);
        let v0 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg1.id),
            owner : 0x2::tx_context::sender(arg3),
        };
        let v1 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::PledgeInPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v0),
            event         : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::pledge_in_position<T1>(0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg0.positions, v0), 0x2::coin::into_balance<T1>(arg2)),
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::PledgeInPositionEvent>>(v1);
    }

    public fun position<T0, T1, T2, T3>(arg0: &Market<T0>, arg1: 0x2::object::ID, arg2: address) : &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1> {
        let v0 = PositionName<T1, T2, T3>{
            id    : arg1,
            owner : arg2,
        };
        0x2::bag::borrow<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&arg0.positions, v0)
    }

    public fun rebase_fee_model<T0>(arg0: &Market<T0>) : &0x2::object::ID {
        &arg0.rebase_fee_model
    }

    public entry fun redeem_from_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg4: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 10)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v7 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(v3), arg5, v0);
        let v8 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::symbol_price_config(v5), arg6, v0);
        let (v9, v10) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::redeem_from_position<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::Position<T1>>(&mut arg1.positions, v6), arg3, arg4, &v7, &v8, parse_direction<T3>(), arg7, lp_supply_amount<T0>(arg1), v0);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::RedeemFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::RedeemFromPositionEvent>>(v11);
    }

    entry fun remove_collateral_from_symbol<T0, T1, T2, T3>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T2, T3>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::remove_collateral_from_symbol<T1>(0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v0));
        let v1 = CollateralRemoved<T1, T2, T3>{dummy_field: false};
        0x2::event::emit<CollateralRemoved<T1, T2, T3>>(v1);
    }

    entry fun remove_symbol_from_bag<T0, T1, T2>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::use_price_config(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::destroy_symbol(0x2::bag::remove<SymbolName<T1, T2>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v0)));
        let v1 = SymbolRemoved<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolRemoved<T1, T2>>(v1);
    }

    entry fun replace_position_config<T0, T1>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut WrappedPositionConfig<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u256, arg6: u256, arg7: u128, arg8: u128, arg9: u128, arg10: u128) {
        validate_fee_bps((arg7 as u256));
        validate_fee_bps((arg8 as u256));
        validate_liquidation_params((arg9 as u256), (arg10 as u256));
        validate_leverage(arg2);
        validate_holding_duration(arg3);
        arg1.inner = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position::new_position_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v0 = PositionConfigReplaced<T0, T1>{
            max_leverage            : arg2,
            min_holding_duration    : arg3,
            max_reserved_multiplier : arg4,
            min_collateral_value    : arg5,
            min_order_fee_value     : arg6,
            open_fee_bps            : arg7,
            decrease_fee_bps        : arg8,
            liquidation_threshold   : arg9,
            liquidation_bonus       : arg10,
        };
        0x2::event::emit<PositionConfigReplaced<T0, T1>>(v0);
    }

    entry fun replace_symbol_feeder<T0, T1, T2>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::update_agg_price_config_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::mut_symbol_price_config(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v0)), arg2);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        let v2 = SymbolFeederUpdated<T1, T2>{
            symbol_name : v1,
            feeder      : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::uid_to_inner(arg2),
        };
        0x2::event::emit<SymbolFeederUpdated<T1, T2>>(v2);
    }

    entry fun replace_vault_feeder<T0, T1>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::update_agg_price_config_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::mut_vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v0)), arg2);
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = VaultFeederUpdated<T1>{
            vault_name : v1,
            feeder     : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::uid_to_inner(arg2),
        };
        0x2::event::emit<VaultFeederUpdated<T1>>(v2);
    }

    entry fun replace_vault_weight<T0, T1>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256) {
        check_version<T0>(arg1);
        validate_vault_weight(arg2);
        let v0 = VaultName<T1>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::set_vault_weight<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v0), arg2);
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = VaultWeightUpdated<T1>{
            vault_name : v1,
            weight     : arg2,
        };
        0x2::event::emit<VaultWeightUpdated<T1>>(v2);
    }

    entry fun set_fee_config<T0>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_percent(arg2);
        validate_config_fee_rate((0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::to_raw(v0) as u256));
        if (0x2::dynamic_object_field::exists_<u64>(&arg1.id, 10001)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::FeeConfig>(&mut arg1.id, 10001);
            if (0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::to_raw(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::get_fee_rate(v1)) != 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::to_raw(v0) || 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::get_fee_collector(v1) != arg3) {
                0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::set_fee_config_rate(v1, v0, arg3);
                let v2 = FeeConfigUpdated<T0>{
                    fee_rate_percent : arg2,
                    fee_collector    : arg3,
                };
                0x2::event::emit<FeeConfigUpdated<T0>>(v2);
            };
        } else {
            0x2::dynamic_object_field::add<u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::FeeConfig>(&mut arg1.id, 10001, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::fee::new_fee_config(v0, arg3, arg4));
            let v3 = FeeConfigUpdated<T0>{
                fee_rate_percent : arg2,
                fee_collector    : arg3,
            };
            0x2::event::emit<FeeConfigUpdated<T0>>(v3);
        };
    }

    entry fun set_function_status<T0>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: u8, arg3: bool) {
        check_version<T0>(arg1);
        let v0 = new_function_mask<T0>(arg1, arg2);
        if (arg3) {
            if (0x2::vec_set::contains<FunctionMask<T0>>(&arg1.disabled_functions, &v0)) {
                0x2::vec_set::remove<FunctionMask<T0>>(&mut arg1.disabled_functions, &v0);
            };
        } else if (!0x2::vec_set::contains<FunctionMask<T0>>(&arg1.disabled_functions, &v0)) {
            0x2::vec_set::insert<FunctionMask<T0>>(&mut arg1.disabled_functions, v0);
        };
        let v1 = FunctionStatusUpdated{
            func_name : arg2,
            enabled   : arg3,
        };
        0x2::event::emit<FunctionStatusUpdated>(v1);
    }

    entry fun set_referral_rate<T0>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        validate_referral_rate((arg2 as u256));
        arg1.referral_rate = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_raw(arg2);
        let v0 = ReferralRateUpdated{referral_rate: arg1.referral_rate};
        0x2::event::emit<ReferralRateUpdated>(v0);
    }

    entry fun set_symbol_status<T0, T1, T2>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: bool, arg3: bool, arg4: bool) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::set_symbol_status(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg1.symbols, v0), arg2, arg3, arg4);
        let v1 = SymbolStatusUpdated<T1, T2>{
            open_enabled      : arg2,
            decrease_enabled  : arg3,
            liquidate_enabled : arg4,
        };
        0x2::event::emit<SymbolStatusUpdated<T1, T2>>(v1);
    }

    entry fun set_vault_status<T0, T1>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Market<T0>, arg2: bool) {
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::set_vault_status<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg1.vaults, v0), arg2);
        let v1 = VaultStatusUpdated{enabled: arg2};
        0x2::event::emit<VaultStatusUpdated>(v1);
    }

    public fun symbol<T0, T1, T2>(arg0: &Market<T0>) : &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::borrow<SymbolName<T1, T2>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&arg0.symbols, v0)
    }

    fun validate_config_fee_rate(arg0: u256) {
        assert!(arg0 >= 10000000000000000 && arg0 <= 500000000000000000, 10029);
    }

    fun validate_fee_bps(arg0: u256) {
        assert!(arg0 >= 100000000000000 && arg0 <= 20000000000000000, 10024);
    }

    fun validate_holding_duration(arg0: u64) {
        assert!(arg0 >= 10, 10023);
    }

    fun validate_leverage(arg0: u64) {
        assert!(arg0 >= 1 && arg0 <= 100, 10025);
    }

    fun validate_liquidation_params(arg0: u256, arg1: u256) {
        assert!(arg0 >= 10000000000000000 && arg0 <= 999000000000000000, 10026);
        assert!(arg1 >= 10000000000000000 && arg1 <= 999000000000000000, 10027);
        assert!(arg0 + arg1 < 1000000000000000000, 10028);
    }

    public fun validate_market_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation, arg2: SymbolsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal) {
        check_version<T0>(arg0);
        let (v0, v1, v2) = finalize_vaults_valuation<T0>(arg0, arg1);
        let v3 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::add_with_decimal(finalize_symbols_valuation<T0>(arg0, arg2), v2);
        assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::is_positive(&v3), 10013);
        (v0, v1, v2, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::value(&v3))
    }

    fun validate_referral_rate(arg0: u256) {
        assert!(arg0 >= 10000000000000000 && arg0 <= 250000000000000000, 10030);
    }

    fun validate_vault_weight(arg0: u256) {
        assert!(arg0 >= 10000000000000000 && arg0 <= 1000000000000000000, 10022);
    }

    public fun valuate_symbol<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::FundingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut SymbolsValuation) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 20)), 10001);
        check_version<T0>(arg0);
        let v0 = arg3.timestamp;
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Symbol>(&mut arg0.symbols, v1);
        let v3 = 0x1::type_name::get<SymbolName<T1, T2>>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.handled, &v3), 10010);
        let v4 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::symbol_price_config(v2), arg2, v0);
        arg3.value = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::add(arg3.value, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::valuate_symbol(v2, arg1, &v4, parse_direction<T2>(), arg3.lp_supply_amount, v0));
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg3.handled, v3);
    }

    public fun valuate_vault<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::ReservingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut VaultsValuation) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 19)), 10001);
        check_version<T0>(arg0);
        let v0 = arg3.timestamp;
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg0.vaults, v1);
        let v3 = 0x1::type_name::get<VaultName<T1>>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, VaultInfo>(&arg3.handled, &v3), 10009);
        let v4 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::parse_pyth_feeder(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_price_config<T1>(v2), arg2, v0);
        let v5 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::valuate_vault<T1>(v2, arg1, &v4, v0);
        arg3.value = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::add(arg3.value, v5);
        arg3.total_weight = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::add(arg3.total_weight, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::vault_weight<T1>(v2));
        let v6 = VaultInfo{
            price : v4,
            value : v5,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, VaultInfo>(&mut arg3.handled, v3, v6);
    }

    public fun vault<T0, T1>(arg0: &Market<T0>) : &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1> {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::borrow<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&arg0.vaults, v0)
    }

    public fun withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 2)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::balance::supply_value<T0>(&arg0.lp_supply);
        let (v2, v3, v4, v5) = finalize_market_valuation<T0>(arg0, arg4, arg5);
        let v6 = v2;
        let v7 = 0x1::type_name::get<VaultName<T1>>();
        let (_, v9) = 0x2::vec_map::remove<0x1::type_name::TypeName, VaultInfo>(&mut v6, &v7);
        let VaultInfo {
            price : v10,
            value : v11,
        } = v9;
        let v12 = v10;
        let v13 = VaultName<T1>{dummy_field: false};
        let v14 = 0x2::balance::decrease_supply<T0>(&mut arg0.lp_supply, 0x2::coin::into_balance<T0>(arg2));
        let (v15, v16) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::withdraw<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg0.vaults, v13), arg1, &v12, v14, arg3, v1, v5, v11, v4, v3);
        let v17 = v15;
        pay_from_balance<T1>(v17, v0, arg6);
        let v18 = Withdrawn<T1>{
            burner          : v0,
            price           : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v12),
            withdraw_amount : 0x2::balance::value<T1>(&v17),
            burn_amount     : v14,
            fee_value       : v16,
        };
        0x2::event::emit<Withdrawn<T1>>(v18);
    }

    public fun withdraw_ptb<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 25)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
        let v0 = 0x2::balance::supply_value<T0>(&arg0.lp_supply);
        let (v1, v2, v3, v4) = finalize_market_valuation<T0>(arg0, arg4, arg5);
        let v5 = v1;
        let v6 = 0x1::type_name::get<VaultName<T1>>();
        let (_, v8) = 0x2::vec_map::remove<0x1::type_name::TypeName, VaultInfo>(&mut v5, &v6);
        let VaultInfo {
            price : v9,
            value : v10,
        } = v8;
        let v11 = v9;
        let v12 = VaultName<T1>{dummy_field: false};
        let v13 = 0x2::balance::decrease_supply<T0>(&mut arg0.lp_supply, 0x2::coin::into_balance<T0>(arg2));
        let (v14, v15) = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::withdraw<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::pool::Vault<T1>>(&mut arg0.vaults, v12), arg1, &v11, v13, arg3, v0, v4, v10, v3, v2);
        let v16 = v14;
        let v17 = Withdrawn<T1>{
            burner          : 0x2::tx_context::sender(arg6),
            price           : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(&v11),
            withdraw_amount : 0x2::balance::value<T1>(&v16),
            burn_amount     : v13,
            fee_value       : v15,
        };
        0x2::event::emit<Withdrawn<T1>>(v17);
        0x2::coin::from_balance<T1>(v16, arg6)
    }

    // decompiled from Move bytecode v6
}

