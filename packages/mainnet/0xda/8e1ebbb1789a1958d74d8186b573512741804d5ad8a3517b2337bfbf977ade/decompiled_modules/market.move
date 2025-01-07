module 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        fun_mask: u256,
        vaults_locked: bool,
        symbols_locked: bool,
        rebate_rate: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate,
        rebase_fee_model: 0x2::object::ID,
        referrals: 0x2::table::Table<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>,
        vaults: 0x2::bag::Bag,
        symbols: 0x2::bag::Bag,
        positions: 0x2::bag::Bag,
        orders: 0x2::bag::Bag,
        lp_supply: 0x2::balance::Supply<T0>,
    }

    struct WrappedPositionConfig<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        enabled: bool,
        inner: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::PositionConfig,
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
    }

    struct VaultCreated<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct SymbolCreated<phantom T0, phantom T1> has copy, drop {
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

    struct FeeConfigUpdated<phantom T0> has copy, drop {
        fee_rate_percent: u8,
        fee_collector: address,
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

    struct RebateRateUpdated has copy, drop {
        rebate_rate: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate,
    }

    struct ReferralAdded has copy, drop {
        owner: address,
        referrer: address,
        rebate_rate: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate,
    }

    struct PositionClaimed<T0: copy + drop, T1: copy + drop> has copy, drop {
        position_name: 0x1::option::Option<T0>,
        event: T1,
    }

    struct Deposited<phantom T0> has copy, drop {
        minter: address,
        price: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
        deposit_amount: u64,
        mint_amount: u64,
        fee_value: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
    }

    struct Withdrawn<phantom T0> has copy, drop {
        burner: address,
        price: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
        withdraw_amount: u64,
        burn_amount: u64,
        fee_value: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
    }

    struct Swapped<phantom T0, phantom T1> has copy, drop {
        swapper: address,
        source_price: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
        dest_price: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
        source_amount: u64,
        dest_amount: u64,
        fee_value: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
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
        price: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::AggPrice,
        value: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
    }

    struct VaultsValuation {
        timestamp: u64,
        num: u64,
        handled: 0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>,
        total_weight: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
        value: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
    }

    struct SymbolsValuation {
        timestamp: u64,
        num: u64,
        lp_supply_amount: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal,
        handled: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        value: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::sdecimal::SDecimal,
    }

    public fun swap<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 16384 == 0, 1);
        assert!(0x2::object::id<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 12);
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
        let (v18, v19) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::swap_in<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg0.vaults, v17), arg1, &v10, 0x2::coin::into_balance<T1>(arg2), v9, v3, v2);
        let v20 = VaultName<T2>{dummy_field: false};
        let (v21, v22) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::swap_out<T2>(0x2::bag::borrow_mut<VaultName<T2>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T2>>(&mut arg0.vaults, v20), arg1, &v16, arg3, v18, v15, v3, v2);
        let v23 = v21;
        pay_from_balance<T2>(v23, v0, arg5);
        let v24 = Swapped<T1, T2>{
            swapper       : v0,
            source_price  : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v10),
            dest_price    : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v16),
            source_amount : 0x2::coin::value<T1>(&arg2),
            dest_amount   : 0x2::balance::value<T2>(&v23),
            fee_value     : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::add(v19, v22),
        };
        0x2::event::emit<Swapped<T1, T2>>(v24);
    }

    public fun estimate_fee<T0>(arg0: &Market<T0>, arg1: u64) : u64 {
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::estimate_fee(0x2::dynamic_object_field::borrow<u64, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::FeeConfig>(&arg0.id, 10001), arg1)
    }

    public entry fun add_collateral_to_symbol<T0, T1, T2, T3>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SymbolName<T2, T3>{dummy_field: false};
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::add_collateral_to_symbol<T1>(0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v0));
        let v1 = CollateralAdded<T1, T2, T3>{dummy_field: false};
        0x2::event::emit<CollateralAdded<T1, T2, T3>>(v1);
    }

    public entry fun add_new_referral<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 1 == 0, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>(&arg0.referrals, v0), 3);
        0x2::table::add<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>(&mut arg0.referrals, v0, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::new_referral(arg1, arg0.rebate_rate));
    }

    public entry fun add_new_referral_v1_1<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 536870912 == 0, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>(&arg0.referrals, v0), 3);
        0x2::table::add<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>(&mut arg0.referrals, v0, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::new_referral(arg1, arg0.rebate_rate));
        let v1 = ReferralAdded{
            owner       : v0,
            referrer    : arg1,
            rebate_rate : arg0.rebate_rate,
        };
        0x2::event::emit<ReferralAdded>(v1);
    }

    public entry fun add_new_symbol<T0, T1, T2>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: u256, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u256, arg12: u128, arg13: u128, arg14: u128, arg15: u128, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedPositionConfig<T1, T2>{
            id      : 0x2::object::new(arg16),
            enabled : true,
            inner   : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::new_position_config(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15),
        };
        0x2::transfer::share_object<WrappedPositionConfig<T1, T2>>(v0);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::add<SymbolName<T1, T2>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v1, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::new_symbol(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::create_funding_fee_model(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg6), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::from_raw(arg7), arg16), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::new_agg_price_config<T1>(arg2, arg3, arg4, arg5)));
        let v2 = SymbolCreated<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolCreated<T1, T2>>(v2);
    }

    public entry fun add_new_symbol_v1_1<T0, T1, T2>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: u256, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u256, arg12: u128, arg13: u128, arg14: u128, arg15: u128, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = WrappedPositionConfig<T1, T2>{
            id      : 0x2::object::new(arg16),
            enabled : true,
            inner   : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::new_position_config(arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15),
        };
        0x2::transfer::share_object<WrappedPositionConfig<T1, T2>>(v0);
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::add<SymbolName<T1, T2>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v1, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::new_symbol(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::create_funding_fee_model(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg6), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::from_raw(arg7), arg16), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::new_agg_price_config_v1_1<T1>(arg2, arg3, arg4, arg5)));
        let v2 = SymbolCreated<T1, T2>{dummy_field: false};
        0x2::event::emit<SymbolCreated<T1, T2>>(v2);
    }

    public entry fun add_new_vault<T0, T1>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u64, arg4: u64, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::add<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v0, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::new_vault<T1>(arg2, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::create_reserving_fee_model(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg7), arg8), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::new_agg_price_config<T1>(arg3, arg4, arg5, arg6)));
        let v1 = VaultCreated<T1>{dummy_field: false};
        0x2::event::emit<VaultCreated<T1>>(v1);
    }

    public entry fun add_new_vault_v1_1<T0, T1>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: u256, arg3: u64, arg4: u64, arg5: &0x2::coin::CoinMetadata<T1>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u256, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::add<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v0, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::new_vault<T1>(arg2, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::create_reserving_fee_model(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg7), arg8), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::new_agg_price_config_v1_1<T1>(arg3, arg4, arg5, arg6)));
        let v1 = VaultCreated<T1>{dummy_field: false};
        0x2::event::emit<VaultCreated<T1>>(v1);
    }

    public entry fun clear_closed_position<T0, T1, T2, T3>(arg0: &mut Market<T0>, arg1: PositionCap<T1, T2, T3>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 128 == 0, 1);
        let PositionCap { id: v0 } = arg1;
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v0),
            owner : 0x2::tx_context::sender(arg2),
        };
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg0.positions, v1));
        0x2::object::delete(v0);
    }

    public entry fun clear_closed_position_v1_1<T0, T1, T2, T3>(arg0: &mut Market<T0>, arg1: PositionCap<T1, T2, T3>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 1073741824 == 0, 1);
        let PositionCap { id: v0 } = arg1;
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&v0),
            owner : 0x2::tx_context::sender(arg2),
        };
        if (0x2::bag::contains<PositionName<T1, T2, T3>>(&arg0.positions, v1)) {
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg0.positions, v1));
        };
        0x2::object::delete(v0);
    }

    public entry fun clear_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 2048 == 0, 1);
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
        pay_from_balance<T4>(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::destroy_decrease_position_order<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::DecreasePositionOrder<T4>>(&mut arg0.orders, v4)), v0, arg2);
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
        pay_from_balance<T4>(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::destroy_decrease_position_order_v1_1<T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::DecreasePositionOrderV1_1<T4>>(&mut arg0.orders, v4)), v0, arg2);
    }

    public entry fun clear_open_position_order<T0, T1, T2, T3, T4>(arg0: &mut Market<T0>, arg1: OrderCap<T1, T2, T3, T4>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 1024 == 0, 1);
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
        let (v5, v6) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::destroy_open_position_order<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::OpenPositionOrder<T1, T4>>(&mut arg0.orders, v4));
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
        let (v5, v6) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::destroy_open_position_order_v1_1<T1, T4>(0x2::bag::remove<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::OpenPositionOrderV1_1<T1, T4>>(&mut arg0.orders, v4));
        0x2::object::delete(v3);
        let v7 = OrderCleared<OrderName<T1, T2, T3, T4>>{order_name: v4};
        0x2::event::emit<OrderCleared<OrderName<T1, T2, T3, T4>>>(v7);
        pay_from_balance<T1>(v5, v0, arg2);
        pay_from_balance<T4>(v6, v0, arg2);
    }

    public(friend) fun create_market<T0>(arg0: 0x2::balance::Supply<T0>, arg1: 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Market<T0>{
            id               : 0x2::object::new(arg2),
            fun_mask         : 0,
            vaults_locked    : false,
            symbols_locked   : false,
            rebate_rate      : arg1,
            rebase_fee_model : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::create_rebase_fee_model(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::from_permyriad(1), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(10000000000000000), arg2),
            referrals        : 0x2::table::new<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>(arg2),
            vaults           : 0x2::bag::new(arg2),
            symbols          : 0x2::bag::new(arg2),
            positions        : 0x2::bag::new(arg2),
            orders           : 0x2::bag::new(arg2),
            lp_supply        : arg0,
        };
        let v1 = MarketCreated{
            referrals_parent : 0x2::object::id<0x2::table::Table<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>>(&v0.referrals),
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
            value            : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::sdecimal::zero(),
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
            total_weight : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::zero(),
            value        : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::zero(),
        }
    }

    public entry fun decrease_position<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &mut PositionCap<T1, T2, T3>, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg4: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 4 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg13);
        let v2 = parse_direction<T3>();
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v3);
        let v5 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v6 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v4), arg6, v0);
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::from_price(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v4), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg12));
        let v8 = if (v2) {
            let v9 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v6);
            let v10 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v7);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::lt(&v9, &v10)
        } else {
            let v11 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v6);
            let v12 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v7);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::gt(&v11, &v12)
        };
        if (v8 || !arg9) {
            assert!(arg8 < 2, 5);
            let v13 = 0x2::object::new(arg13);
            let v14 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v13),
                owner       : v1,
                position_id : 0x1::option::some<0x2::object::ID>(v5.id),
            };
            let (v15, v16) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::new_decrease_position_order<T4>(v0, arg9, arg10, v7, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg11), 0x2::coin::into_balance<T4>(arg7));
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::DecreasePositionOrder<T4>>(&mut arg1.orders, v14, v15);
            let v17 = OrderCap<T1, T2, T3, T4>{
                id          : v13,
                position_id : v14.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v17, v1);
            let v18 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::CreateDecreasePositionOrderEvent>{
                order_name : v14,
                event      : v16,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::CreateDecreasePositionOrderEvent>>(v18);
        } else {
            assert!(arg8 > 0, 6);
            let v19 = VaultName<T1>{dummy_field: false};
            let v20 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v19);
            let v21 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v20), arg5, v0);
            let (v22, v23) = get_referral_data_v1(&arg1.id, &arg1.referrals, v1);
            let (v24, v25, _) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::decrease_position<T1>(v20, v4, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v5), arg3, arg4, &v21, &v6, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg11), v22, v2, arg10, lp_supply_amount<T0>(arg1), v0);
            assert!(v24 == 0, v24);
            let (v27, v28, v29) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_decrease_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionResult<T1>>(v25));
            pay_from_balance<T1>(v27, v1, arg13);
            pay_fee_split_from_referral<T1>(&arg1.id, v23, v28, arg13);
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg7, v1);
            let v30 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v5),
                event         : v29,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>>(v30);
        };
    }

    public entry fun decrease_position_v1_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &mut PositionCap<T1, T2, T3>, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg4: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T4>, arg8: u8, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 1048576 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg13);
        let v2 = parse_direction<T3>();
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v3);
        let v5 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v6 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v4), arg6, v0);
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg12);
        let v8 = if (v2) {
            let v9 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v6);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::lt(&v9, &v7)
        } else {
            let v10 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v6);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::gt(&v10, &v7)
        };
        if (v8 || !arg9) {
            assert!(arg8 < 2, 5);
            let v11 = 0x2::object::new(arg13);
            let v12 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v11),
                owner       : v1,
                position_id : 0x1::option::some<0x2::object::ID>(v5.id),
            };
            let (v13, v14) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::new_decrease_position_order_v1_1<T4>(v0, arg9, arg10, v7, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg11), 0x2::coin::into_balance<T4>(arg7));
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::DecreasePositionOrderV1_1<T4>>(&mut arg1.orders, v12, v13);
            let v15 = OrderCap<T1, T2, T3, T4>{
                id          : v11,
                position_id : v12.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v15, v1);
            let v16 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::CreateDecreasePositionOrderEvent>{
                order_name : v12,
                event      : v14,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::CreateDecreasePositionOrderEvent>>(v16);
        } else {
            assert!(arg8 > 0, 6);
            let v17 = VaultName<T1>{dummy_field: false};
            let v18 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v17);
            let v19 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v18), arg5, v0);
            let (v20, v21) = get_referral_data_v1(&arg1.id, &arg1.referrals, v1);
            let (v22, v23, _) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::decrease_position<T1>(v18, v4, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v5), arg3, arg4, &v19, &v6, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg11), v20, v2, arg10, lp_supply_amount<T0>(arg1), v0);
            assert!(v22 == 0, v22);
            let (v25, v26, v27) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_decrease_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionResult<T1>>(v23));
            pay_from_balance<T1>(v25, v1, arg13);
            pay_fee_split_from_referral<T1>(&arg1.id, v21, v26, arg13);
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg7, v1);
            let v28 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v5),
                event         : v27,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>>(v28);
        };
    }

    public entry fun decrease_reserved_from_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 8 == 0, 1);
        let v0 = VaultName<T1>{dummy_field: false};
        let v1 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : 0x2::tx_context::sender(arg5),
        };
        let v2 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreaseReservedFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v1),
            event         : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::decrease_reserved_from_position<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v0), 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v1), arg3, arg4, 0x2::clock::timestamp_ms(arg0) / 1000),
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreaseReservedFromPositionEvent>>(v2);
    }

    public fun deposit<T0, T1>(arg0: &mut Market<T0>, arg1: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 4096 == 0, 1);
        assert!(0x2::object::id<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 12);
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
        let (v14, v15) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::deposit<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg0.vaults, v13), arg1, &v12, 0x2::coin::into_balance<T1>(arg2), arg3, v1, v5, v11, v4, v3);
        pay_from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, v14), v0, arg6);
        let v16 = Deposited<T1>{
            minter         : v0,
            price          : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v12),
            deposit_amount : 0x2::coin::value<T1>(&arg2),
            mint_amount    : v14,
            fee_value      : v15,
        };
        0x2::event::emit<Deposited<T1>>(v16);
    }

    public entry fun execute_decrease_position_order<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 512 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
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
        let v5 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v4);
        let v6 = SymbolName<T2, T3>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v6);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v5), arg4, v0);
        let v9 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v7), arg5, v0);
        let (v10, v11) = get_referral_data_v1(&arg1.id, &arg1.referrals, arg6);
        let (v12, v13, v14, v15) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::execute_decrease_position_order<T1, T4>(0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::DecreasePositionOrder<T4>>(&mut arg1.orders, v3), v5, v7, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v2), arg2, arg3, &v8, &v9, v10, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        if (v12 == 0) {
            let (v16, v17, v18) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_decrease_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionResult<T1>>(v13));
            pay_from_balance<T1>(v16, arg6, arg9);
            pay_fee_split_from_referral<T1>(&arg1.id, v11, v17, arg9);
            let v19 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v2),
                event         : v18,
            };
            let v20 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>>{
                executor   : v1,
                order_name : v3,
                claim      : v19,
            };
            0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>>>(v20);
        } else {
            0x1::option::destroy_none<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionResult<T1>>(v13);
            let v21 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionFailedEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v2),
                event         : 0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionFailedEvent>(v14),
            };
            let v22 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionFailedEvent>>{
                executor   : v1,
                order_name : v3,
                claim      : v21,
            };
            0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionFailedEvent>>>(v22);
        };
        pay_from_balance<T4>(v15, v1, arg9);
    }

    public entry fun execute_decrease_position_order_v1_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 16777216 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
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
        let v5 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v4);
        let v6 = SymbolName<T2, T3>{dummy_field: false};
        let v7 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v6);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v5), arg4, v0);
        let v9 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v7), arg5, v0);
        let (v10, v11) = get_referral_data_v1(&arg1.id, &arg1.referrals, arg6);
        let (v12, v13, v14, v15) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::execute_decrease_position_order_v1_1<T1, T4>(0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::DecreasePositionOrderV1_1<T4>>(&mut arg1.orders, v3), v5, v7, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v2), arg2, arg3, &v8, &v9, v10, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        if (v12 == 0) {
            let (v16, v17, v18) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_decrease_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionResult<T1>>(v13));
            pay_from_balance<T1>(v16, arg6, arg9);
            pay_fee_split_from_referral<T1>(&arg1.id, v11, v17, arg9);
            let v19 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v2),
                event         : v18,
            };
            let v20 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>>{
                executor   : v1,
                order_name : v3,
                claim      : v19,
            };
            0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>>>(v20);
        } else {
            0x1::option::destroy_none<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionResult<T1>>(v13);
            let v21 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionFailedEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v2),
                event         : 0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionFailedEvent>(v14),
            };
            let v22 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionFailedEvent>>{
                executor   : v1,
                order_name : v3,
                claim      : v21,
            };
            0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionFailedEvent>>>(v22);
        };
        pay_from_balance<T4>(v15, v1, arg9);
    }

    public entry fun execute_open_position_order<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 256 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg7),
            owner       : arg6,
            position_id : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = VaultName<T1>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v3);
        let v5 = SymbolName<T2, T3>{dummy_field: false};
        let v6 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v5);
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v4), arg4, v0);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v6), arg5, v0);
        let (v9, v10) = get_referral_data_v1(&arg1.id, &arg1.referrals, arg6);
        let (v11, v12, v13, v14) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::execute_open_position_order<T1, T4>(0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::OpenPositionOrder<T1, T4>>(&mut arg1.orders, v2), v4, v6, arg2, arg3, &v7, &v8, v9, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        if (v11 == 0) {
            let (v15, v16, v17) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_open_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionResult<T1>>(v12));
            let v18 = 0x2::object::new(arg8);
            let v19 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v18),
                owner : arg6,
            };
            0x2::bag::add<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v19, v15);
            let v20 = PositionCap<T1, T2, T3>{id: v18};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v20, arg6);
            pay_fee_split_from_referral<T1>(&arg1.id, v10, v16, arg8);
            let v21 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v19),
                event         : v17,
            };
            let v22 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>>{
                executor   : v1,
                order_name : v2,
                claim      : v21,
            };
            0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>>>(v22);
        } else {
            0x1::option::destroy_none<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionResult<T1>>(v12);
            let v23 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionFailedEvent>{
                position_name : 0x1::option::none<PositionName<T1, T2, T3>>(),
                event         : 0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionFailedEvent>(v13),
            };
            let v24 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionFailedEvent>>{
                executor   : v1,
                order_name : v2,
                claim      : v23,
            };
            0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionFailedEvent>>>(v24);
        };
        pay_from_balance<T4>(v14, v1, arg8);
    }

    public entry fun execute_open_position_order_v1_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 8388608 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = OrderName<T1, T2, T3, T4>{
            id          : 0x2::object::id_from_address(arg7),
            owner       : arg6,
            position_id : 0x1::option::none<0x2::object::ID>(),
        };
        let v3 = VaultName<T1>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v3);
        let v5 = SymbolName<T2, T3>{dummy_field: false};
        let v6 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v5);
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v4), arg4, v0);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v6), arg5, v0);
        let (v9, v10) = get_referral_data_v1(&arg1.id, &arg1.referrals, arg6);
        let (v11, v12, v13, v14) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::execute_open_position_order_v1_1<T1, T4>(0x2::bag::borrow_mut<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::OpenPositionOrderV1_1<T1, T4>>(&mut arg1.orders, v2), v4, v6, arg2, arg3, &v7, &v8, v9, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0);
        if (v11 == 0) {
            let (v15, v16, v17) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_open_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionResult<T1>>(v12));
            let v18 = 0x2::object::new(arg8);
            let v19 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v18),
                owner : arg6,
            };
            0x2::bag::add<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v19, v15);
            let v20 = PositionCap<T1, T2, T3>{id: v18};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v20, arg6);
            pay_fee_split_from_referral<T1>(&arg1.id, v10, v16, arg8);
            let v21 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v19),
                event         : v17,
            };
            let v22 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>>{
                executor   : v1,
                order_name : v2,
                claim      : v21,
            };
            0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>>>(v22);
        } else {
            0x1::option::destroy_none<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionResult<T1>>(v12);
            let v23 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionFailedEvent>{
                position_name : 0x1::option::none<PositionName<T1, T2, T3>>(),
                event         : 0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionFailedEvent>(v13),
            };
            let v24 = OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionFailedEvent>>{
                executor   : v1,
                order_name : v2,
                claim      : v23,
            };
            0x2::event::emit<OrderExecuted<OrderName<T1, T2, T3, T4>, PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionFailedEvent>>>(v24);
        };
        pay_from_balance<T4>(v14, v1, arg8);
    }

    fun finalize_market_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation, arg2: SymbolsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal) {
        let (v0, v1, v2) = finalize_vaults_valuation<T0>(arg0, arg1);
        let v3 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::sdecimal::add_with_decimal(finalize_symbols_valuation<T0>(arg0, arg2), v2);
        assert!(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::sdecimal::is_positive(&v3), 11);
        (v0, v1, v2, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::sdecimal::value(&v3))
    }

    fun finalize_symbols_valuation<T0>(arg0: &mut Market<T0>, arg1: SymbolsValuation) : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::sdecimal::SDecimal {
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

    fun finalize_vaults_valuation<T0>(arg0: &mut Market<T0>, arg1: VaultsValuation) : (0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultInfo>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal) {
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

    public entry fun force_clear_closed_position_v1_1<T0, T1, T2, T3>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: address, arg3: address, arg4: &0x2::tx_context::TxContext) {
        let v0 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg2),
            owner : arg3,
        };
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::destroy_position<T1>(0x2::bag::remove<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v0));
    }

    public entry fun force_close_position_v1_1<T0, T1, T2, T3>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &0x2::clock::Clock, arg2: &mut Market<T0>, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg4: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.vaults_locked && !arg2.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg2.vaults, v1);
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg2.symbols, v3);
        let v5 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg8),
            owner : arg7,
        };
        let v6 = 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg2.positions, v5);
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::position_amount<T1>(v6);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v2), arg5, v0);
        let v9 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v4), arg6, v0);
        let (v10, v11) = get_referral_data_v1(&arg2.id, &arg2.referrals, arg7);
        let (v12, v13, _) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::decrease_position<T1>(v2, v4, v6, arg3, arg4, &v8, &v9, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::zero(), v10, parse_direction<T3>(), v7, lp_supply_amount<T0>(arg2), v0);
        assert!(v12 == 0, v12);
        let (v15, v16, v17) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_decrease_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionResult<T1>>(v13));
        pay_from_balance<T1>(v15, arg7, arg9);
        pay_fee_split_from_referral<T1>(&arg2.id, v11, v16, arg9);
        let v18 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v5),
            event         : v17,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::DecreasePositionSuccessEvent>>(v18);
    }

    fun get_referral_data(arg0: &0x2::table::Table<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>, arg1: address) : (0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate, address) {
        if (0x2::table::contains<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>(arg0, arg1)) {
            let v2 = 0x2::table::borrow<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>(arg0, arg1);
            (0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::get_rebate_rate(v2), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::get_referrer(v2))
        } else {
            (0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::zero(), @0x0)
        }
    }

    fun get_referral_data_v1(arg0: &0x2::object::UID, arg1: &0x2::table::Table<address, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::referral::Referral>, arg2: address) : (0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::Rate, address) {
        let (v0, v1) = get_referral_data(arg1, arg2);
        let v2 = 0x2::dynamic_object_field::borrow<u64, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::FeeConfig>(arg0, 10001);
        if (v1 == @0x0) {
            (0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::add(v0, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::get_fee_rate(v2)), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::get_fee_collector(v2))
        } else {
            (0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::add(v0, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::get_fee_rate(v2)), v1)
        }
    }

    public entry fun liquidate_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg4: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 64 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg7),
            owner : arg6,
        };
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v3), arg4, v0);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v5), arg5, v0);
        let (v9, v10) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::liquidate_position<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v6), arg2, arg3, &v7, &v8, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0, v1);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::LiquidatePositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::LiquidatePositionEvent>>(v11);
    }

    public entry fun liquidate_position_v1_1<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 4194304 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::id_from_address(arg7),
            owner : arg6,
        };
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v3), arg4, v0);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v5), arg5, v0);
        let (v9, v10) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::liquidate_position_v1_1<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v6), arg2, arg3, &v7, &v8, parse_direction<T3>(), lp_supply_amount<T0>(arg1), v0, v1);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::LiquidatePositionEventV1_1>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::LiquidatePositionEventV1_1>>(v11);
    }

    public fun lp_supply_amount<T0>(arg0: &Market<T0>) : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::Decimal {
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::div_by_u64(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_u64(0x2::balance::supply_value<T0>(&arg0.lp_supply)), 1000000)
    }

    public entry fun open_position<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 2 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = parse_direction<T3>();
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v3);
        let v5 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v4), arg6, v0);
        let v6 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::from_price(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v4), 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg13));
        let v7 = if (v2) {
            let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v5);
            let v9 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v6);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::gt(&v8, &v9)
        } else {
            let v10 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v5);
            let v11 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v6);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::lt(&v10, &v11)
        };
        if (v7) {
            assert!(arg9 < 2, 5);
            let v12 = 0x2::object::new(arg14);
            let v13 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v12),
                owner       : v1,
                position_id : 0x1::option::none<0x2::object::ID>(),
            };
            let (v14, v15) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::new_open_position_order<T1, T4>(v0, arg10, arg11, v6, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg12), arg4.inner, 0x2::coin::into_balance<T1>(arg7), 0x2::coin::into_balance<T4>(arg8));
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::OpenPositionOrder<T1, T4>>(&mut arg1.orders, v13, v14);
            let v16 = OrderCap<T1, T2, T3, T4>{
                id          : v12,
                position_id : v13.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v16, v1);
            let v17 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::CreateOpenPositionOrderEvent>{
                order_name : v13,
                event      : v15,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::CreateOpenPositionOrderEvent>>(v17);
        } else {
            assert!(arg9 > 0, 6);
            let v18 = VaultName<T1>{dummy_field: false};
            let v19 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v18);
            let v20 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v19), arg5, v0);
            let (v21, v22) = get_referral_data_v1(&arg1.id, &arg1.referrals, v1);
            let v23 = 0x2::object::new(arg14);
            let v24 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v23),
                owner : v1,
            };
            let v25 = 0x2::coin::into_balance<T1>(arg7);
            let (v26, v27, _) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::open_position<T1>(v19, v4, arg2, arg3, &arg4.inner, &v20, &v5, &mut v25, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg12), v21, v2, arg10, arg11, lp_supply_amount<T0>(arg1), v0);
            assert!(v26 == 0, v26);
            0x2::balance::destroy_zero<T1>(v25);
            let (v29, v30, v31) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_open_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionResult<T1>>(v27));
            0x2::bag::add<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v24, v29);
            let v32 = PositionCap<T1, T2, T3>{id: v23};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v32, v1);
            pay_fee_split_from_referral<T1>(&arg1.id, v22, v30, arg14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, v1);
            let v33 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v24),
                event         : v31,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>>(v33);
        };
    }

    public entry fun open_position_v1_1<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg4: &WrappedPositionConfig<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: 0x2::coin::Coin<T1>, arg8: 0x2::coin::Coin<T4>, arg9: u8, arg10: u64, arg11: u64, arg12: u256, arg13: u256, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 524288 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg14);
        let v2 = parse_direction<T3>();
        let v3 = SymbolName<T2, T3>{dummy_field: false};
        let v4 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v3);
        let v5 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v4), arg6, v0);
        let v6 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg13);
        let v7 = if (v2) {
            let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v5);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::gt(&v8, &v6)
        } else {
            let v9 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v5);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::lt(&v9, &v6)
        };
        if (v7) {
            assert!(arg9 < 2, 5);
            let v10 = 0x2::object::new(arg14);
            let v11 = OrderName<T1, T2, T3, T4>{
                id          : 0x2::object::uid_to_inner(&v10),
                owner       : v1,
                position_id : 0x1::option::none<0x2::object::ID>(),
            };
            let (v12, v13) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::new_open_position_order_v1_1<T1, T4>(v0, arg10, arg11, v6, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg12), arg4.inner, 0x2::coin::into_balance<T1>(arg7), 0x2::coin::into_balance<T4>(arg8));
            0x2::bag::add<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::OpenPositionOrderV1_1<T1, T4>>(&mut arg1.orders, v11, v12);
            let v14 = OrderCap<T1, T2, T3, T4>{
                id          : v10,
                position_id : v11.position_id,
            };
            0x2::transfer::transfer<OrderCap<T1, T2, T3, T4>>(v14, v1);
            let v15 = OrderCreated<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::CreateOpenPositionOrderEvent>{
                order_name : v11,
                event      : v13,
            };
            0x2::event::emit<OrderCreated<OrderName<T1, T2, T3, T4>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::orders::CreateOpenPositionOrderEvent>>(v15);
        } else {
            assert!(arg9 > 0, 6);
            let v16 = VaultName<T1>{dummy_field: false};
            let v17 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v16);
            let v18 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v17), arg5, v0);
            let (v19, v20) = get_referral_data_v1(&arg1.id, &arg1.referrals, v1);
            let v21 = 0x2::object::new(arg14);
            let v22 = PositionName<T1, T2, T3>{
                id    : 0x2::object::uid_to_inner(&v21),
                owner : v1,
            };
            let v23 = 0x2::coin::into_balance<T1>(arg7);
            let (v24, v25, _) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::open_position<T1>(v17, v4, arg2, arg3, &arg4.inner, &v18, &v5, &mut v23, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::from_raw(arg12), v19, v2, arg10, arg11, lp_supply_amount<T0>(arg1), v0);
            assert!(v24 == 0, v24);
            0x2::balance::destroy_zero<T1>(v23);
            let (v27, v28, v29) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::unwrap_open_position_result<T1>(0x1::option::destroy_some<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionResult<T1>>(v25));
            0x2::bag::add<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v22, v27);
            let v30 = PositionCap<T1, T2, T3>{id: v21};
            0x2::transfer::transfer<PositionCap<T1, T2, T3>>(v30, v1);
            pay_fee_split_from_referral<T1>(&arg1.id, v20, v28, arg14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(arg8, v1);
            let v31 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>{
                position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v22),
                event         : v29,
            };
            0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::OpenPositionSuccessEvent>>(v31);
        };
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

    fun pay_fee_split_from_referral<T0>(arg0: &0x2::object::UID, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<u64, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::FeeConfig>(arg0, 10001);
        let v1 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::get_fee_collector(v0);
        if (arg1 == v1) {
            pay_from_balance<T0>(arg2, v1, arg3);
        } else {
            pay_from_balance<T0>(0x2::balance::split<T0>(&mut arg2, 0x2::balance::value<T0>(&arg2) / 4), arg1, arg3);
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::pay_fee_directly<T0>(v0, 0x2::coin::from_balance<T0>(arg2, arg3));
        };
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
        let v0 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg1.id),
            owner : 0x2::tx_context::sender(arg3),
        };
        let v1 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::PledgeInPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v0),
            event         : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::pledge_in_position<T1>(0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg0.positions, v0), 0x2::coin::into_balance<T1>(arg2)),
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::PledgeInPositionEvent>>(v1);
    }

    public fun position<T0, T1, T2, T3>(arg0: &Market<T0>, arg1: 0x2::object::ID, arg2: address) : &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1> {
        let v0 = PositionName<T1, T2, T3>{
            id    : arg1,
            owner : arg2,
        };
        0x2::bag::borrow<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&arg0.positions, v0)
    }

    public fun rebase_fee_model<T0>(arg0: &Market<T0>) : &0x2::object::ID {
        &arg0.rebase_fee_model
    }

    public entry fun redeem_from_position<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg4: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg5: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg6: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 32 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v3), arg5, v0);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v5), arg6, v0);
        let (v9, v10) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::redeem_from_position<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v6), arg3, arg4, &v7, &v8, parse_direction<T3>(), arg7, lp_supply_amount<T0>(arg1), v0);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::RedeemFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::RedeemFromPositionEvent>>(v11);
    }

    public entry fun redeem_from_position_v1_1<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &mut Market<T0>, arg2: &PositionCap<T1, T2, T3>, arg3: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg4: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.fun_mask & 2097152 == 0, 1);
        assert!(!arg1.vaults_locked && !arg1.symbols_locked, 2);
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = VaultName<T1>{dummy_field: false};
        let v3 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v2);
        let v4 = SymbolName<T2, T3>{dummy_field: false};
        let v5 = 0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v4);
        let v6 = PositionName<T1, T2, T3>{
            id    : 0x2::object::uid_to_inner(&arg2.id),
            owner : v1,
        };
        let v7 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v3), arg5, v0);
        let v8 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v5), arg6, v0);
        let (v9, v10) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::redeem_from_position<T1>(v3, v5, 0x2::bag::borrow_mut<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::Position<T1>>(&mut arg1.positions, v6), arg3, arg4, &v7, &v8, parse_direction<T3>(), arg7, lp_supply_amount<T0>(arg1), v0);
        pay_from_balance<T1>(v9, v1, arg8);
        let v11 = PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::RedeemFromPositionEvent>{
            position_name : 0x1::option::some<PositionName<T1, T2, T3>>(v6),
            event         : v10,
        };
        0x2::event::emit<PositionClaimed<PositionName<T1, T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::RedeemFromPositionEvent>>(v11);
    }

    public entry fun remove_collateral_from_symbol<T0, T1, T2, T3>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SymbolName<T2, T3>{dummy_field: false};
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::remove_collateral_from_symbol<T1>(0x2::bag::borrow_mut<SymbolName<T2, T3>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v0));
        let v1 = CollateralRemoved<T1, T2, T3>{dummy_field: false};
        0x2::event::emit<CollateralRemoved<T1, T2, T3>>(v1);
    }

    public entry fun replace_position_config<T0, T1>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut WrappedPositionConfig<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u256, arg6: u128, arg7: u128, arg8: u128, arg9: u128) {
        arg1.inner = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::position::new_position_config(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
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

    public entry fun replace_symbol_feeder<T0, T1, T2>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::update_agg_price_config_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::mut_symbol_price_config(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v0)), arg2);
    }

    public entry fun replace_vault_feeder<T0, T1>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = VaultName<T1>{dummy_field: false};
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::update_agg_price_config_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::mut_vault_price_config<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg1.vaults, v0)), arg2);
    }

    public entry fun set_fee_config<T0>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_<u64>(&arg1.id, 10001)) {
            0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::delete_fee_config(0x2::dynamic_object_field::remove<u64, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::FeeConfig>(&mut arg1.id, 10001));
        };
        0x2::dynamic_object_field::add<u64, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::FeeConfig>(&mut arg1.id, 10001, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::fee::new_fee_config(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::from_percent(arg2), arg3, arg4));
        let v0 = FeeConfigUpdated<T0>{
            fee_rate_percent : arg2,
            fee_collector    : arg3,
        };
        0x2::event::emit<FeeConfigUpdated<T0>>(v0);
    }

    public entry fun set_rebate_rate_v1_1<T0>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        arg1.rebate_rate = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::rate::from_raw(arg2);
        let v0 = RebateRateUpdated{rebate_rate: arg1.rebate_rate};
        0x2::event::emit<RebateRateUpdated>(v0);
    }

    public entry fun set_symbol_status<T0, T1, T2>(arg0: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::admin::AdminCap, arg1: &mut Market<T0>, arg2: bool, arg3: bool, arg4: bool) {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::set_symbol_status(0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg1.symbols, v0), arg2, arg3, arg4);
        let v1 = SymbolStatusUpdated<T1, T2>{
            open_enabled      : arg2,
            decrease_enabled  : arg3,
            liquidate_enabled : arg4,
        };
        0x2::event::emit<SymbolStatusUpdated<T1, T2>>(v1);
    }

    public fun symbol<T0, T1, T2>(arg0: &Market<T0>) : &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol {
        let v0 = SymbolName<T1, T2>{dummy_field: false};
        0x2::bag::borrow<SymbolName<T1, T2>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&arg0.symbols, v0)
    }

    public fun valuate_symbol<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &mut SymbolsValuation) {
        assert!(arg0.fun_mask & 262144 == 0, 1);
        let v0 = arg3.timestamp;
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg0.symbols, v1);
        let v3 = 0x1::type_name::get<SymbolName<T1, T2>>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.handled, &v3), 8);
        let v4 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v2), arg2, v0);
        arg3.value = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::sdecimal::add(arg3.value, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::valuate_symbol(v2, arg1, &v4, parse_direction<T2>(), arg3.lp_supply_amount, v0));
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg3.handled, v3);
    }

    public fun valuate_symbol_v1_1<T0, T1, T2>(arg0: &mut Market<T0>, arg1: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::FundingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut SymbolsValuation) {
        assert!(arg0.fun_mask & 268435456 == 0, 1);
        let v0 = arg3.timestamp;
        let v1 = SymbolName<T1, T2>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<SymbolName<T1, T2>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Symbol>(&mut arg0.symbols, v1);
        let v3 = 0x1::type_name::get<SymbolName<T1, T2>>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg3.handled, &v3), 8);
        let v4 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::symbol_price_config(v2), arg2, v0);
        arg3.value = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::sdecimal::add(arg3.value, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::valuate_symbol(v2, arg1, &v4, parse_direction<T2>(), arg3.lp_supply_amount, v0));
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg3.handled, v3);
    }

    public fun valuate_vault<T0, T1>(arg0: &mut Market<T0>, arg1: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg2: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg3: &mut VaultsValuation) {
        assert!(arg0.fun_mask & 131072 == 0, 1);
        let v0 = arg3.timestamp;
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg0.vaults, v1);
        let v3 = 0x1::type_name::get<VaultName<T1>>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, VaultInfo>(&arg3.handled, &v3), 7);
        let v4 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v2), arg2, v0);
        let v5 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::valuate_vault<T1>(v2, arg1, &v4, v0);
        arg3.value = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::add(arg3.value, v5);
        arg3.total_weight = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::add(arg3.total_weight, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_weight<T1>(v2));
        let v6 = VaultInfo{
            price : v4,
            value : v5,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, VaultInfo>(&mut arg3.handled, v3, v6);
    }

    public fun valuate_vault_v1_1<T0, T1>(arg0: &mut Market<T0>, arg1: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::ReservingFeeModel, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &mut VaultsValuation) {
        assert!(arg0.fun_mask & 134217728 == 0, 1);
        let v0 = arg3.timestamp;
        let v1 = VaultName<T1>{dummy_field: false};
        let v2 = 0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg0.vaults, v1);
        let v3 = 0x1::type_name::get<VaultName<T1>>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, VaultInfo>(&arg3.handled, &v3), 7);
        let v4 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::parse_pyth_feeder_v1_1(0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_price_config<T1>(v2), arg2, v0);
        let v5 = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::valuate_vault<T1>(v2, arg1, &v4, v0);
        arg3.value = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::add(arg3.value, v5);
        arg3.total_weight = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::decimal::add(arg3.total_weight, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::vault_weight<T1>(v2));
        let v6 = VaultInfo{
            price : v4,
            value : v5,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, VaultInfo>(&mut arg3.handled, v3, v6);
    }

    public fun vault<T0, T1>(arg0: &Market<T0>) : &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1> {
        let v0 = VaultName<T1>{dummy_field: false};
        0x2::bag::borrow<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&arg0.vaults, v0)
    }

    public fun withdraw<T0, T1>(arg0: &mut Market<T0>, arg1: &0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::RebaseFeeModel, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: VaultsValuation, arg5: SymbolsValuation, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.fun_mask & 8192 == 0, 1);
        assert!(0x2::object::id<0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::model::RebaseFeeModel>(arg1) == arg0.rebase_fee_model, 12);
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
        let (v15, v16) = 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::withdraw<T1>(0x2::bag::borrow_mut<VaultName<T1>, 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::pool::Vault<T1>>(&mut arg0.vaults, v13), arg1, &v12, v14, arg3, v1, v5, v11, v4, v3);
        let v17 = v15;
        pay_from_balance<T1>(v17, v0, arg6);
        let v18 = Withdrawn<T1>{
            burner          : v0,
            price           : 0xceab84acf6bf70f503c3b0627acaff6b3f84cee0f2d7ed53d00fa6c2a168d14f::agg_price::price_of(&v12),
            withdraw_amount : 0x2::balance::value<T1>(&v17),
            burn_amount     : v14,
            fee_value       : v16,
        };
        0x2::event::emit<Withdrawn<T1>>(v18);
    }

    // decompiled from Move bytecode v6
}

