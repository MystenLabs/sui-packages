module 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        disabled_functions: 0x2::vec_set::VecSet<FunctionMask<T0>>,
        vaults_locked: bool,
        symbols_locked: bool,
        referral_rate: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate,
        rebase_fee_model: 0x2::object::ID,
        referrals: 0x2::table::Table<address, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::Referral>,
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

    struct SymbolConfig has store, key {
        id: 0x2::object::UID,
        max_opening_size: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        max_opening_size_enabled: bool,
        max_opening_size_per_position: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        max_opening_size_per_position_enabled: bool,
        instant_exit_fee_config: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig,
    }

    struct WrappedPositionConfig<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        enabled: bool,
        inner: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionConfig,
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

    struct VaultRemoved<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct VaultEmptied<phantom T0> has copy, drop {
        withdrawn_amount: u64,
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
        referral_rate: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate,
    }

    struct ReferralAdded has copy, drop {
        owner: address,
        referrer: address,
        referral_rate: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate,
    }

    struct PositionClaimed<T0: copy + drop, T1: copy + drop> has copy, drop {
        position_name: 0x1::option::Option<T0>,
        event: T1,
    }

    struct ForcePositionSettled<phantom T0, phantom T1, phantom T2> has copy, drop {
        position_name: PositionName<T0, T1, T2>,
        timestamp: u64,
    }

    struct AdminLiquidityAdded<phantom T0> has copy, drop {
        depositer: address,
        deposit_amount: u64,
        after_liquidity: u64,
    }

    struct Deposited<phantom T0> has copy, drop {
        minter: address,
        price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        deposit_amount: u64,
        mint_amount: u64,
        fee_value: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        referrer: address,
    }

    struct Withdrawn<phantom T0> has copy, drop {
        burner: address,
        price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        withdraw_amount: u64,
        burn_amount: u64,
        fee_value: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
    }

    struct Swapped<phantom T0, phantom T1> has copy, drop {
        swapper: address,
        source_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        dest_price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        source_amount: u64,
        dest_amount: u64,
        fee_value: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
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
        price: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice,
        value: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
    }

    struct TradingFeederKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct TradingFeederPriceConfig has store, key {
        id: 0x2::object::UID,
        max_interval: u64,
        max_confidence: u64,
        use_confidence_adjusted_price: bool,
        confidence_adjust_percentage: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
    }

    struct TradingFeederPriceConfigV1 has store, key {
        id: 0x2::object::UID,
        max_interval: u64,
        max_confidence: u64,
        use_confidence_adjusted_price: bool,
        confidence_adjust_percentage: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
    }

    struct VaultsValuation {
        timestamp: u64,
        num: u64,
        handled: 0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>,
        total_weight: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        value: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
    }

    struct SymbolsValuation {
        timestamp: u64,
        num: u64,
        lp_supply_amount: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal,
        handled: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        value: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::SDecimal,
    }

    public fun swap<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 3)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
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
        let (v18, v19) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::swap_in<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg0.vaults, v17), arg1, &v10, 0x2::coin::into_balance<T1>(arg2), v9, v3, v2);
        let v20 = VaultName<T2>{dummy_field: false};
        let (v21, v22) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::swap_out<T2>(0x2::bag::borrow_mut<VaultName<T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T2>>(&mut arg0.vaults, v20), arg1, &v16, arg3, v18, v15, v3, v2);
        let v23 = v21;
        pay_from_balance<T2>(v23, v0, arg5);
        let v24 = Swapped<T1, T2>{
            swapper       : v0,
            source_price  : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v10),
            dest_price    : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v16),
            source_amount : 0x2::coin::value<T1>(&arg2),
            dest_amount   : 0x2::balance::value<T2>(&v23),
            fee_value     : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::add(v19, v22),
        };
        0x2::event::emit<Swapped<T1, T2>>(v24);
    }

    entry fun update_agg_price_config_params<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::update_agg_price_config_params(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::mut_symbol_price_config(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v0)), arg2, arg3);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        let v2 = SymbolAggPriceConfigParamsUpdated<T1, T2>{
            symbol_name          : v1,
            max_interval         : arg2,
            max_price_confidence : arg3,
        };
        0x2::event::emit<SymbolAggPriceConfigParamsUpdated<T1, T2>>(v2);
    }

    entry fun add_collateral_to_symbol<T0, T1, T2, T3>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T2, T3>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::add_collateral_to_symbol<T1>(0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v0));
        let v1 = CollateralAdded<T1, T2, T3>{dummy_field: false};
        0x2::event::emit<CollateralAdded<T1, T2, T3>>(v1);
    }

    entry fun add_new_referral<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 21)), 10001);
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::Referral>(&arg0.referrals, v0), 10005);
        0x2::table::add<address, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::Referral>(&mut arg0.referrals, v0, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::new_referral(arg1, arg0.referral_rate));
        let v1 = ReferralAdded{
            owner         : v0,
            referrer      : arg1,
            referral_rate : arg0.referral_rate,
        };
        0x2::event::emit<ReferralAdded>(v1);
    }

    entry fun add_new_symbol<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u256, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u256, arg12: u256, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: &mut 0x2::tx_context::TxContext) {
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
            inner   : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::new_position_config(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16),
        };
        0x2::transfer::share_object<WrappedPositionConfig<T1, T2>>(v0);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::add<SymbolName<T1, T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v1, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::new_symbol(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::create_funding_fee_model(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg6), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg7), arg17), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::new_agg_price_config<T1>(arg2, arg3, arg4, arg5)));
        let v2 = SymbolCreated<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolCreated<T1, T2>>(v2);
    }

    entry fun add_new_symbol_with_currency<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: &0x2::coin_registry::Currency<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u256, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u256, arg12: u256, arg13: u128, arg14: u128, arg15: u128, arg16: u128, arg17: &mut 0x2::tx_context::TxContext) {
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
            inner   : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::new_position_config(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16),
        };
        0x2::transfer::share_object<WrappedPositionConfig<T1, T2>>(v0);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::add<SymbolName<T1, T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v1, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::new_symbol(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::create_funding_fee_model(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg6), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg7), arg17), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::new_agg_price_config_from_currency<T1>(arg2, arg3, arg4, arg5)));
        let v2 = SymbolCreated<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolCreated<T1, T2>>(v2);
    }

    entry fun add_new_vault<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u64, arg4: u64, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        validate_vault_weight(arg2);
        assert!(!arg1.vaults_locked, 10004);
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::add<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::new_vault<T1>(arg2, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::create_reserving_fee_model(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg7), arg8), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::new_agg_price_config<T1>(arg3, arg4, arg5, arg6)));
        let v1 = VaultCreated<T1>{dummy_field: false};
        0x2::event::emit<VaultCreated<T1>>(v1);
    }

    entry fun add_new_vault_with_currency<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u64, arg4: u64, arg5: &0x2::coin_registry::Currency<T1>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        validate_vault_weight(arg2);
        assert!(!arg1.vaults_locked, 10004);
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::add<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::new_vault<T1>(arg2, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::create_reserving_fee_model(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg7), arg8), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::new_agg_price_config_from_currency<T1>(arg3, arg4, arg5, arg6)));
        let v1 = VaultCreated<T1>{dummy_field: false};
        0x2::event::emit<VaultCreated<T1>>(v1);
    }

    public fun admin_add_liquidity_to_vault<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 27)), 10001);
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        let (_, v2) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::admin_add_liquidity_to_vault<T1>(arg0, 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0), 0x2::coin::into_balance<T1>(arg2));
        let v3 = AdminLiquidityAdded<T1>{
            depositer       : 0x2::tx_context::sender(arg3),
            deposit_amount  : 0x2::coin::value<T1>(&arg2),
            after_liquidity : v2,
        };
        0x2::event::emit<AdminLiquidityAdded<T1>>(v3);
    }

    entry fun admin_empty_vault<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 29)), 10001);
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0);
        let v2 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_liquidity_amount<T1>(v1);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_reserved_amount<T1>(v1) == 0, 10035);
        if (v2 > 0) {
            let v3 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v1), arg2, arg3);
            let v4 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::coins_to_value(&v3, v2);
            let v5 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_u64(1);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v4, &v5), 10036);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_liquidity<T1>(v1)), arg4), 0x2::tx_context::sender(arg4));
        };
        let v6 = VaultEmptied<T1>{withdrawn_amount: v2};
        0x2::event::emit<VaultEmptied<T1>>(v6);
    }

    entry fun admin_remove_vault_from_bag<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 28)), 10001);
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::use_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::destroy_vault<T1>(0x2::bag::remove<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0)));
        let v1 = VaultRemoved<T1>{dummy_field: false};
        0x2::event::emit<VaultRemoved<T1>>(v1);
    }

    fun borrow_trading_price_config_for_feeder(arg0: &0x2::object::UID, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : &TradingFeederPriceConfigV1 {
        let v0 = TradingFeederKey{id: 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1)};
        0x2::dynamic_object_field::borrow<TradingFeederKey, TradingFeederPriceConfigV1>(arg0, v0)
    }

    public fun calculate_market_lp_price<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation, arg2: SymbolsValuation) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal {
        check_version<T0>(arg0);
        let (_, _, _, v3) = validate_market_valuation<T0>(arg0, arg1, arg2);
        let v4 = lp_supply_amount<T0>(arg0);
        if (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::is_zero(&v4)) {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero()
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::div(v3, v4)
        }
    }

    fun check_version<T0>(arg0: &Market<T0>) {
        assert!(arg0.version == 13, 10020);
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
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg0.positions, v1));
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
        pay_from_balance<T4>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::destroy_decrease_position_order<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::DecreasePositionOrder<T4>>(&mut arg0.orders, v4)), v0, arg2);
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
        let (v5, v6) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::destroy_open_position_order<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::OpenPositionOrder<T1, T4>>(&mut arg0.orders, v4));
        0x2::object::delete(v3);
        let v7 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v4};
        0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v7);
        pay_from_balance<T1>(v5, v0, arg2);
        pay_from_balance<T4>(v6, v0, arg2);
    }

    public(friend) fun create_market<T0>(arg0: 0x2::balance::Supply<T0>, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Market<T0>{
            id                 : 0x2::object::new(arg2),
            disabled_functions : 0x2::vec_set::empty<FunctionMask<T0>>(),
            vaults_locked      : false,
            symbols_locked     : false,
            referral_rate      : arg1,
            rebase_fee_model   : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::create_rebase_fee_model(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_permyriad(1), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(10000000000000000), arg2),
            referrals          : 0x2::table::new<address, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::Referral>(arg2),
            vaults             : 0x2::bag::new(arg2),
            symbols            : 0x2::bag::new(arg2),
            positions          : 0x2::bag::new(arg2),
            orders             : 0x2::bag::new(arg2),
            lp_supply          : arg0,
            version            : 13,
        };
        let v1 = MarketCreated{
            referrals_parent : 0x2::object::id<0x2::table::Table<address, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::Referral>>(&v0.referrals),
            vaults_parent    : 0x2::object::id<0x2::bag::Bag>(&v0.vaults),
            symbols_parent   : 0x2::object::id<0x2::bag::Bag>(&v0.symbols),
            positions_parent : 0x2::object::id<0x2::bag::Bag>(&v0.positions),
            orders_parent    : 0x2::object::id<0x2::bag::Bag>(&v0.orders),
            version          : v0.version,
        };
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<Market<T0>>(v0);
    }

    entry fun create_symbol_funding<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u256, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let (v0, v1) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::create_funding_state<T1>(arg5, arg2, arg3, arg4, arg6);
        0x2::dynamic_object_field::add<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingStateKey<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingState>(&mut arg1.id, v1, v0);
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
            value            : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::zero(),
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
            total_weight : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(),
            value        : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(),
        }
    }

    public entry fun decrease_position<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 6)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        decrease_position_common_v1<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x1::option::none<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>(), 0x1::option::none<0x2::object::ID>(), arg13);
    }

    fun decrease_position_common_v1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>, arg14: 0x1::option::Option<0x2::object::ID>, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 26)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        assert!(arg10 > 0, 10018);
        assert!(0x2::coin::value<T4>(&arg7) > 0, 10019);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<T4>(), 10031);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = update_symbol_oi_funding<T0, T2>(arg1, v0);
        let v2 = 0x2::tx_context::sender(arg15);
        let v3 = parse_direction<T3>();
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v2,
        };
        let v7 = if (exists_trading_price_config_for_feeder(&arg1.id, arg6)) {
            let v8 = borrow_trading_price_config_for_feeder(&arg1.id, arg6);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder_with_trading_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v5), arg6, v0, v8.max_interval, v8.max_confidence, v8.use_confidence_adjusted_price, v8.confidence_adjust_percentage, v3)
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v5), arg6, v0)
        };
        let v9 = v7;
        let v10 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg12);
        let (v11, v12) = get_referral_data(&arg1.referrals, v2);
        let v13 = if (v3) {
            let v14 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v9);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::lt(&v14, &v10)
        } else {
            let v15 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v9);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::gt(&v15, &v10)
        };
        if (v13 || !arg9) {
            assert!(arg8 < 2, 10007);
            let v16 = VaultName<T1>{dummy_field: false};
            let v17 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v16)), arg5, v0);
            let v18 = 0x2::coin::into_balance<T4>(arg7);
            let v19 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::coins_to_value(&v17, 0x2::balance::value<T4>(&v18));
            let v20 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::config_min_order_fee_value(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::position_config<T1>(0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v6)));
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::ge(&v19, &v20), 10032);
            let v21 = 0x2::object::new(arg15);
            let v22 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v21),
                owner       : v2,
                position_id : 0x1::option::some<0x2::object::ID>(v6.id),
            };
            let (v23, v24) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::new_decrease_position_order<T4>(v0, arg9, arg10, v10, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg11), v18, arg14, arg13, v12);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::DecreasePositionOrder<T4>>(&mut arg1.orders, v22, v23);
            let v25 = OrderCap<T1, T2, T3, T4>{
                id          : v21,
                position_id : v22.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v25, v2);
            let v26 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::CreateDecreasePositionOrderEvent>{
                order_name : v22,
                event      : v24,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::CreateDecreasePositionOrderEvent>>(v26);
        } else {
            assert!(arg8 > 0, 10008);
            let v27 = VaultName<T1>{dummy_field: false};
            let v28 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v27);
            let v29 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v28), arg5, v0);
            let v30 = 0x2::dynamic_object_field::borrow<u64, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig>(&arg1.id, 10001);
            let v31 = get_symbol_instant_exit_fee_config<T2, T3>(&arg1.id);
            let (v32, v33, v34, v35, v36) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::unwrap_decrease_position_result_v1<T1>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::decrease_position_v1_1<T1>(v28, v5, v30, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v6), arg3, arg4, &v29, &v9, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg11), v11, arg13, v3, arg10, lp_supply_amount<T0>(arg1), &v31, v0, v12, v1));
            let v37 = v35;
            pay_from_balance<T1>(v32, v2, arg15);
            pay_from_balance<T1>(v33, v12, arg15);
            let v38 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::get_fee_collector(v30);
            pay_from_balance<T1>(v34, v38, arg15);
            if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v37)) {
                if (0x1::option::is_some<0x2::object::ID>(&arg14)) {
                    let v39 = *0x1::option::borrow<0x2::object::ID>(&arg14);
                    pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v37), 0x2::object::id_to_address(&v39), arg15);
                } else {
                    pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v37), v38, arg15);
                };
            } else {
                0x1::option::destroy_none<0x2::balance::Balance<T1>>(v37);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg7, v2);
            let v40 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionSuccessEventV1>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
                event         : v36,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionSuccessEventV1>>(v40);
        };
    }

    public entry fun decrease_position_with_scard<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 7)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        assert!(arg10 > 0, 10018);
        assert!(0x2::coin::value<T4>(&arg7) > 0, 10019);
        decrease_position_common_v1<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x1::option::some<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::scard::calculate_card_rebate_rate(arg13)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard>(arg13)), arg14);
    }

    public entry fun decrease_reserved_from_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 8)), 10001);
        assert!(arg4 > 0, 10018);
        assert!(!arg1.vaults_locked, 10002);
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : 0x2::tx_context::sender(arg5),
        };
        let v2 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreaseReservedFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v1),
            event         : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::decrease_reserved_from_position<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0), 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v1), arg3, arg4, 0x2::clock::timestamp_ms(arg0) / 1000),
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreaseReservedFromPositionEvent>>(v2);
    }

    public fun deposit<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 1)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
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
        let (v16, v17) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::deposit<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg0.vaults, v15), arg1, &v14, 0x2::coin::into_balance<T1>(arg2), arg3, v3, v7, v13, v6, v5);
        pay_from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, v16), v0, arg6);
        let v18 = Deposited<T1>{
            minter         : v0,
            price          : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v14),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            mint_amount    : v16,
            fee_value      : v17,
            referrer       : v2,
        };
        0x2::event::emit<Deposited<T1>>(v18);
    }

    public fun deposit_ptb<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 24)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
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
        let (v16, v17) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::deposit<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg0.vaults, v15), arg1, &v14, 0x2::coin::into_balance<T1>(arg2), arg3, v3, v7, v13, v6, v5);
        let v18 = Deposited<T1>{
            minter         : v0,
            price          : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v14),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            mint_amount    : v16,
            fee_value      : v17,
            referrer       : v2,
        };
        0x2::event::emit<Deposited<T1>>(v18);
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, v16), arg6)
    }

    public entry fun execute_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 14)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = update_symbol_oi_funding<T0, T2>(arg1, v0);
        let v2 = 0x2::tx_context::sender(arg9);
        let v3 = parse_direction<T3>();
        let v4 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg8),
            owner : arg6,
        };
        let v5 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg7),
            owner       : arg6,
            position_id : 0x1::option::some<0x2::object::ID>(v4.id),
        };
        let v6 = 0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::DecreasePositionOrder<T4>>(&mut arg1.orders, v5);
        let v7 = VaultName<T1>{dummy_field: false};
        let v8 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v7);
        let v9 = SymbolName<T2, T3>{dummy_field: false};
        let v10 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v9);
        let v11 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v8), arg4, v0);
        let v12 = if (exists_trading_price_config_for_feeder(&arg1.id, arg5)) {
            let v13 = borrow_trading_price_config_for_feeder(&arg1.id, arg5);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder_with_trading_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v10), arg5, v0, v13.max_interval, v13.max_confidence, v13.use_confidence_adjusted_price, v13.confidence_adjust_percentage, v3)
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v10), arg5, v0)
        };
        let v14 = v12;
        let v15 = 0x2::dynamic_object_field::borrow<u64, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig>(&arg1.id, 10001);
        let (v16, v17) = get_referral_data(&arg1.referrals, arg6);
        let v18 = get_symbol_instant_exit_fee_config<T2, T3>(&arg1.id);
        let (v19, v20) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::execute_decrease_position_order_v1_1<T1, T4>(v6, v8, v10, v15, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v4), arg2, arg3, &v11, &v14, v16, v3, lp_supply_amount<T0>(arg1), &v18, v0, v1);
        let (v21, v22, v23, v24, v25) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::unwrap_decrease_position_result_v1<T1>(v19);
        let v26 = v24;
        let v27 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::get_fee_collector(v15);
        pay_from_balance<T1>(v21, arg6, arg9);
        pay_from_balance<T1>(v22, v17, arg9);
        pay_from_balance<T1>(v23, v27, arg9);
        if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v26)) {
            if (0x1::option::is_some<0x2::object::ID>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::get_scard_id_from_decrease_order<T4>(v6))) {
                let v28 = *0x1::option::borrow<0x2::object::ID>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::get_scard_id_from_decrease_order<T4>(v6));
                pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v26), 0x2::object::id_to_address(&v28), arg9);
            } else {
                pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v26), v27, arg9);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T1>>(v26);
        };
        let v29 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionSuccessEventV1>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v4),
            event         : v25,
        };
        let v30 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionSuccessEventV1>>{
            executor   : v2,
            order_name : v5,
            claim      : v29,
        };
        0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionSuccessEventV1>>>(v30);
        pay_from_balance<T4>(v20, v2, arg9);
    }

    public entry fun execute_open_position_order<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 15)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = update_symbol_oi_funding<T0, T2>(arg1, v0);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = parse_direction<T3>();
        let v4 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg7),
            owner       : arg6,
            position_id : 0x1::option::none<0x2::object::ID>(),
        };
        let v5 = 0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::OpenPositionOrder<T1, T4>>(&mut arg1.orders, v4);
        let v6 = VaultName<T1>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v6);
        let v8 = SymbolName<T2, T3>{dummy_field: false};
        let v9 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v8);
        let v10 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v7), arg4, v0);
        let v11 = if (exists_trading_price_config_for_feeder(&arg1.id, arg5)) {
            let v12 = borrow_trading_price_config_for_feeder(&arg1.id, arg5);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder_with_trading_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v9), arg5, v0, v12.max_interval, v12.max_confidence, v12.use_confidence_adjusted_price, v12.confidence_adjust_percentage, !v3)
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v9), arg5, v0)
        };
        let v13 = v11;
        let v14 = 0x2::dynamic_object_field::borrow<u64, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig>(&arg1.id, 10001);
        let (v15, v16) = get_referral_data(&arg1.referrals, arg6);
        let (v17, v18) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::execute_open_position_order_v1<T1, T4>(v5, v7, v9, v14, arg2, arg3, &v10, &v13, v15, v3, lp_supply_amount<T0>(arg1), v0, v1);
        let (v19, v20, v21, v22, v23) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::unwrap_open_position_result<T1>(v17);
        let v24 = v22;
        let v25 = 0x2::object::new(arg8);
        let v26 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v25),
            owner : arg6,
        };
        0x2::bag::add<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v26, v19);
        let v27 = PositionCap<T1, T2, T3>{id: v25};
        0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v27, arg6);
        let v28 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::get_fee_collector(v14);
        pay_from_balance<T1>(v20, v16, arg8);
        pay_from_balance<T1>(v21, v28, arg8);
        if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v24)) {
            if (0x1::option::is_some<0x2::object::ID>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::get_scard_id_from_open_order<T1, T4>(v5))) {
                let v29 = *0x1::option::borrow<0x2::object::ID>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::get_scard_id_from_open_order<T1, T4>(v5));
                pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v24), 0x2::object::id_to_address(&v29), arg8);
            } else {
                pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v24), v28, arg8);
            };
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T1>>(v24);
        };
        let v30 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionSuccessEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v26),
            event         : v23,
        };
        let v31 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionSuccessEvent>>{
            executor   : v2,
            order_name : v4,
            claim      : v30,
        };
        0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionSuccessEvent>>>(v31);
        pay_from_balance<T4>(v18, v2, arg8);
    }

    fun exists_trading_price_config_for_feeder(arg0: &0x2::object::UID, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : bool {
        let v0 = TradingFeederKey{id: 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1)};
        0x2::dynamic_object_field::exists_<TradingFeederKey>(arg0, v0)
    }

    fun finalize_market_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation, arg2: SymbolsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal) {
        check_version<T0>(arg0);
        let (v0, v1, v2) = finalize_vaults_valuation<T0>(arg0, arg1);
        let v3 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::add_with_decimal(finalize_symbols_valuation<T0>(arg0, arg2), v2);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::is_positive(&v3), 10013);
        (v0, v1, v2, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::value(&v3))
    }

    fun finalize_symbols_valuation<T0>(arg0: &mut Market<T0>, arg1: SymbolsValuation) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::SDecimal {
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

    fun finalize_vaults_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal) {
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

    entry fun force_clear_closed_position<T0, T1, T2, T3>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: address, arg3: address, arg4: &0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg2),
            owner : arg3,
        };
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v0));
        let v1 = ForcePositionCleared<T1, T2, T3>{position_name: v0};
        0x2::event::emit<ForcePositionCleared<T1, T2, T3>>(v1);
    }

    entry fun force_clear_executed_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: address, arg3: address, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
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
            pay_from_balance<T4>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::destroy_decrease_position_order<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::DecreasePositionOrder<T4>>(&mut arg1.orders, v1)), arg2, arg5);
            let v2 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v1};
            0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v2);
        };
    }

    entry fun force_clear_executed_open_position_order<T0, T1, T2, T3, T4>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 22)), 10001);
        check_version<T0>(arg1);
        let v0 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg3),
            owner       : arg2,
            position_id : 0x1::option::none<0x2::object::ID>(),
        };
        if (0x2::bag::contains<OrderName<T1, T2, T3, T4>>(&arg1.orders, v0)) {
            let (v1, v2) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::destroy_open_position_order<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::OpenPositionOrder<T1, T4>>(&mut arg1.orders, v0));
            pay_from_balance<T1>(v1, arg2, arg4);
            pay_from_balance<T4>(v2, arg2, arg4);
            let v3 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v0};
            0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v3);
        };
    }

    entry fun force_close_position<T0, T1, T2, T3>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Market<T0>, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.vaults_locked && !arg2.symbols_locked, 10002);
        check_version<T0>(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = parse_direction<T3>();
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg2.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg2.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg8),
            owner : arg7,
        };
        let v7 = 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg2.positions, v6);
        let v8 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::position_amount<T1>(v7);
        let v9 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v3), arg5, v0);
        let v10 = if (exists_trading_price_config_for_feeder(&arg2.id, arg6)) {
            let v11 = borrow_trading_price_config_for_feeder(&arg2.id, arg6);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder_with_trading_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v5), arg6, v0, v11.max_interval, v11.max_confidence, v11.use_confidence_adjusted_price, v11.confidence_adjust_percentage, v1)
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v5), arg6, v0)
        };
        let v12 = v10;
        let v13 = 0x2::dynamic_object_field::borrow<u64, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig>(&arg2.id, 10001);
        let (v14, v15) = get_referral_data(&arg2.referrals, arg7);
        let (v16, v17, v18, v19, v20) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::unwrap_decrease_position_result<T1>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::decrease_position<T1>(v3, v5, v13, v7, arg3, arg4, &v9, &v12, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(), v14, 0x1::option::none<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>(), v1, v8, lp_supply_amount<T0>(arg2), v0, v15));
        0x1::option::destroy_none<0x2::balance::Balance<T1>>(v19);
        pay_from_balance<T1>(v16, arg7, arg9);
        pay_from_balance<T1>(v17, v15, arg9);
        pay_from_balance<T1>(v18, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::get_fee_collector(v13), arg9);
        let v21 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionSuccessEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v20,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::DecreasePositionSuccessEvent>>(v21);
    }

    entry fun force_settle_position<T0, T1, T2, T3>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Market<T0>, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.vaults_locked && !arg2.symbols_locked, 10002);
        check_version<T0>(arg2);
        let v0 = VaultName<T1>{dummy_field: false};
        let v1 = SymbolName<T2, T3>{dummy_field: false};
        let v2 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg4),
            owner : arg3,
        };
        pay_from_balance<T1>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::force_settle_position<T1>(arg0, 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg2.vaults, v0), 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg2.symbols, v1), 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg2.positions, v2)), arg3, arg5);
        let v3 = ForcePositionSettled<T1, T2, T3>{
            position_name : v2,
            timestamp     : 0x2::clock::timestamp_ms(arg1) / 1000,
        };
        0x2::event::emit<ForcePositionSettled<T1, T2, T3>>(v3);
    }

    fun get_referral_data(arg0: &0x2::table::Table<address, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::Referral>, arg1: address) : (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate, address) {
        if (0x2::table::contains<address, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::Referral>(arg0, arg1)) {
            let v2 = 0x2::table::borrow<address, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::Referral>(arg0, arg1);
            (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::get_rebate_rate(v2), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::referral::get_referrer(v2))
        } else {
            (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::zero(), @0x0)
        }
    }

    fun get_symbol_instant_exit_fee_config<T0, T1>(arg0: &0x2::object::UID) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::PositionInstantExitFeeConfig {
        let v0 = SymbolName<T0, T1>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<SymbolName<T0, T1>>(arg0, v0)) {
            0x2::dynamic_object_field::borrow<SymbolName<T0, T1>, SymbolConfig>(arg0, v0).instant_exit_fee_config
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::default_position_instant_exit_fee_config()
        }
    }

    public fun position<T0, T1, T2, T3>(arg0: &Market<T0>, arg1: 0x2::object::ID, arg2: address) : &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1> {
        let v0 = PositionName<T1, T2, T3>{
            id    : arg1,
            owner : arg2,
        };
        0x2::bag::borrow<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&arg0.positions, v0)
    }

    public fun has_symbol<T0, T1, T2>(arg0: &Market<T0>) : bool {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::contains<SymbolName<T1, T2>>(&arg0.symbols, v0)
    }

    public fun has_vault<T0, T1>(arg0: &Market<T0>) : bool {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::contains<VaultName<T1>>(&arg0.vaults, v0)
    }

    entry fun init_symbol_config<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<SymbolName<T1, T2>>(&arg1.id, v0)) {
            let v1 = SymbolConfig{
                id                                    : 0x2::object::new(arg2),
                max_opening_size                      : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(),
                max_opening_size_enabled              : false,
                max_opening_size_per_position         : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(),
                max_opening_size_per_position_enabled : false,
                instant_exit_fee_config               : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::default_position_instant_exit_fee_config(),
            };
            0x2::dynamic_object_field::add<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0, v1);
        };
    }

    fun is_function_disabled<T0>(arg0: &Market<T0>, arg1: FunctionMask<T0>) : bool {
        0x2::vec_set::contains<FunctionMask<T0>>(&arg0.disabled_functions, &arg1)
    }

    public entry fun liquidate_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 11)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = update_symbol_oi_funding<T0, T2>(arg1, v0);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = parse_direction<T3>();
        let v4 = VaultName<T1>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v4);
        let v6 = SymbolName<T2, T3>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v6);
        let v8 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg7),
            owner : arg6,
        };
        let v9 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v5), arg4, v0);
        let v10 = if (exists_trading_price_config_for_feeder(&arg1.id, arg5)) {
            let v11 = borrow_trading_price_config_for_feeder(&arg1.id, arg5);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder_with_trading_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v7), arg5, v0, v11.max_interval, v11.max_confidence, v11.use_confidence_adjusted_price, v11.confidence_adjust_percentage, v3)
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v7), arg5, v0)
        };
        let v12 = v10;
        let (v13, v14) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::liquidate_position_v1<T1>(v5, v7, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v8), arg2, arg3, &v9, &v12, v3, lp_supply_amount<T0>(arg1), v0, v2, v1);
        pay_from_balance<T1>(v13, v2, arg8);
        let v15 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::LiquidatePositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v8),
            event         : v14,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::LiquidatePositionEvent>>(v15);
    }

    public fun lp_supply_amount<T0>(arg0: &Market<T0>) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::div_by_u64(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_u64(0x2::balance::supply_value<T0>(&arg0.lp_supply)), 1000000)
    }

    entry fun migrate_version<T0>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>) {
        assert!(arg1.version < 13, 10021);
        arg1.version = 13;
    }

    fun new_function_mask<T0>(arg0: &Market<T0>, arg1: u8) : FunctionMask<T0> {
        FunctionMask<T0>{name: arg1}
    }

    public entry fun open_position<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 4)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        open_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::option::none<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>(), 0x1::option::none<0x2::object::ID>(), arg14);
    }

    fun open_position_common<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: 0x1::option::Option<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>, arg15: 0x1::option::Option<0x2::object::ID>, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 4)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        assert!(arg10 > 0, 10016);
        assert!(0x2::coin::value<T1>(&arg7) > 0, 10017);
        assert!(0x2::coin::value<T4>(&arg8) > 0, 10019);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<T4>(), 10031);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = update_symbol_oi_funding<T0, T2>(arg1, v0);
        let v2 = 0x2::tx_context::sender(arg16);
        let v3 = parse_direction<T3>();
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v4);
        let (v6, v7, v8, v9) = if (0x2::dynamic_object_field::exists_<SymbolName<T2, T3>>(&arg1.id, v4)) {
            let v10 = 0x2::dynamic_object_field::borrow<SymbolName<T2, T3>, SymbolConfig>(&arg1.id, v4);
            (v10.max_opening_size, v10.max_opening_size_enabled, v10.max_opening_size_per_position, v10.max_opening_size_per_position_enabled)
        } else {
            (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(), false, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(), false)
        };
        let v11 = v8;
        let v12 = v6;
        let v13 = if (exists_trading_price_config_for_feeder(&arg1.id, arg6)) {
            let v14 = borrow_trading_price_config_for_feeder(&arg1.id, arg6);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder_with_trading_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v5), arg6, v0, v14.max_interval, v14.max_confidence, v14.use_confidence_adjusted_price, v14.confidence_adjust_percentage, !v3)
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v5), arg6, v0)
        };
        let v15 = v13;
        let v16 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg13);
        let (v17, v18) = get_referral_data(&arg1.referrals, v2);
        let v19 = if (v7) {
            let v20 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero();
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::gt(&v12, &v20)
        } else {
            false
        };
        if (v19) {
            let v21 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::add(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_opening_size(v5), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::coins_to_value(&v15, arg10));
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v21, &v12), 10033);
        };
        let v22 = if (v9) {
            let v23 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero();
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::gt(&v11, &v23)
        } else {
            false
        };
        if (v22) {
            let v24 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::coins_to_value(&v15, arg10);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v24, &v11), 10034);
        };
        let v25 = if (v3) {
            let v26 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v15);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::gt(&v26, &v16)
        } else {
            let v27 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v15);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::lt(&v27, &v16)
        };
        if (v25) {
            assert!(arg9 < 2, 10007);
            let v28 = VaultName<T1>{dummy_field: false};
            let v29 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v28)), arg5, v0);
            let v30 = 0x2::coin::into_balance<T4>(arg8);
            let v31 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::coins_to_value(&v29, 0x2::balance::value<T4>(&v30));
            let v32 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::config_min_order_fee_value(&arg4.inner);
            assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::ge(&v31, &v32), 10032);
            let v33 = 0x2::object::new(arg16);
            let v34 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v33),
                owner       : v2,
                position_id : 0x1::option::none<0x2::object::ID>(),
            };
            let (v35, v36) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::new_open_position_order<T1, T4>(v0, arg10, arg11, v16, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg12), arg4.inner, 0x2::coin::into_balance<T1>(arg7), v30, arg15, arg14, v18);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::OpenPositionOrder<T1, T4>>(&mut arg1.orders, v34, v35);
            let v37 = OrderCap<T1, T2, T3, T4>{
                id          : v33,
                position_id : v34.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v37, v2);
            let v38 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::CreateOpenPositionOrderEvent>{
                order_name : v34,
                event      : v36,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::orders::CreateOpenPositionOrderEvent>>(v38);
        } else {
            assert!(arg9 > 0, 10008);
            let v39 = VaultName<T1>{dummy_field: false};
            let v40 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v39);
            let v41 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v40), arg5, v0);
            let v42 = 0x2::dynamic_object_field::borrow<u64, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig>(&arg1.id, 10001);
            let v43 = 0x2::object::new(arg16);
            let v44 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v43),
                owner : v2,
            };
            let v45 = 0x2::coin::into_balance<T1>(arg7);
            0x2::balance::destroy_zero<T1>(v45);
            let (v46, v47, v48, v49, v50) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::unwrap_open_position_result<T1>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::open_position_v1<T1>(v40, v5, v42, arg2, arg3, &arg4.inner, &v41, &v15, &mut v45, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg12), v17, arg14, v3, arg10, arg11, lp_supply_amount<T0>(arg1), v0, v18, v1));
            let v51 = v49;
            0x2::bag::add<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v44, v46);
            let v52 = PositionCap<T1, T2, T3>{id: v43};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v52, v2);
            pay_from_balance<T1>(v47, v18, arg16);
            let v53 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::get_fee_collector(v42);
            pay_from_balance<T1>(v48, v53, arg16);
            if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v51)) {
                if (0x1::option::is_some<0x2::object::ID>(&arg15)) {
                    let v54 = *0x1::option::borrow<0x2::object::ID>(&arg15);
                    pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v51), 0x2::object::id_to_address(&v54), arg16);
                } else {
                    pay_from_balance<T1>(0x1::option::destroy_some<0x2::balance::Balance<T1>>(v51), v53, arg16);
                };
            } else {
                0x1::option::destroy_none<0x2::balance::Balance<T1>>(v51);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, v2);
            let v55 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v44),
                event         : v50,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::OpenPositionSuccessEvent>>(v55);
        };
    }

    public entry fun open_position_with_scard<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 5)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        assert!(arg10 > 0, 10016);
        assert!(0x2::coin::value<T1>(&arg7) > 0, 10017);
        assert!(0x2::coin::value<T4>(&arg8) > 0, 10019);
        open_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::option::some<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::Rate>(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::scard::calculate_card_rebate_rate(arg14)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard>(arg14)), arg15);
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
        let v1 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::PledgeInPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v0),
            event         : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::pledge_in_position<T1>(0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg0.positions, v0), 0x2::coin::into_balance<T1>(arg2)),
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::PledgeInPositionEvent>>(v1);
    }

    public fun rebase_fee_model<T0>(arg0: &Market<T0>) : &0x2::object::ID {
        &arg0.rebase_fee_model
    }

    public entry fun redeem_from_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg1, new_function_mask<T0>(arg1, 10)), 10001);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 10002);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = update_symbol_oi_funding<T0, T2>(arg1, v0);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = parse_direction<T3>();
        let v4 = VaultName<T1>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v4);
        let v6 = SymbolName<T2, T3>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v6);
        let v8 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v2,
        };
        let v9 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v5), arg5, v0);
        let v10 = if (exists_trading_price_config_for_feeder(&arg1.id, arg6)) {
            let v11 = borrow_trading_price_config_for_feeder(&arg1.id, arg6);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder_with_trading_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v7), arg6, v0, v11.max_interval, v11.max_confidence, v11.use_confidence_adjusted_price, v11.confidence_adjust_percentage, v3)
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v7), arg6, v0)
        };
        let v12 = v10;
        let (v13, v14) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::redeem_from_position_v1<T1>(v5, v7, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::Position<T1>>(&mut arg1.positions, v8), arg3, arg4, &v9, &v12, v3, arg7, lp_supply_amount<T0>(arg1), v0, v1);
        pay_from_balance<T1>(v13, v2, arg8);
        let v15 = PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::RedeemFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v8),
            event         : v14,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::RedeemFromPositionEvent>>(v15);
    }

    entry fun remove_collateral_from_symbol<T0, T1, T2, T3>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T2, T3>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::remove_collateral_from_symbol<T1>(0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v0));
        let v1 = CollateralRemoved<T1, T2, T3>{dummy_field: false};
        0x2::event::emit<CollateralRemoved<T1, T2, T3>>(v1);
    }

    entry fun remove_symbol_from_bag<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::use_price_config(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::destroy_symbol(0x2::bag::remove<SymbolName<T1, T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v0)));
        let v1 = SymbolRemoved<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolRemoved<T1, T2>>(v1);
    }

    public fun remove_trading_price_config_for_feeder<T0>(arg0: &mut Market<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : TradingFeederPriceConfig {
        abort 0
    }

    public fun remove_trading_price_config_for_feeder_v1<T0>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : TradingFeederPriceConfigV1 {
        check_version<T0>(arg1);
        let v0 = TradingFeederKey{id: 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2)};
        0x2::dynamic_object_field::remove<TradingFeederKey, TradingFeederPriceConfigV1>(&mut arg1.id, v0)
    }

    entry fun replace_position_config<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut WrappedPositionConfig<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u256, arg6: u256, arg7: u128, arg8: u128, arg9: u128, arg10: u128) {
        validate_fee_bps((arg7 as u256));
        validate_fee_bps((arg8 as u256));
        validate_liquidation_params((arg9 as u256), (arg10 as u256));
        validate_leverage(arg2);
        validate_holding_duration(arg3);
        arg1.inner = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::new_position_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
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

    entry fun replace_symbol_feeder<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::update_agg_price_config_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::mut_symbol_price_config(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v0)), arg2);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        let v2 = SymbolFeederUpdated<T1, T2>{
            symbol_name : v1,
            feeder      : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::uid_to_inner(arg2),
        };
        0x2::event::emit<SymbolFeederUpdated<T1, T2>>(v2);
    }

    entry fun replace_vault_feeder<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::update_agg_price_config_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::mut_vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0)), arg2);
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = VaultFeederUpdated<T1>{
            vault_name : v1,
            feeder     : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::uid_to_inner(arg2),
        };
        0x2::event::emit<VaultFeederUpdated<T1>>(v2);
    }

    entry fun replace_vault_weight<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256) {
        check_version<T0>(arg1);
        validate_vault_weight(arg2);
        let v0 = VaultName<T1>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::set_vault_weight<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0), arg2);
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = VaultWeightUpdated<T1>{
            vault_name : v1,
            weight     : arg2,
        };
        0x2::event::emit<VaultWeightUpdated<T1>>(v2);
    }

    entry fun set_fee_config<T0>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_percent(arg2);
        validate_config_fee_rate((0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::to_raw(v0) as u256));
        if (0x2::dynamic_object_field::exists_<u64>(&arg1.id, 10001)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<u64, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig>(&mut arg1.id, 10001);
            if (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::to_raw(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::get_fee_rate(v1)) != 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::to_raw(v0) || 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::get_fee_collector(v1) != arg3) {
                0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::set_fee_config_rate(v1, v0, arg3);
                let v2 = FeeConfigUpdated<T0>{
                    fee_rate_percent : arg2,
                    fee_collector    : arg3,
                };
                0x2::event::emit<FeeConfigUpdated<T0>>(v2);
            };
        } else {
            0x2::dynamic_object_field::add<u64, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::FeeConfig>(&mut arg1.id, 10001, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::fee::new_fee_config(v0, arg3, arg4));
            let v3 = FeeConfigUpdated<T0>{
                fee_rate_percent : arg2,
                fee_collector    : arg3,
            };
            0x2::event::emit<FeeConfigUpdated<T0>>(v3);
        };
    }

    entry fun set_function_status<T0>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u8, arg3: bool) {
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

    entry fun set_referral_rate<T0>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        validate_referral_rate((arg2 as u256));
        arg1.referral_rate = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg2);
        let v0 = ReferralRateUpdated{referral_rate: arg1.referral_rate};
        0x2::event::emit<ReferralRateUpdated>(v0);
    }

    entry fun set_symbol_funding_enabled<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: bool) {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::set_funding_state_enabled(0x2::dynamic_object_field::borrow_mut<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingStateKey<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingState>(&mut arg1.id, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::new_funding_state_key<T1>()), arg2);
    }

    entry fun set_symbol_instant_exit_fee_config<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: bool, arg4: u128, arg5: u64, arg6: bool, arg7: u128, arg8: u64, arg9: bool, arg10: u128, arg11: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<SymbolName<T1, T2>>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0);
            v1.instant_exit_fee_config = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::set_position_instant_exit_fee_config(&mut v1.instant_exit_fee_config, arg2, arg3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg4), arg5, arg6, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg7), arg8, arg9, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg10));
        } else {
            let v2 = SymbolConfig{
                id                                    : 0x2::object::new(arg11),
                max_opening_size                      : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(),
                max_opening_size_enabled              : false,
                max_opening_size_per_position         : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(),
                max_opening_size_per_position_enabled : false,
                instant_exit_fee_config               : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::new_position_instant_exit_fee_config(arg2, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg4), arg3, arg5, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg7), arg6, arg8, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::rate::from_raw(arg10), arg9),
            };
            0x2::dynamic_object_field::add<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0, v2);
        };
    }

    entry fun set_symbol_max_opening_size<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<SymbolName<T1, T2>>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0);
            v1.max_opening_size = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg2);
            v1.max_opening_size_enabled = arg3;
        } else {
            let v2 = SymbolConfig{
                id                                    : 0x2::object::new(arg4),
                max_opening_size                      : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg2),
                max_opening_size_enabled              : arg3,
                max_opening_size_per_position         : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(),
                max_opening_size_per_position_enabled : false,
                instant_exit_fee_config               : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::default_position_instant_exit_fee_config(),
            };
            0x2::dynamic_object_field::add<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0, v2);
        };
    }

    entry fun set_symbol_max_opening_size_per_position<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<SymbolName<T1, T2>>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0);
            v1.max_opening_size_per_position = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg2);
            v1.max_opening_size_per_position_enabled = arg3;
        } else {
            let v2 = SymbolConfig{
                id                                    : 0x2::object::new(arg4),
                max_opening_size                      : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::zero(),
                max_opening_size_enabled              : false,
                max_opening_size_per_position         : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg2),
                max_opening_size_per_position_enabled : arg3,
                instant_exit_fee_config               : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::position::default_position_instant_exit_fee_config(),
            };
            0x2::dynamic_object_field::add<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0, v2);
        };
    }

    entry fun set_symbol_status<T0, T1, T2>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: bool, arg3: bool, arg4: bool) {
        check_version<T0>(arg1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::set_symbol_status(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg1.symbols, v0), arg2, arg3, arg4);
        let v1 = SymbolStatusUpdated<T1, T2>{
            open_enabled      : arg2,
            decrease_enabled  : arg3,
            liquidate_enabled : arg4,
        };
        0x2::event::emit<SymbolStatusUpdated<T1, T2>>(v1);
    }

    entry fun set_trading_price_config_for_feeder<T0>(arg0: &mut Market<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: u64, arg4: bool, arg5: u256, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    entry fun set_trading_price_config_for_feeder_v1<T0>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u64, arg5: bool, arg6: u256, arg7: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = TradingFeederKey{id: 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2)};
        let v1 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_raw(arg6);
        let v2 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::from_u64(1);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::le(&v1, &v2), 10037);
        if (0x2::dynamic_object_field::exists_<TradingFeederKey>(&arg1.id, v0)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<TradingFeederKey, TradingFeederPriceConfigV1>(&mut arg1.id, v0);
            v3.max_interval = arg3;
            v3.max_confidence = arg4;
            v3.use_confidence_adjusted_price = arg5;
            v3.confidence_adjust_percentage = v1;
        } else {
            let v4 = TradingFeederPriceConfigV1{
                id                            : 0x2::object::new(arg7),
                max_interval                  : arg3,
                max_confidence                : arg4,
                use_confidence_adjusted_price : arg5,
                confidence_adjust_percentage  : v1,
            };
            0x2::dynamic_object_field::add<TradingFeederKey, TradingFeederPriceConfigV1>(&mut arg1.id, v0, v4);
        };
    }

    entry fun set_vault_status<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: bool) {
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::set_vault_status<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg1.vaults, v0), arg2);
        let v1 = VaultStatusUpdated{enabled: arg2};
        0x2::event::emit<VaultStatusUpdated>(v1);
    }

    public fun symbol<T0, T1, T2>(arg0: &Market<T0>) : &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::borrow<SymbolName<T1, T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&arg0.symbols, v0)
    }

    entry fun update_symbol_funding_params<T0, T1>(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u256, arg4: u128) {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::update_funding_model_params(0x2::dynamic_object_field::borrow_mut<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingStateKey<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingState>(&mut arg1.id, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::new_funding_state_key<T1>()), arg2, arg3, arg4);
    }

    fun update_symbol_oi_funding<T0, T1>(arg0: &mut Market<T0>, arg1: u64) : bool {
        let v0 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::new_funding_state_key<T1>();
        if (0x2::dynamic_object_field::exists_<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingStateKey<T1>>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingStateKey<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::FundingState>(&mut arg0.id, v0);
            if (0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::is_enabled(v1)) {
                let v2 = SymbolName<T1, LONG>{dummy_field: false};
                let v3 = SymbolName<T1, SHORT>{dummy_field: false};
                let v4 = 0x2::bag::borrow<SymbolName<T1, LONG>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&arg0.symbols, v2);
                let v5 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_unrealised_funding_fee_value(v4, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::zero());
                0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_last_update(v4);
                let v6 = 0x2::bag::borrow<SymbolName<T1, SHORT>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&arg0.symbols, v3);
                0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_last_update(v6);
                let v7 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::compute_oi_funding(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_opening_size(v4), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_acc_funding_rate(v4, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::zero()), v5, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_opening_size(v6), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_acc_funding_rate(v6, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::zero()), 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_unrealised_funding_fee_value(v6, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::srate::zero()), v1, arg1);
                0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::refresh_symbol_oi_funding(v7, 0x2::bag::borrow_mut<SymbolName<T1, LONG>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg0.symbols, v2), true);
                0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::refresh_symbol_oi_funding(v7, 0x2::bag::borrow_mut<SymbolName<T1, SHORT>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg0.symbols, v3), false);
                0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::set_funding_state_last_update(v1, arg1);
                return true
            };
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::funding::set_funding_state_last_update(v1, arg1);
        };
        false
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

    public fun validate_market_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation, arg2: SymbolsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal) {
        check_version<T0>(arg0);
        let (v0, v1, v2) = finalize_vaults_valuation<T0>(arg0, arg1);
        let v3 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::add_with_decimal(finalize_symbols_valuation<T0>(arg0, arg2), v2);
        assert!(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::is_positive(&v3), 10013);
        (v0, v1, v2, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::value(&v3))
    }

    fun validate_referral_rate(arg0: u256) {
        assert!(arg0 >= 10000000000000000 && arg0 <= 250000000000000000, 10030);
    }

    fun validate_vault_weight(arg0: u256) {
        assert!(arg0 >= 10000000000000000 && arg0 <= 1000000000000000000, 10022);
    }

    public fun valuate_symbol<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut SymbolsValuation) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 20)), 10001);
        check_version<T0>(arg0);
        let v0 = arg3.timestamp;
        let v1 = update_symbol_oi_funding<T0, T1>(arg0, v0);
        let v2 = SymbolName<T1, T2>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Symbol>(&mut arg0.symbols, v2);
        let v4 = 0x1::type_name::get<SymbolName<T1, T2>>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.handled, &v4), 10010);
        let v5 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::symbol_price_config(v3), arg2, v0);
        let v6 = if (v1) {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::valuate_symbol_after_oi_funding_update(v3, &v5, parse_direction<T2>())
        } else {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::valuate_symbol(v3, arg1, &v5, parse_direction<T2>(), arg3.lp_supply_amount, v0)
        };
        arg3.value = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::sdecimal::add(arg3.value, v6);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg3.handled, v4);
    }

    public fun valuate_vault<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut VaultsValuation) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 19)), 10001);
        check_version<T0>(arg0);
        let v0 = arg3.timestamp;
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg0.vaults, v1);
        let v3 = 0x1::type_name::get<VaultName<T1>>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, VaultInfo>(&arg3.handled, &v3), 10009);
        let v4 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::parse_pyth_feeder(0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_price_config<T1>(v2), arg2, v0);
        let v5 = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::valuate_vault<T1>(v2, arg1, &v4, v0);
        arg3.value = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::add(arg3.value, v5);
        arg3.total_weight = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::add(arg3.total_weight, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::vault_weight<T1>(v2));
        let v6 = VaultInfo{
            price : v4,
            value : v5,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, VaultInfo>(&mut arg3.handled, v3, v6);
    }

    public fun vault<T0, T1>(arg0: &Market<T0>) : &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1> {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::borrow<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&arg0.vaults, v0)
    }

    public fun withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 2)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
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
        let (v15, v16) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::withdraw<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg0.vaults, v13), arg1, &v12, v14, arg3, v1, v5, v11, v4, v3);
        let v17 = v15;
        pay_from_balance<T1>(v17, v0, arg6);
        let v18 = Withdrawn<T1>{
            burner          : v0,
            price           : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v12),
            withdraw_amount : 0x2::balance::value<T1>(&v17),
            burn_amount     : v14,
            fee_value       : v16,
        };
        0x2::event::emit<Withdrawn<T1>>(v18);
    }

    public fun withdraw_ptb<T0, T1>(arg0: &mut Market<T0>, arg1: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!is_function_disabled<T0>(arg0, new_function_mask<T0>(arg0, 25)), 10001);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 10014);
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
        let (v14, v15) = 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::withdraw<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::pool::Vault<T1>>(&mut arg0.vaults, v12), arg1, &v11, v13, arg3, v0, v4, v10, v3, v2);
        let v16 = v14;
        let v17 = Withdrawn<T1>{
            burner          : 0x2::tx_context::sender(arg6),
            price           : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::price_of(&v11),
            withdraw_amount : 0x2::balance::value<T1>(&v16),
            burn_amount     : v13,
            fee_value       : v15,
        };
        0x2::event::emit<Withdrawn<T1>>(v17);
        0x2::coin::from_balance<T1>(v16, arg6)
    }

    // decompiled from Move bytecode v6
}

