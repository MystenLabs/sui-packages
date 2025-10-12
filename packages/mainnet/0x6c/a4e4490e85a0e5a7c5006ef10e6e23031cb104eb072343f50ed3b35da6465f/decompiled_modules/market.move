module 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        fun_mask: u256,
        vaults_locked: bool,
        symbols_locked: bool,
        rebate_rate: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        rebase_fee_model: 0x2::object::ID,
        referrals: 0x2::table::Table<address, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::Referral>,
        vaults: 0x2::bag::Bag,
        symbols: 0x2::bag::Bag,
        positions: 0x2::bag::Bag,
        orders: 0x2::bag::Bag,
        lp_supply: 0x2::balance::Supply<T0>,
    }

    struct SymbolConfig has store, key {
        id: 0x2::object::UID,
        max_opening_size: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        max_opening_size_enabled: bool,
        max_opening_size_per_position: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        max_opening_size_per_position_enabled: bool,
        instant_exit_fee_config: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionInstantExitFeeConfig,
    }

    struct WrappedPositionConfig<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        enabled: bool,
        inner: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionConfig,
    }

    struct PositionCap<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
    }

    struct OrderCap<phantom T0, phantom T1, phantom T2, phantom T3> has key {
        id: 0x2::object::UID,
        position_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct MarketVersion has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct OrderConfig has store, key {
        id: 0x2::object::UID,
        min_fee: u64,
        min_collateral_value: u64,
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
    }

    struct MarketFunMaskUpdated has copy, drop {
        fun_mask: u256,
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

    struct VaultRemoved<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct VaultEmptied<phantom T0> has copy, drop {
        withdrawn_amount: u64,
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

    struct VaultStatusUpdated<phantom T0> has copy, drop {
        enabled: bool,
    }

    struct VaultWeightUpdated<phantom T0> has copy, drop {
        weight: u256,
    }

    struct FeeConfigUpdated<phantom T0> has copy, drop {
        fee_rate_percent: u8,
        fee_collector: address,
    }

    struct MarketVersionUpdated<phantom T0> has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct OrderConfigUpdated<phantom T0> has copy, drop {
        min_fee: u64,
        min_collateral_value: u64,
    }

    struct PositionConfigReplaced<phantom T0, phantom T1> has copy, drop {
        max_leverage: u64,
        min_holding_duration: u64,
        max_reserved_multiplier: u64,
        min_collateral_value: u256,
        open_fee_bps: u128,
        decrease_fee_bps: u128,
        liquidation_threshold: u128,
        liquidation_bonus: u128,
    }

    struct PositionClaimed<T0: copy + drop, T1: copy + drop> has copy, drop {
        position_name: 0x1::option::Option<T0>,
        event: T1,
    }

    struct Deposited<phantom T0> has copy, drop {
        minter: address,
        price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        deposit_amount: u64,
        mint_amount: u64,
        fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
    }

    struct AdminLiquidityAdded<phantom T0> has copy, drop {
        depositer: address,
        deposit_amount: u64,
        after_liquidity: u64,
    }

    struct Withdrawn<phantom T0> has copy, drop {
        burner: address,
        price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        withdraw_amount: u64,
        burn_amount: u64,
        fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
    }

    struct Swapped<phantom T0, phantom T1> has copy, drop {
        swapper: address,
        source_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        dest_price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        source_amount: u64,
        dest_amount: u64,
        fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
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
        price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice,
        value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
    }

    struct VaultsValuation {
        timestamp: u64,
        num: u64,
        handled: 0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>,
        total_weight: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
    }

    struct SymbolsValuation {
        timestamp: u64,
        num: u64,
        lp_supply_amount: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        handled: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal,
    }

    public fun swap<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 16384 == 0, 1);
        check_version<T0>(arg0);
        assert!(0x2::object::id<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 12);
        assert!(0x1::type_name::get<T1>() != 0x1::type_name::get<T2>(), 13);
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
        let (v18, v19) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::swap_in<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg0.vaults, v17), arg1, &v10, 0x2::coin::into_balance<T1>(arg2), v9, v3, v2);
        let v20 = VaultName<T2>{dummy_field: false};
        let (v21, v22) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::swap_out<T2>(0x2::bag::borrow_mut<VaultName<T2>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T2>>(&mut arg0.vaults, v20), arg1, &v16, arg3, v18, v15, v3, v2);
        let v23 = v21;
        pay_from_balance<T2>(v23, v0, arg5);
        let v24 = Swapped<T1, T2>{
            swapper       : v0,
            source_price  : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&v10),
            dest_price    : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&v16),
            source_amount : 0x2::coin::value<T1>(&arg2),
            dest_amount   : 0x2::balance::value<T2>(&v23),
            fee_value     : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(v19, v22),
        };
        0x2::event::emit<Swapped<T1, T2>>(v24);
    }

    public entry fun add_collateral_to_symbol<T0, T1, T2, T3>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SymbolName<T2, T3>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::add_collateral_to_symbol<T1>(0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v0));
        let v1 = CollateralAdded<T1, T2, T3>{dummy_field: false};
        0x2::event::emit<CollateralAdded<T1, T2, T3>>(v1);
    }

    public entry fun add_new_referral<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 1 == 0, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::Referral>(&arg0.referrals, v0), 3);
        0x2::table::add<address, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::Referral>(&mut arg0.referrals, v0, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::new_referral(arg1, arg0.rebate_rate));
    }

    public entry fun add_new_symbol<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: u256, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u256, arg12: u128, arg13: u128, arg14: u128, arg15: u128, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedPositionConfig<T1, T2>{
            id      : 0x2::object::new(arg16),
            enabled : true,
            inner   : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::new_position_config(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15),
        };
        0x2::transfer::share_object<WrappedPositionConfig<T1, T2>>(v0);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::add<SymbolName<T1, T2>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v1, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::new_symbol(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::create_funding_fee_model(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg6), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg7), arg16), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::new_agg_price_config<T1>(arg2, arg3, arg4, arg5)));
        let v2 = SymbolCreated<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolCreated<T1, T2>>(v2);
    }

    public entry fun add_new_symbol_v1_1<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u256, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u256, arg12: u128, arg13: u128, arg14: u128, arg15: u128, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedPositionConfig<T1, T2>{
            id      : 0x2::object::new(arg16),
            enabled : true,
            inner   : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::new_position_config(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15),
        };
        0x2::transfer::share_object<WrappedPositionConfig<T1, T2>>(v0);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::add<SymbolName<T1, T2>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v1, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::new_symbol(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::create_funding_fee_model(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg6), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg7), arg16), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::new_agg_price_config_v1_1<T1>(arg2, arg3, arg4, arg5)));
        let v2 = SymbolCreated<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolCreated<T1, T2>>(v2);
    }

    public entry fun add_new_vault<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u64, arg4: u64, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::add<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::new_vault<T1>(arg2, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::create_reserving_fee_model(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg7), arg8), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::new_agg_price_config<T1>(arg3, arg4, arg5, arg6)));
        let v1 = VaultCreated<T1>{dummy_field: false};
        0x2::event::emit<VaultCreated<T1>>(v1);
    }

    public entry fun add_new_vault_v1_1<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u64, arg4: u64, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::add<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::new_vault<T1>(arg2, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::create_reserving_fee_model(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg7), arg8), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::new_agg_price_config_v1_1<T1>(arg3, arg4, arg5, arg6)));
        let v1 = VaultCreated<T1>{dummy_field: false};
        0x2::event::emit<VaultCreated<T1>>(v1);
    }

    public fun admin_add_liquidity_to_vault<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 1099511627776 == 0, 1);
        let v0 = VaultName<T1>{dummy_field: false};
        let (_, v2) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::admin_add_liquidity_to_vault<T1>(arg0, 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0), 0x2::coin::into_balance<T1>(arg2));
        let v3 = AdminLiquidityAdded<T1>{
            depositer       : 0x2::tx_context::sender(arg3),
            deposit_amount  : 0x2::coin::value<T1>(&arg2),
            after_liquidity : v2,
        };
        0x2::event::emit<AdminLiquidityAdded<T1>>(v3);
    }

    public entry fun admin_clear_closed_position<T0, T1, T2, T3>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: address, arg2: &mut Market<T0>, arg3: PositionCap<T1, T2, T3>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.fun_mask & 17179869184 == 0, 1);
        let PositionCap { id: v0 } = arg3;
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v0),
            owner : arg1,
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg2.positions, v1));
        0x2::object::delete(v0);
    }

    public entry fun admin_clear_closed_position_v1_1<T0, T1, T2, T3>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: address, arg2: &mut Market<T0>, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2.fun_mask & 68719476736 == 0, 1);
        let v0 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg3),
            owner : arg1,
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg2.positions, v0));
    }

    public entry fun admin_decrease_position_v1_2<T0, T1, T2, T3, T4>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Market<T0>, arg3: &mut PositionCap<T1, T2, T3>, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u256, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.fun_mask & 8589934592 == 0, 1);
        PositionName<T1, T2, T3>{id: 0x2::object::uid_to_inner(&arg3.id), owner: arg12};
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, arg12);
    }

    public entry fun admin_decrease_position_v1_3<T0, T1, T2, T3, T4>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Market<T0>, arg3: address, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg5: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u256, arg12: address, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.fun_mask & 34359738368 == 0, 1);
        assert!(!arg2.vaults_locked && !arg2.symbols_locked, 2);
        assert!(0x1::type_name::get<0x2::sui::SUI>() == 0x1::type_name::get<T4>(), 15);
        check_version<T0>(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = SymbolName<T2, T3>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg2.symbols, v1);
        let v3 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg3),
            owner : arg12,
        };
        assert!(arg9 > 0, 6);
        let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v2), arg7, v0);
        let v5 = VaultName<T1>{dummy_field: false};
        let v6 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg2.vaults, v5);
        let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v6), arg6, v0);
        let (v8, v9) = get_referral_data(&arg2.referrals, arg12);
        let (v10, v11, _) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position_v1_2<T1>(v6, v2, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg2.positions, v3), arg4, arg5, &v7, &v4, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg11), v8, parse_direction<T3>(), arg10, lp_supply_amount<T0>(arg2), v0);
        assert!(v10 == 0, v10);
        let (v13, v14, v15, v16) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_decrease_position_result_v1_2<T1>(0x1::option::destroy_some<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionResultV1_2<T1>>(v11));
        pay_from_balance<T1>(v13, arg12, arg13);
        pay_from_balance<T1>(v14, v9, arg13);
        pay_from_balance<T1>(v15, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, arg12);
        let v17 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_2>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v3),
            event         : v16,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_2>>(v17);
    }

    public entry fun admin_empty_vault<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 549755813888 == 0, 1);
        let v0 = VaultName<T1>{dummy_field: false};
        let v1 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0);
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_liquidity_amount<T1>(v1);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_reserved_amount<T1>(v1) == 0, 19);
        if (v2 > 0) {
            let v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v1), arg2, arg3);
            let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(&v3, v2);
            let v5 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(1);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v4, &v5), 18);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_liquidity<T1>(v1)), arg4), 0x2::tx_context::sender(arg4));
        };
        let v6 = VaultEmptied<T1>{withdrawn_amount: v2};
        0x2::event::emit<VaultEmptied<T1>>(v6);
    }

    public entry fun admin_remove_symbol_from_bag<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 137438953472 == 0, 1);
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::use_price_config(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::destroy_symbol(0x2::bag::remove<SymbolName<T1, T2>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v0)));
        let v1 = SymbolRemoved<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolRemoved<T1, T2>>(v1);
    }

    public entry fun admin_remove_vault_from_bag<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 274877906944 == 0, 1);
        let v0 = VaultName<T1>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::use_price_config(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::destroy_vault<T1>(0x2::bag::remove<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0)));
        let v1 = VaultRemoved<T1>{dummy_field: false};
        0x2::event::emit<VaultRemoved<T1>>(v1);
    }

    entry fun bump_market_version<T0>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_<u64>(&arg1.id, 10002)) {
            let v0 = 0x2::dynamic_object_field::borrow_mut<u64, MarketVersion>(&mut arg1.id, 10002);
            let v1 = v0.version;
            let v2 = v1 + 1;
            assert!(v2 <= 28, 28);
            v0.version = v2;
            let v3 = MarketVersionUpdated<T0>{
                old_version : v1,
                new_version : v2,
            };
            0x2::event::emit<MarketVersionUpdated<T0>>(v3);
        } else {
            let v4 = MarketVersion{
                id      : 0x2::object::new(arg2),
                version : 28,
            };
            0x2::dynamic_object_field::add<u64, MarketVersion>(&mut arg1.id, 10002, v4);
            let v5 = MarketVersionUpdated<T0>{
                old_version : 0,
                new_version : 28,
            };
            0x2::event::emit<MarketVersionUpdated<T0>>(v5);
        };
    }

    fun calculate_card_rebate_rate(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        let v0 = start_rebate_for_tier(0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::get_tier(arg0));
        let v1 = (0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::get_level(arg0) as u64);
        let v2 = 25;
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v0), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64((max_rebate_for_tier(0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::get_tier(arg0)) - v0) * 0x2::math::min(v1 * v1, v2 * v2)), v2 * v2)), 100))
    }

    public fun check_version<T0>(arg0: &Market<T0>) {
        assert!(get_market_version<T0>(arg0) == 28, 29);
    }

    public entry fun clear_closed_position<T0, T1, T2, T3>(arg0: &mut Market<T0>, arg1: PositionCap<T1, T2, T3>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 128 == 0, 1);
        let PositionCap { id: v0 } = arg1;
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v0),
            owner : 0x2::tx_context::sender(arg2),
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg0.positions, v1));
        0x2::object::delete(v0);
    }

    public entry fun clear_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 2048 == 0, 1);
        abort 0
    }

    public entry fun clear_decrease_position_order_unified<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 72057594037927936 == 0, 1);
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
        let v5 = if (0x2::bag::contains_with_type<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV2<T4>>(&arg0.orders, v4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_decrease_position_order_v2<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV2<T4>>(&mut arg0.orders, v4))
        } else if (0x2::bag::contains_with_type<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV1_1<T4>>(&arg0.orders, v4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_decrease_position_order_v1_1<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV1_1<T4>>(&mut arg0.orders, v4))
        } else if (0x2::bag::contains_with_type<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrder<T4>>(&arg0.orders, v4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_decrease_position_order<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrder<T4>>(&mut arg0.orders, v4))
        } else {
            0x2::balance::zero<T4>()
        };
        0x2::object::delete(v3);
        let v6 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v4};
        0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v6);
        pay_from_balance<T4>(v5, v0, arg2);
    }

    public entry fun clear_decrease_position_order_v1_1<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 67108864 == 0, 1);
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
        pay_from_balance<T4>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_decrease_position_order_v1_1<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV1_1<T4>>(&mut arg0.orders, v4)), v0, arg2);
    }

    public entry fun clear_decrease_position_order_v2<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 4503599627370496 == 0, 1);
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
        pay_from_balance<T4>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_decrease_position_order_v2<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV2<T4>>(&mut arg0.orders, v4)), v0, arg2);
    }

    public entry fun clear_open_position_order<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 1024 == 0, 1);
        abort 0
    }

    public entry fun clear_open_position_order_unified<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 36028797018963968 == 0, 1);
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
        let (v5, v6) = if (0x2::bag::contains_with_type<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV2<T1, T4>>(&arg0.orders, v4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_open_position_order_v2<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV2<T1, T4>>(&mut arg0.orders, v4))
        } else if (0x2::bag::contains_with_type<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV1_1<T1, T4>>(&arg0.orders, v4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_open_position_order_v1_1<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV1_1<T1, T4>>(&mut arg0.orders, v4))
        } else if (0x2::bag::contains_with_type<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrder<T1, T4>>(&arg0.orders, v4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_open_position_order<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrder<T1, T4>>(&mut arg0.orders, v4))
        } else {
            (0x2::balance::zero<T1>(), 0x2::balance::zero<T4>())
        };
        0x2::object::delete(v3);
        let v7 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v4};
        0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v7);
        pay_from_balance<T1>(v5, v0, arg2);
        pay_from_balance<T4>(v6, v0, arg2);
    }

    public entry fun clear_open_position_order_v1_1<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 33554432 == 0, 1);
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
        let (v5, v6) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_open_position_order_v1_1<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV1_1<T1, T4>>(&mut arg0.orders, v4));
        0x2::object::delete(v3);
        let v7 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v4};
        0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v7);
        pay_from_balance<T1>(v5, v0, arg2);
        pay_from_balance<T4>(v6, v0, arg2);
    }

    public entry fun clear_open_position_order_v2<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 2251799813685248 == 0, 1);
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
        let (v5, v6) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::destroy_open_position_order_v2<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV2<T1, T4>>(&mut arg0.orders, v4));
        0x2::object::delete(v3);
        let v7 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v4};
        0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v7);
        pay_from_balance<T1>(v5, v0, arg2);
        pay_from_balance<T4>(v6, v0, arg2);
    }

    public(friend) fun create_market<T0>(arg0: 0x2::balance::Supply<T0>, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Market<T0>{
            id               : 0x2::object::new(arg2),
            fun_mask         : 0,
            vaults_locked    : false,
            symbols_locked   : false,
            rebate_rate      : arg1,
            rebase_fee_model : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::create_rebase_fee_model(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_permyriad(1), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(10000000000000000), arg2),
            referrals        : 0x2::table::new<address, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::Referral>(arg2),
            vaults           : 0x2::bag::new(arg2),
            symbols          : 0x2::bag::new(arg2),
            positions        : 0x2::bag::new(arg2),
            orders           : 0x2::bag::new(arg2),
            lp_supply        : arg0,
        };
        let v1 = MarketCreated{
            referrals_parent : 0x2::object::id<0x2::table::Table<address, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::Referral>>(&v0.referrals),
            vaults_parent    : 0x2::object::id<0x2::bag::Bag>(&v0.vaults),
            symbols_parent   : 0x2::object::id<0x2::bag::Bag>(&v0.symbols),
            positions_parent : 0x2::object::id<0x2::bag::Bag>(&v0.positions),
            orders_parent    : 0x2::object::id<0x2::bag::Bag>(&v0.orders),
        };
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<Market<T0>>(v0);
    }

    public fun create_symbols_valuation<T0>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>) : SymbolsValuation {
        assert!(arg1.fun_mask & 65536 == 0, 1);
        assert!(!arg1.symbols_locked, 2);
        arg1.symbols_locked = true;
        SymbolsValuation{
            timestamp        : 0x2::clock::timestamp_ms(arg0) / 1000,
            num              : 0x2::bag::length(&arg1.symbols),
            lp_supply_amount : lp_supply_amount<T0>(arg1),
            handled          : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            value            : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::zero(),
        }
    }

    public fun create_vaults_valuation<T0>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>) : VaultsValuation {
        assert!(arg1.fun_mask & 32768 == 0, 1);
        assert!(!arg1.vaults_locked, 2);
        arg1.vaults_locked = true;
        VaultsValuation{
            timestamp    : 0x2::clock::timestamp_ms(arg0) / 1000,
            num          : 0x2::bag::length(&arg1.vaults),
            handled      : 0x2::vec_map::empty<0x1::type_name::TypeName, VaultInfo>(),
            total_weight : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
            value        : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
        }
    }

    public entry fun decrease_position<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &mut PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 4 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    fun decrease_position_common<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>, arg14: 0x1::option::Option<0x2::object::ID>, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 70368744177664 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(arg10 > 0, 25);
        assert!(0x2::coin::value<T4>(&arg7) > 0, 26);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<T4>(), 27);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg15);
        let v2 = parse_direction<T3>();
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v3);
        let v5 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v6 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v4), arg6, v0);
        let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12);
        let (v8, v9) = get_referral_data(&arg1.referrals, v1);
        let v10 = if (v2) {
            let v11 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&v6);
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::lt(&v11, &v7)
        } else {
            let v12 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&v6);
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v12, &v7)
        };
        if (v10 || !arg9) {
            assert!(arg8 < 2, 5);
            let v13 = VaultName<T1>{dummy_field: false};
            let v14 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v13)), arg5, v0);
            let v15 = 0x2::coin::into_balance<T4>(arg7);
            let v16 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(&v14, 0x2::balance::value<T4>(&v15));
            0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v5);
            let v17 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(order_min_fee<T0>(arg1)), 1000000000);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v16, &v17), 16);
            let v18 = 0x2::object::new(arg15);
            let v19 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v18),
                owner       : v1,
                position_id : 0x1::option::some<0x2::object::ID>(v5.id),
            };
            let (v20, v21) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::new_decrease_position_order_v2<T4>(v0, arg9, arg10, v7, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg11), v15, arg14, arg13, v9);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV2<T4>>(&mut arg1.orders, v19, v20);
            let v22 = OrderCap<T1, T2, T3, T4>{
                id          : v18,
                position_id : v19.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v22, v1);
            let v23 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateDecreasePositionOrderV2Event>{
                order_name : v19,
                event      : v21,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateDecreasePositionOrderV2Event>>(v23);
        } else {
            assert!(arg8 > 0, 6);
            let v24 = VaultName<T1>{dummy_field: false};
            let v25 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v24);
            let v26 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v25), arg5, v0);
            let v27 = 0x2::dynamic_object_field::borrow<u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig>(&arg1.id, 10001);
            let v28 = get_symbol_instant_exit_fee_config<T2, T3>(&arg1.id);
            let (v29, v30, v31, v32, v33) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_decrease_position_result_v2<T1>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position_v2<T1>(v25, v4, v27, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v5), arg3, arg4, &v26, &v6, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg11), v8, arg13, v2, arg10, lp_supply_amount<T0>(arg1), &v28, v0, v9));
            let v34 = v32;
            pay_from_balance<T1>(v29, v1, arg15);
            pay_from_balance<T1>(v30, v9, arg15);
            let v35 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::get_fee_collector(v27);
            pay_from_balance<T1>(v31, v35, arg15);
            if (0x2::balance::value<T1>(&v34) > 0) {
                if (0x1::option::is_some<0x2::object::ID>(&arg14)) {
                    let v36 = *0x1::option::borrow<0x2::object::ID>(&arg14);
                    pay_from_balance<T1>(v34, 0x2::object::id_to_address(&v36), arg15);
                } else {
                    pay_from_balance<T1>(v34, v35, arg15);
                };
            } else {
                pay_from_balance<T1>(v34, v35, arg15);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg7, v1);
            let v37 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV2>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v5),
                event         : v33,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV2>>(v37);
        };
    }

    public entry fun decrease_position_v1_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &mut PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 1048576 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun decrease_position_v1_2<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &mut PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: bool, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 1073741824 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(0x1::type_name::get<0x2::sui::SUI>() == 0x1::type_name::get<T4>(), 15);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = SymbolName<T2, T3>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v2);
        let v4 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        if (arg13) {
            let v5 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12);
            let v6 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v5, &v6), 17);
            let v7 = 0x2::coin::into_balance<T4>(arg7);
            let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0x2::balance::value<T4>(&v7));
            let v9 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(order_min_fee<T0>(arg1));
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v8, &v9), 16);
            assert!(arg8 < 2, 5);
            let v10 = 0x2::object::new(arg14);
            let v11 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v10),
                owner       : v1,
                position_id : 0x1::option::some<0x2::object::ID>(v4.id),
            };
            let (v12, v13) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::new_decrease_position_order_v1_1<T4>(v0, arg9, arg10, v5, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg11), v7);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV1_1<T4>>(&mut arg1.orders, v11, v12);
            let v14 = OrderCap<T1, T2, T3, T4>{
                id          : v10,
                position_id : v11.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v14, v1);
            let v15 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateDecreasePositionOrderEvent>{
                order_name : v11,
                event      : v13,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateDecreasePositionOrderEvent>>(v15);
        } else {
            assert!(arg8 > 0, 6);
            let v16 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v3), arg6, v0);
            let v17 = VaultName<T1>{dummy_field: false};
            let v18 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v17);
            let v19 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v18), arg5, v0);
            let (v20, v21) = get_referral_data(&arg1.referrals, v1);
            let (v22, v23, _) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position_v1_2<T1>(v18, v3, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v4), arg3, arg4, &v19, &v16, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg11), v20, parse_direction<T3>(), arg10, lp_supply_amount<T0>(arg1), v0);
            assert!(v22 == 0, v22);
            let (v25, v26, v27, v28) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_decrease_position_result_v1_2<T1>(0x1::option::destroy_some<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionResultV1_2<T1>>(v23));
            pay_from_balance<T1>(v25, v1, arg14);
            pay_from_balance<T1>(v26, v21, arg14);
            pay_from_balance<T1>(v27, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg7, v1);
            let v29 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_2>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v4),
                event         : v28,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_2>>(v29);
        };
    }

    public entry fun decrease_position_v1_3<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &mut PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: bool, arg14: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 4294967296 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(0x1::type_name::get<0x2::sui::SUI>() == 0x1::type_name::get<T4>(), 15);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg15);
        let v2 = SymbolName<T2, T3>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v2);
        let v4 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        if (arg13) {
            let v5 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12);
            let v6 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v5, &v6), 17);
            let v7 = 0x2::coin::into_balance<T4>(arg7);
            let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0x2::balance::value<T4>(&v7));
            let v9 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(order_min_fee<T0>(arg1));
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v8, &v9), 16);
            assert!(arg8 < 2, 5);
            let v10 = 0x2::object::new(arg15);
            let v11 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v10),
                owner       : v1,
                position_id : 0x1::option::some<0x2::object::ID>(v4.id),
            };
            let (v12, v13) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::new_decrease_position_order_v1_1<T4>(v0, arg9, arg10, v5, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg11), v7);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV1_1<T4>>(&mut arg1.orders, v11, v12);
            let v14 = OrderCap<T1, T2, T3, T4>{
                id          : v10,
                position_id : v11.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v14, v1);
            let v15 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateDecreasePositionOrderEvent>{
                order_name : v11,
                event      : v13,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateDecreasePositionOrderEvent>>(v15);
        } else {
            assert!(arg8 > 0, 6);
            let v16 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v3), arg6, v0);
            let v17 = VaultName<T1>{dummy_field: false};
            let v18 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v17);
            let v19 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v18), arg5, v0);
            let (v20, v21) = get_referral_data(&arg1.referrals, v1);
            let (v22, v23, v24, v25, v26) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_decrease_position_result_v1_3<T1>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_position_v1_3_1<T1>(v18, v3, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v4), arg3, arg4, &v19, &v16, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg11), v20, calculate_card_rebate_rate(arg14), parse_direction<T3>(), arg10, lp_supply_amount<T0>(arg1), v0));
            pay_from_balance<T1>(v22, v1, arg15);
            pay_from_balance<T1>(v23, v21, arg15);
            let v27 = 0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard>(arg14);
            pay_from_balance<T1>(v24, 0x2::object::id_to_address(&v27), arg15);
            pay_from_balance<T1>(v25, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg7, v1);
            let v28 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_3>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v4),
                event         : v26,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_3>>(v28);
        };
    }

    public entry fun decrease_position_v2<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 140737488355328 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun decrease_position_v2_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 576460752303423488 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        decrease_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x1::option::none<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>(), 0x1::option::none<0x2::object::ID>(), arg13);
    }

    public entry fun decrease_position_with_scard<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 281474976710656 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(arg10 > 0, 25);
        assert!(0x2::coin::value<T4>(&arg7) > 0, 26);
        abort 0
    }

    public entry fun decrease_position_with_scard_v1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 1152921504606846976 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(arg10 > 0, 25);
        assert!(0x2::coin::value<T4>(&arg7) > 0, 26);
        decrease_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x1::option::some<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>(calculate_card_rebate_rate(arg13)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard>(arg13)), arg14);
    }

    public entry fun decrease_reserved_from_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 8 == 0, 1);
        check_version<T0>(arg1);
        let v0 = VaultName<T1>{dummy_field: false};
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : 0x2::tx_context::sender(arg5),
        };
        let v2 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreaseReservedFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v1),
            event         : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::decrease_reserved_from_position<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0), 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v1), arg3, arg4, 0x2::clock::timestamp_ms(arg0) / 1000),
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreaseReservedFromPositionEvent>>(v2);
    }

    public fun deposit<T0, T1>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 4096 == 0, 1);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = deposit_ptb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        pay_from_balance<T0>(0x2::coin::into_balance<T0>(v1), v0, arg6);
    }

    public fun deposit_ptb<T0, T1>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.fun_mask & 562949953421312 == 0, 1);
        assert!(0x2::object::id<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 12);
        check_version<T0>(arg0);
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
        let (v13, v14) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::deposit<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg0.vaults, v12), arg1, &v11, 0x2::coin::into_balance<T1>(arg2), arg3, v0, v4, v10, v3, v2);
        let v15 = Deposited<T1>{
            minter         : 0x2::tx_context::sender(arg6),
            price          : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&v11),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            mint_amount    : v13,
            fee_value      : v14,
        };
        0x2::event::emit<Deposited<T1>>(v15);
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, v13), arg6)
    }

    public entry fun execute_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 512 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun execute_decrease_position_order_v1_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 16777216 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
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
        let v4 = VaultName<T1>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v4);
        let v6 = SymbolName<T2, T3>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v6);
        let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v5), arg4, v0);
        let v9 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v7), arg5, v0);
        let (v10, v11) = get_referral_data(&arg1.referrals, arg6);
        let (v12, v13) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::execute_decrease_position_order_v1_3<T1, T4>(0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV1_1<T4>>(&mut arg1.orders, v3), v5, v7, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v2), arg2, arg3, &v8, &v9, v10, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero(), parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        let (v14, v15, v16, v17, v18) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_decrease_position_result_v1_3<T1>(v12);
        pay_from_balance<T1>(v14, arg6, arg9);
        pay_from_balance<T1>(v15, v11, arg9);
        pay_from_balance<T1>(v16, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg9);
        pay_from_balance<T1>(v17, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg9);
        pay_from_balance<T4>(v13, v1, arg9);
        let v19 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_3>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v2),
            event         : v18,
        };
        let v20 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_3>>{
            executor   : v1,
            order_name : v3,
            claim      : v19,
        };
        0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV1_3>>>(v20);
    }

    public entry fun execute_decrease_position_order_v1_2<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg7: address, arg8: address, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 4398046511104 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun execute_decrease_position_order_v2<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 18014398509481984 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        check_version<T0>(arg1);
        abort 0
    }

    public entry fun execute_decrease_position_order_v2_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 4611686018427387904 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
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
        let v4 = 0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::DecreasePositionOrderV2<T4>>(&mut arg1.orders, v3);
        let v5 = VaultName<T1>{dummy_field: false};
        let v6 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v5);
        let v7 = SymbolName<T2, T3>{dummy_field: false};
        let v8 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v7);
        let v9 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v6), arg4, v0);
        let v10 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v8), arg5, v0);
        let v11 = 0x2::dynamic_object_field::borrow<u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig>(&arg1.id, 10001);
        let (v12, v13) = get_referral_data(&arg1.referrals, arg6);
        let v14 = get_symbol_instant_exit_fee_config<T2, T3>(&arg1.id);
        let (v15, v16) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::execute_decrease_position_order_v2<T1, T4>(v4, v6, v8, v11, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v2), arg2, arg3, &v9, &v10, v12, parse_direction<T3>(), lp_supply_amount<T0>(arg1), &v14, v0);
        let (v17, v18, v19, v20, v21) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_decrease_position_result_v2<T1>(v15);
        let v22 = v20;
        let v23 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::get_fee_collector(v11);
        pay_from_balance<T1>(v17, arg6, arg9);
        pay_from_balance<T1>(v18, v13, arg9);
        pay_from_balance<T1>(v19, v23, arg9);
        if (0x2::balance::value<T1>(&v22) > 0) {
            if (0x1::option::is_some<0x2::object::ID>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::get_scard_id_from_decrease_order_v2<T4>(v4))) {
                let v24 = *0x1::option::borrow<0x2::object::ID>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::get_scard_id_from_decrease_order_v2<T4>(v4));
                pay_from_balance<T1>(v22, 0x2::object::id_to_address(&v24), arg9);
            } else {
                pay_from_balance<T1>(v22, v23, arg9);
            };
        } else {
            pay_from_balance<T1>(v22, v23, arg9);
        };
        let v25 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV2>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v2),
            event         : v21,
        };
        let v26 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV2>>{
            executor   : v1,
            order_name : v3,
            claim      : v25,
        };
        0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::DecreasePositionSuccessEventV2>>>(v26);
        pay_from_balance<T4>(v16, v1, arg9);
    }

    public entry fun execute_open_position_order<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 256 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun execute_open_position_order_v1_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 8388608 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg7),
            owner       : arg6,
            position_id : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = VaultName<T1>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v3);
        let v5 = SymbolName<T2, T3>{dummy_field: false};
        let v6 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v5);
        let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v4), arg4, v0);
        let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v6), arg5, v0);
        let (v9, v10) = get_referral_data(&arg1.referrals, arg6);
        let (v11, v12) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::execute_open_position_order_v1_3<T1, T4>(0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV1_1<T1, T4>>(&mut arg1.orders, v2), v4, v6, arg2, arg3, &v7, &v8, v9, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero(), parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        let (v13, v14, v15, v16, v17) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_open_position_result_v1_3<T1>(v11);
        let v18 = 0x2::object::new(arg8);
        let v19 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v18),
            owner : arg6,
        };
        0x2::bag::add<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v19, v13);
        let v20 = PositionCap<T1, T2, T3>{id: v18};
        0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v20, arg6);
        pay_from_balance<T1>(v14, v10, arg8);
        pay_from_balance<T1>(v15, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg8);
        pay_from_balance<T1>(v16, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg8);
        pay_from_balance<T4>(v12, v1, arg8);
        let v21 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV1_3>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v19),
            event         : v17,
        };
        let v22 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV1_3>>{
            executor   : v1,
            order_name : v2,
            claim      : v21,
        };
        0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV1_3>>>(v22);
    }

    public entry fun execute_open_position_order_v1_2<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 2199023255552 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun execute_open_position_order_v2<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 9007199254740992 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        check_version<T0>(arg1);
        abort 0
    }

    public entry fun execute_open_position_order_v2_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 2305843009213693952 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg7),
            owner       : arg6,
            position_id : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = 0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV2<T1, T4>>(&mut arg1.orders, v2);
        let v4 = VaultName<T1>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v4);
        let v6 = SymbolName<T2, T3>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v6);
        let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v5), arg4, v0);
        let v9 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v7), arg5, v0);
        let v10 = 0x2::dynamic_object_field::borrow<u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig>(&arg1.id, 10001);
        let (v11, v12) = get_referral_data(&arg1.referrals, arg6);
        let (v13, v14) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::execute_open_position_order_v2<T1, T4>(v3, v5, v7, v10, arg2, arg3, &v8, &v9, v11, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        let (v15, v16, v17, v18, v19) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_open_position_result_v2<T1>(v13);
        let v20 = v18;
        let v21 = 0x2::object::new(arg8);
        let v22 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v21),
            owner : arg6,
        };
        0x2::bag::add<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v22, v15);
        let v23 = PositionCap<T1, T2, T3>{id: v21};
        0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v23, arg6);
        let v24 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::get_fee_collector(v10);
        pay_from_balance<T1>(v16, v12, arg8);
        pay_from_balance<T1>(v17, v24, arg8);
        if (0x2::balance::value<T1>(&v20) > 0) {
            if (0x1::option::is_some<0x2::object::ID>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::get_scard_id_from_open_order_v2<T1, T4>(v3))) {
                let v25 = *0x1::option::borrow<0x2::object::ID>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::get_scard_id_from_open_order_v2<T1, T4>(v3));
                pay_from_balance<T1>(v20, 0x2::object::id_to_address(&v25), arg8);
            } else {
                pay_from_balance<T1>(v20, v24, arg8);
            };
        } else {
            pay_from_balance<T1>(v20, v24, arg8);
        };
        let v26 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV2>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v22),
            event         : v19,
        };
        let v27 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV2>>{
            executor   : v1,
            order_name : v2,
            claim      : v26,
        };
        0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV2>>>(v27);
        pay_from_balance<T4>(v14, v1, arg8);
    }

    fun finalize_market_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation, arg2: SymbolsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) {
        let (v0, v1, v2) = finalize_vaults_valuation<T0>(arg0, arg1);
        let v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::add_with_decimal(finalize_symbols_valuation<T0>(arg0, arg2), v2);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::is_positive(&v3), 11);
        (v0, v1, v2, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::value(&v3))
    }

    fun finalize_symbols_valuation<T0>(arg0: &mut Market<T0>, arg1: SymbolsValuation) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal {
        let SymbolsValuation {
            timestamp        : _,
            num              : v1,
            lp_supply_amount : _,
            handled          : v3,
            value            : v4,
        } = arg1;
        let v5 = v3;
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(&v5) == v1, 10);
        arg0.symbols_locked = false;
        v4
    }

    fun finalize_vaults_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) {
        let VaultsValuation {
            timestamp    : _,
            num          : v1,
            handled      : v2,
            total_weight : v3,
            value        : v4,
        } = arg1;
        let v5 = v2;
        assert!(0x2::vec_map::size<0x1::type_name::TypeName, VaultInfo>(&v5) == v1, 9);
        arg0.vaults_locked = false;
        (v5, v3, v4)
    }

    public fun get_market_version<T0>(arg0: &Market<T0>) : u64 {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, 10002)) {
            0x2::dynamic_object_field::borrow<u64, MarketVersion>(&arg0.id, 10002).version
        } else {
            0
        }
    }

    fun get_referral_data(arg0: &0x2::table::Table<address, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::Referral>, arg1: address) : (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, address) {
        if (0x2::table::contains<address, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::Referral>(arg0, arg1)) {
            let v2 = 0x2::table::borrow<address, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::Referral>(arg0, arg1);
            (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::get_rebate_rate(v2), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::referral::get_referrer(v2))
        } else {
            (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero(), @0x0)
        }
    }

    fun get_symbol_instant_exit_fee_config<T0, T1>(arg0: &0x2::object::UID) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::PositionInstantExitFeeConfig {
        let v0 = SymbolName<T0, T1>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<SymbolName<T0, T1>>(arg0, v0)) {
            0x2::dynamic_object_field::borrow<SymbolName<T0, T1>, SymbolConfig>(arg0, v0).instant_exit_fee_config
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::default_position_instant_exit_fee_config()
        }
    }

    public fun position<T0, T1, T2, T3>(arg0: &Market<T0>, arg1: 0x2::object::ID, arg2: address) : &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1> {
        let v0 = PositionName<T1, T2, T3>{
            id    : arg1,
            owner : arg2,
        };
        0x2::bag::borrow<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&arg0.positions, v0)
    }

    entry fun init_symbol_config<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        if (!0x2::dynamic_object_field::exists_<SymbolName<T1, T2>>(&arg1.id, v0)) {
            let v1 = SymbolConfig{
                id                                    : 0x2::object::new(arg2),
                max_opening_size                      : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
                max_opening_size_enabled              : false,
                max_opening_size_per_position         : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
                max_opening_size_per_position_enabled : false,
                instant_exit_fee_config               : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::default_position_instant_exit_fee_config(),
            };
            0x2::dynamic_object_field::add<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0, v1);
        };
    }

    public entry fun liquidate_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 64 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun liquidate_position_v1_1<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 4194304 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg7),
            owner : arg6,
        };
        let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v3), arg4, v0);
        let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v5), arg5, v0);
        let (v9, v10) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::liquidate_position_v1_1<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v6), arg2, arg3, &v7, &v8, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0, v1);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::LiquidatePositionEventV1_1>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::LiquidatePositionEventV1_1>>(v11);
    }

    public fun lp_supply_amount<T0>(arg0: &Market<T0>) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0x2::balance::supply_value<T0>(&arg0.lp_supply)), 1000000)
    }

    fun max_rebate_for_tier(arg0: u8) : u64 {
        if (arg0 == 0) {
            50
        } else if (arg0 == 1) {
            45
        } else if (arg0 == 2) {
            35
        } else {
            0
        }
    }

    public entry fun open_position<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 2 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    fun open_position_common<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: 0x1::option::Option<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>, arg15: 0x1::option::Option<0x2::object::ID>, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 8796093022208 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(arg10 > 0, 23);
        assert!(0x2::coin::value<T1>(&arg7) > 0, 24);
        assert!(0x2::coin::value<T4>(&arg8) > 0, 26);
        assert!(0x1::type_name::get<T1>() == 0x1::type_name::get<T4>(), 27);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg16);
        let v2 = parse_direction<T3>();
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v3);
        let (v5, v6, v7, v8) = if (0x2::dynamic_object_field::exists_<SymbolName<T2, T3>>(&arg1.id, v3)) {
            let v9 = 0x2::dynamic_object_field::borrow<SymbolName<T2, T3>, SymbolConfig>(&arg1.id, v3);
            (v9.max_opening_size, v9.max_opening_size_enabled, v9.max_opening_size_per_position, v9.max_opening_size_per_position_enabled)
        } else {
            (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(), false, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(), false)
        };
        let v10 = v7;
        let v11 = v5;
        let v12 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v4), arg6, v0);
        let v13 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg13);
        let (v14, v15) = get_referral_data(&arg1.referrals, v1);
        let v16 = if (v6) {
            let v17 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero();
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v11, &v17)
        } else {
            false
        };
        if (v16) {
            let v18 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_opening_size(v4), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(&v12, arg10));
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v18, &v11), 20);
        };
        let v19 = if (v8) {
            let v20 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero();
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v10, &v20)
        } else {
            false
        };
        if (v19) {
            let v21 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(&v12, arg10);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v21, &v10), 21);
        };
        let v22 = if (v2) {
            let v23 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&v12);
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v23, &v13)
        } else {
            let v24 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&v12);
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::lt(&v24, &v13)
        };
        if (v22) {
            assert!(arg9 < 2, 5);
            let v25 = VaultName<T1>{dummy_field: false};
            let v26 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v25)), arg5, v0);
            let v27 = 0x2::coin::into_balance<T4>(arg8);
            let v28 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(&v26, 0x2::balance::value<T4>(&v27));
            let v29 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(order_min_fee<T0>(arg1)), 1000000000);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v28, &v29), 16);
            let v30 = 0x2::object::new(arg16);
            let v31 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v30),
                owner       : v1,
                position_id : 0x1::option::none<0x2::object::ID>(),
            };
            let (v32, v33) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::new_open_position_order_v2<T1, T4>(v0, arg10, arg11, v13, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12), arg4.inner, 0x2::coin::into_balance<T1>(arg7), v27, arg15, arg14, v15);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV2<T1, T4>>(&mut arg1.orders, v31, v32);
            let v34 = OrderCap<T1, T2, T3, T4>{
                id          : v30,
                position_id : v31.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v34, v1);
            let v35 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateOpenPositionOrderV2Event>{
                order_name : v31,
                event      : v33,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateOpenPositionOrderV2Event>>(v35);
        } else {
            assert!(arg9 > 0, 6);
            let v36 = VaultName<T1>{dummy_field: false};
            let v37 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v36);
            let v38 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v37), arg5, v0);
            let v39 = 0x2::dynamic_object_field::borrow<u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig>(&arg1.id, 10001);
            let v40 = 0x2::object::new(arg16);
            let v41 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v40),
                owner : v1,
            };
            let v42 = 0x2::coin::into_balance<T1>(arg7);
            0x2::balance::destroy_zero<T1>(v42);
            let (v43, v44, v45, v46, v47) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_open_position_result_v2<T1>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position_v2<T1>(v37, v4, v39, arg2, arg3, &arg4.inner, &v38, &v12, &mut v42, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12), v14, arg14, v2, arg10, arg11, lp_supply_amount<T0>(arg1), v0, v15));
            let v48 = v46;
            0x2::bag::add<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v41, v43);
            let v49 = PositionCap<T1, T2, T3>{id: v40};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v49, v1);
            pay_from_balance<T1>(v44, v15, arg16);
            let v50 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::get_fee_collector(v39);
            pay_from_balance<T1>(v45, v50, arg16);
            if (0x2::balance::value<T1>(&v48) > 0) {
                if (0x1::option::is_some<0x2::object::ID>(&arg15)) {
                    let v51 = *0x1::option::borrow<0x2::object::ID>(&arg15);
                    pay_from_balance<T1>(v48, 0x2::object::id_to_address(&v51), arg16);
                } else {
                    pay_from_balance<T1>(v48, v50, arg16);
                };
            } else {
                pay_from_balance<T1>(v48, v50, arg16);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, v1);
            let v52 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV2>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v41),
                event         : v47,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV2>>(v52);
        };
    }

    public entry fun open_position_v1_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 524288 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun open_position_v1_2<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: bool, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 536870912 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(0x1::type_name::get<0x2::sui::SUI>() == 0x1::type_name::get<T4>(), 15);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg15);
        let v2 = SymbolName<T2, T3>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v2);
        if (arg14) {
            let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg13);
            let v5 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v4, &v5), 17);
            assert!(arg9 < 2, 5);
            let v6 = VaultName<T1>{dummy_field: false};
            let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v6)), arg5, v0);
            let v8 = 0x2::coin::into_balance<T1>(arg7);
            let v9 = 0x2::coin::into_balance<T4>(arg8);
            let v10 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0x2::balance::value<T4>(&v9));
            let v11 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(order_min_fee<T0>(arg1));
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v10, &v11), 16);
            let v12 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(&v7, 0x2::balance::value<T1>(&v8));
            let v13 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(order_min_collateral_value<T0>(arg1));
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v12, &v13), 14);
            let v14 = 0x2::object::new(arg15);
            let v15 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v14),
                owner       : v1,
                position_id : 0x1::option::none<0x2::object::ID>(),
            };
            let (v16, v17) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::new_open_position_order_v1_1<T1, T4>(v0, arg10, arg11, v4, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12), arg4.inner, v8, v9);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV1_1<T1, T4>>(&mut arg1.orders, v15, v16);
            let v18 = OrderCap<T1, T2, T3, T4>{
                id          : v14,
                position_id : v15.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v18, v1);
            let v19 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateOpenPositionOrderEvent>{
                order_name : v15,
                event      : v17,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateOpenPositionOrderEvent>>(v19);
        } else {
            assert!(arg9 > 0, 6);
            let v20 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v3), arg6, v0);
            let v21 = VaultName<T1>{dummy_field: false};
            let v22 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v21);
            let v23 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v22), arg5, v0);
            let (v24, v25) = get_referral_data(&arg1.referrals, v1);
            let v26 = 0x2::object::new(arg15);
            let v27 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v26),
                owner : v1,
            };
            let v28 = 0x2::coin::into_balance<T1>(arg7);
            let (v29, v30, _) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position_v1_2<T1>(v22, v3, arg2, arg3, &arg4.inner, &v23, &v20, &mut v28, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12), v24, parse_direction<T3>(), arg10, arg11, lp_supply_amount<T0>(arg1), v0);
            assert!(v29 == 0, v29);
            0x2::balance::destroy_zero<T1>(v28);
            let (v32, v33, v34, v35) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_open_position_result_v1_2<T1>(0x1::option::destroy_some<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionResultV1_2<T1>>(v30));
            0x2::bag::add<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v27, v32);
            let v36 = PositionCap<T1, T2, T3>{id: v26};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v36, v1);
            pay_from_balance<T1>(v33, v25, arg15);
            pay_from_balance<T1>(v34, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, v1);
            let v37 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV1_2>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v27),
                event         : v35,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV1_2>>(v37);
        };
    }

    public entry fun open_position_v1_3<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: bool, arg15: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 2147483648 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(0x1::type_name::get<0x2::sui::SUI>() == 0x1::type_name::get<T4>(), 15);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg16);
        let v2 = SymbolName<T2, T3>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v2);
        if (arg14) {
            let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg13);
            let v5 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v4, &v5), 17);
            assert!(arg9 < 2, 5);
            let v6 = VaultName<T1>{dummy_field: false};
            let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v6)), arg5, v0);
            let v8 = 0x2::coin::into_balance<T1>(arg7);
            let v9 = 0x2::coin::into_balance<T4>(arg8);
            let v10 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0x2::balance::value<T4>(&v9));
            let v11 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(order_min_fee<T0>(arg1));
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v10, &v11), 16);
            let v12 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(&v7, 0x2::balance::value<T1>(&v8));
            let v13 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(order_min_collateral_value<T0>(arg1));
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v12, &v13), 14);
            let v14 = 0x2::object::new(arg16);
            let v15 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v14),
                owner       : v1,
                position_id : 0x1::option::none<0x2::object::ID>(),
            };
            let (v16, v17) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::new_open_position_order_v1_1<T1, T4>(v0, arg10, arg11, v4, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12), arg4.inner, v8, v9);
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::OpenPositionOrderV1_1<T1, T4>>(&mut arg1.orders, v15, v16);
            let v18 = OrderCap<T1, T2, T3, T4>{
                id          : v14,
                position_id : v15.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v18, v1);
            let v19 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateOpenPositionOrderEvent>{
                order_name : v15,
                event      : v17,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::orders::CreateOpenPositionOrderEvent>>(v19);
        } else {
            assert!(arg9 > 0, 6);
            let v20 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v3), arg6, v0);
            let v21 = VaultName<T1>{dummy_field: false};
            let v22 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v21);
            let v23 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v22), arg5, v0);
            let (v24, v25) = get_referral_data(&arg1.referrals, v1);
            let v26 = 0x2::object::new(arg16);
            let v27 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v26),
                owner : v1,
            };
            let v28 = 0x2::coin::into_balance<T1>(arg7);
            0x2::balance::destroy_zero<T1>(v28);
            let (v29, v30, v31, v32, v33) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::unwrap_open_position_result_v1_3<T1>(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::open_position_v1_3_1<T1>(v22, v3, arg2, arg3, &arg4.inner, &v23, &v20, &mut v28, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg12), v24, calculate_card_rebate_rate(arg15), parse_direction<T3>(), arg10, arg11, lp_supply_amount<T0>(arg1), v0));
            0x2::bag::add<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v27, v29);
            let v34 = PositionCap<T1, T2, T3>{id: v26};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v34, v1);
            pay_from_balance<T1>(v30, v25, arg16);
            pay_from_balance<T1>(v32, @0x9399c7f4aae1db1dfdea97d93f738e2fbef1f51e8ca015a456056ea951091bdc, arg16);
            let v35 = 0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard>(arg15);
            pay_from_balance<T1>(v31, 0x2::object::id_to_address(&v35), arg16);
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, v1);
            let v36 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV1_3>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v27),
                event         : v33,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::OpenPositionSuccessEventV1_3>>(v36);
        };
    }

    public entry fun open_position_v2<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 17592186044416 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        abort 0
    }

    public entry fun open_position_v2_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 144115188075855872 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        open_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::option::none<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>(), 0x1::option::none<0x2::object::ID>(), arg14);
    }

    public entry fun open_position_with_scard<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 35184372088832 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(arg10 > 0, 23);
        assert!(0x2::coin::value<T1>(&arg7) > 0, 24);
        assert!(0x2::coin::value<T4>(&arg8) > 0, 26);
        abort 0
    }

    public entry fun open_position_with_scard_v1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 288230376151711744 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        assert!(arg10 > 0, 23);
        assert!(0x2::coin::value<T1>(&arg7) > 0, 24);
        assert!(0x2::coin::value<T4>(&arg8) > 0, 26);
        open_position_common<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x1::option::some<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate>(calculate_card_rebate_rate(arg14)), 0x1::option::some<0x2::object::ID>(0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::SudoCard>(arg14)), arg15);
    }

    public fun order_min_collateral_value<T0>(arg0: &Market<T0>) : u64 {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, 10003)) {
            0x2::dynamic_object_field::borrow<u64, OrderConfig>(&arg0.id, 10003).min_collateral_value
        } else {
            10
        }
    }

    public fun order_min_fee<T0>(arg0: &Market<T0>) : u64 {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, 10003)) {
            0x2::dynamic_object_field::borrow<u64, OrderConfig>(&arg0.id, 10003).min_fee
        } else {
            10000000
        }
    }

    public fun parse_direction<T0>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<LONG>()) {
            true
        } else {
            assert!(v0 == 0x1::type_name::get<SHORT>(), 4);
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
        assert!(arg0.fun_mask & 16 == 0, 1);
        check_version<T0>(arg0);
        let v0 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg1.id),
            owner : 0x2::tx_context::sender(arg3),
        };
        let v1 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::PledgeInPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v0),
            event         : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::pledge_in_position<T1>(0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg0.positions, v0), 0x2::coin::into_balance<T1>(arg2)),
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::PledgeInPositionEvent>>(v1);
    }

    public fun rebase_fee_model<T0>(arg0: &Market<T0>) : &0x2::object::ID {
        &arg0.rebase_fee_model
    }

    public entry fun redeem_from_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 32 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v3), arg5, v0);
        let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v5), arg6, v0);
        let (v9, v10) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::redeem_from_position<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v6), arg3, arg4, &v7, &v8, parse_direction<T3>(), arg7, lp_supply_amount<T0>(arg1), v0);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::RedeemFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::RedeemFromPositionEvent>>(v11);
    }

    public entry fun redeem_from_position_v1_1<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg4: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 2097152 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        check_version<T0>(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v3), arg5, v0);
        let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v5), arg6, v0);
        let (v9, v10) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::redeem_from_position<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::Position<T1>>(&mut arg1.positions, v6), arg3, arg4, &v7, &v8, parse_direction<T3>(), arg7, lp_supply_amount<T0>(arg1), v0);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::RedeemFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::RedeemFromPositionEvent>>(v11);
    }

    public entry fun remove_collateral_from_symbol<T0, T1, T2, T3>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SymbolName<T2, T3>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::remove_collateral_from_symbol<T1>(0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v0));
        let v1 = CollateralRemoved<T1, T2, T3>{dummy_field: false};
        0x2::event::emit<CollateralRemoved<T1, T2, T3>>(v1);
    }

    public entry fun replace_position_config<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut WrappedPositionConfig<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u256, arg6: u128, arg7: u128, arg8: u128, arg9: u128) {
        arg1.inner = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::new_position_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v0 = PositionConfigReplaced<T0, T1>{
            max_leverage            : arg2,
            min_holding_duration    : arg3,
            max_reserved_multiplier : arg4,
            min_collateral_value    : arg5,
            open_fee_bps            : arg6,
            decrease_fee_bps        : arg7,
            liquidation_threshold   : arg8,
            liquidation_bonus       : arg9,
        };
        0x2::event::emit<PositionConfigReplaced<T0, T1>>(v0);
    }

    public entry fun replace_symbol_feeder<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::update_agg_price_config_feeder(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::mut_symbol_price_config(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v0)), arg2);
    }

    public entry fun replace_vault_feeder<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = VaultName<T1>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::update_agg_price_config_feeder(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::mut_vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0)), arg2);
    }

    public entry fun reset_symbol_funding_rate<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>) {
        abort 0
    }

    entry fun set_fee_config<T0>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_percent(arg2);
        validate_config_fee_rate((0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::to_raw(v0) as u256));
        if (0x2::dynamic_object_field::exists_<u64>(&arg1.id, 10001)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig>(&mut arg1.id, 10001);
            if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::to_raw(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::get_fee_rate(v1)) != 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::to_raw(v0) || 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::get_fee_collector(v1) != arg3) {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::set_fee_config_rate(v1, v0, arg3);
                let v2 = FeeConfigUpdated<T0>{
                    fee_rate_percent : arg2,
                    fee_collector    : arg3,
                };
                0x2::event::emit<FeeConfigUpdated<T0>>(v2);
            };
        } else {
            0x2::dynamic_object_field::add<u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::FeeConfig>(&mut arg1.id, 10001, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::fee::new_fee_config(v0, arg3, arg4));
            let v3 = FeeConfigUpdated<T0>{
                fee_rate_percent : arg2,
                fee_collector    : arg3,
            };
            0x2::event::emit<FeeConfigUpdated<T0>>(v3);
        };
    }

    entry fun set_order_config<T0>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 26);
        assert!(arg3 > 0, 24);
        if (0x2::dynamic_object_field::exists_<u64>(&arg1.id, 10003)) {
            let v0 = 0x2::dynamic_object_field::borrow_mut<u64, OrderConfig>(&mut arg1.id, 10003);
            if (v0.min_fee != arg2 || v0.min_collateral_value != arg3) {
                v0.min_fee = arg2;
                v0.min_collateral_value = arg3;
                let v1 = OrderConfigUpdated<T0>{
                    min_fee              : arg2,
                    min_collateral_value : arg3,
                };
                0x2::event::emit<OrderConfigUpdated<T0>>(v1);
            };
        } else {
            let v2 = OrderConfig{
                id                   : 0x2::object::new(arg4),
                min_fee              : arg2,
                min_collateral_value : arg3,
            };
            0x2::dynamic_object_field::add<u64, OrderConfig>(&mut arg1.id, 10003, v2);
            let v3 = OrderConfigUpdated<T0>{
                min_fee              : arg2,
                min_collateral_value : arg3,
            };
            0x2::event::emit<OrderConfigUpdated<T0>>(v3);
        };
    }

    public entry fun set_symbol_funding_rate_to_value<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u128, arg3: bool) {
        abort 0
    }

    entry fun set_symbol_instant_exit_fee_config<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: bool, arg4: u128, arg5: u64, arg6: bool, arg7: u128, arg8: u64, arg9: bool, arg10: u128, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<SymbolName<T1, T2>>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0);
            v1.instant_exit_fee_config = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::set_position_instant_exit_fee_config(&mut v1.instant_exit_fee_config, arg2, arg3, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg4), arg5, arg6, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg7), arg8, arg9, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg10));
        } else {
            let v2 = SymbolConfig{
                id                                    : 0x2::object::new(arg11),
                max_opening_size                      : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
                max_opening_size_enabled              : false,
                max_opening_size_per_position         : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
                max_opening_size_per_position_enabled : false,
                instant_exit_fee_config               : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::new_position_instant_exit_fee_config(arg2, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg4), arg3, arg5, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg7), arg6, arg8, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg10), arg9),
            };
            0x2::dynamic_object_field::add<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0, v2);
        };
    }

    entry fun set_symbol_max_opening_size<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<SymbolName<T1, T2>>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0);
            v1.max_opening_size = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg2);
            v1.max_opening_size_enabled = arg3;
        } else {
            let v2 = SymbolConfig{
                id                                    : 0x2::object::new(arg4),
                max_opening_size                      : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg2),
                max_opening_size_enabled              : arg3,
                max_opening_size_per_position         : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
                max_opening_size_per_position_enabled : false,
                instant_exit_fee_config               : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::default_position_instant_exit_fee_config(),
            };
            0x2::dynamic_object_field::add<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0, v2);
        };
    }

    entry fun set_symbol_max_opening_size_per_position<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        if (0x2::dynamic_object_field::exists_<SymbolName<T1, T2>>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0);
            v1.max_opening_size_per_position = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg2);
            v1.max_opening_size_per_position_enabled = arg3;
        } else {
            let v2 = SymbolConfig{
                id                                    : 0x2::object::new(arg4),
                max_opening_size                      : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
                max_opening_size_enabled              : false,
                max_opening_size_per_position         : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg2),
                max_opening_size_per_position_enabled : arg3,
                instant_exit_fee_config               : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position::default_position_instant_exit_fee_config(),
            };
            0x2::dynamic_object_field::add<SymbolName<T1, T2>, SymbolConfig>(&mut arg1.id, v0, v2);
        };
    }

    public entry fun set_symbol_status<T0, T1, T2>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: bool, arg3: bool, arg4: bool) {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::set_symbol_status(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg1.symbols, v0), arg2, arg3, arg4);
        let v1 = SymbolStatusUpdated<T1, T2>{
            open_enabled      : arg2,
            decrease_enabled  : arg3,
            liquidate_enabled : arg4,
        };
        0x2::event::emit<SymbolStatusUpdated<T1, T2>>(v1);
    }

    public entry fun set_vault_status<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: bool) {
        let v0 = VaultName<T1>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::set_vault_status<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0), arg2);
        let v1 = VaultStatusUpdated<T1>{enabled: arg2};
        0x2::event::emit<VaultStatusUpdated<T1>>(v1);
    }

    public entry fun set_vault_weight<T0, T1>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256) {
        let v0 = VaultName<T1>{dummy_field: false};
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::set_vault_weight<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg1.vaults, v0), arg2);
        let v1 = VaultWeightUpdated<T1>{weight: arg2};
        0x2::event::emit<VaultWeightUpdated<T1>>(v1);
    }

    fun start_rebate_for_tier(arg0: u8) : u64 {
        if (arg0 == 0) {
            20
        } else if (arg0 == 1) {
            15
        } else if (arg0 == 2) {
            12
        } else {
            0
        }
    }

    public fun symbol<T0, T1, T2>(arg0: &Market<T0>) : &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::borrow<SymbolName<T1, T2>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&arg0.symbols, v0)
    }

    public entry fun update_market_fun_mask<T0>(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fun_mask = arg2;
        let v0 = MarketFunMaskUpdated{fun_mask: arg2};
        0x2::event::emit<MarketFunMaskUpdated>(v0);
    }

    fun validate_config_fee_rate(arg0: u256) {
        assert!(arg0 >= 10000000000000000 && arg0 <= 500000000000000000, 22);
    }

    public fun valuate_symbol<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &mut SymbolsValuation) {
        assert!(arg0.fun_mask & 262144 == 0, 1);
        abort 0
    }

    public fun valuate_symbol_v1_1<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::FundingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut SymbolsValuation) {
        assert!(arg0.fun_mask & 268435456 == 0, 1);
        let v0 = arg3.timestamp;
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Symbol>(&mut arg0.symbols, v1);
        let v3 = 0x1::type_name::get<SymbolName<T1, T2>>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.handled, &v3), 8);
        let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::symbol_price_config(v2), arg2, v0);
        arg3.value = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::add(arg3.value, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::valuate_symbol(v2, arg1, &v4, parse_direction<T2>(), arg3.lp_supply_amount, v0));
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg3.handled, v3);
    }

    public fun valuate_vault<T0, T1>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &mut VaultsValuation) {
        assert!(arg0.fun_mask & 131072 == 0, 1);
        abort 0
    }

    public fun valuate_vault_v1_1<T0, T1>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::ReservingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut VaultsValuation) {
        assert!(arg0.fun_mask & 134217728 == 0, 1);
        let v0 = arg3.timestamp;
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg0.vaults, v1);
        let v3 = 0x1::type_name::get<VaultName<T1>>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, VaultInfo>(&arg3.handled, &v3), 7);
        let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::parse_pyth_feeder_v1_1(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_price_config<T1>(v2), arg2, v0);
        let v5 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::valuate_vault<T1>(v2, arg1, &v4, v0);
        arg3.value = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(arg3.value, v5);
        arg3.total_weight = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(arg3.total_weight, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::vault_weight<T1>(v2));
        let v6 = VaultInfo{
            price : v4,
            value : v5,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, VaultInfo>(&mut arg3.handled, v3, v6);
    }

    public fun vault<T0, T1>(arg0: &Market<T0>) : &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1> {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::borrow<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&arg0.vaults, v0)
    }

    public fun withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 8192 == 0, 1);
        let v0 = withdraw_ptb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = 0x2::tx_context::sender(arg6);
        pay_from_balance<T1>(0x2::coin::into_balance<T1>(v0), v1, arg6);
    }

    public fun withdraw_ptb<T0, T1>(arg0: &mut Market<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.fun_mask & 1125899906842624 == 0, 1);
        assert!(0x2::object::id<0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 12);
        check_version<T0>(arg0);
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
        let (v14, v15) = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::withdraw<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::pool::Vault<T1>>(&mut arg0.vaults, v12), arg1, &v11, v13, arg3, v0, v4, v10, v3, v2);
        let v16 = v14;
        let v17 = Withdrawn<T1>{
            burner          : 0x2::tx_context::sender(arg6),
            price           : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(&v11),
            withdraw_amount : 0x2::balance::value<T1>(&v16),
            burn_amount     : v13,
            fee_value       : v15,
        };
        0x2::event::emit<Withdrawn<T1>>(v17);
        0x2::coin::from_balance<T1>(v16, arg6)
    }

    // decompiled from Move bytecode v6
}

