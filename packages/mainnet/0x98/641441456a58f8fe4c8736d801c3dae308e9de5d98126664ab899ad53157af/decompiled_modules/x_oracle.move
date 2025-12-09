module 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle {
    struct X_ORACLE has drop {
        dummy_field: bool,
    }

    struct XOracle has key {
        id: 0x2::object::UID,
        primary_price_update_policy: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::PriceUpdatePolicy,
        secondary_price_update_policy: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::PriceUpdatePolicy,
        prices: 0x2::table::Table<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>,
        ema_prices: 0x2::table::Table<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>,
        gr_coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        gr_indicator_value_u64: u64,
        gr_indicator_last_updated: u64,
        xaum_coin_type: 0x1::option::Option<0x1::type_name::TypeName>,
        xaum_ema120_value_u64: u64,
        xaum_ema90_value_u64: u64,
        xaum_spot_value_u64: u64,
        gr_svalue_u64: u64,
        gr_computed_value_u64: u64,
        gr_alpha_fp: u64,
        gr_beta_fp: u64,
        admin_address: 0x1::option::Option<address>,
    }

    struct XOracleOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct XOracleAdminCap has store, key {
        id: 0x2::object::UID,
        admin_address: address,
    }

    struct XOraclePolicyCap has store, key {
        id: 0x2::object::UID,
        primary_price_update_policy_cap: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::PriceUpdatePolicyCap,
        secondary_price_update_policy_cap: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::PriceUpdatePolicyCap,
    }

    struct GrIndicatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct PolicyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GrIndicatorCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct XOraclePriceUpdateRequest<phantom T0> {
        primary_price_update_request: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::PriceUpdateRequest<T0>,
        secondary_price_update_request: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::PriceUpdateRequest<T0>,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (XOracle, XOraclePolicyCap) {
        let (v0, v1) = 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::new(arg0);
        let (v2, v3) = 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::new(arg0);
        let v4 = XOracle{
            id                            : 0x2::object::new(arg0),
            primary_price_update_policy   : v0,
            secondary_price_update_policy : v2,
            prices                        : 0x2::table::new<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(arg0),
            ema_prices                    : 0x2::table::new<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(arg0),
            gr_coin_type                  : 0x1::option::none<0x1::type_name::TypeName>(),
            gr_indicator_value_u64        : 0,
            gr_indicator_last_updated     : 0,
            xaum_coin_type                : 0x1::option::none<0x1::type_name::TypeName>(),
            xaum_ema120_value_u64         : 0,
            xaum_ema90_value_u64          : 0,
            xaum_spot_value_u64           : 0,
            gr_svalue_u64                 : 0,
            gr_computed_value_u64         : 0,
            gr_alpha_fp                   : 0,
            gr_beta_fp                    : 0,
            admin_address                 : 0x1::option::none<address>(),
        };
        let v5 = XOraclePolicyCap{
            id                                : 0x2::object::new(arg0),
            primary_price_update_policy_cap   : v1,
            secondary_price_update_policy_cap : v3,
        };
        (v4, v5)
    }

    public fun add_primary_price_update_rule<T0: drop>(arg0: &mut XOracle, arg1: &XOracleAdminCap) {
        verify_admin(arg0, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::add_rule_by_id<T0>(&mut arg0.primary_price_update_policy, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::for_policy(&borrow_policy_cap(arg0).primary_price_update_policy_cap));
    }

    public fun add_primary_price_update_rule_v2<T0, T1: drop>(arg0: &mut XOracle, arg1: &XOracleAdminCap) {
        verify_admin(arg0, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::add_rule_v2_by_id<T0, T1>(&mut arg0.primary_price_update_policy, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::for_policy(&borrow_policy_cap(arg0).primary_price_update_policy_cap));
    }

    public fun add_secondary_price_update_rule<T0: drop>(arg0: &mut XOracle, arg1: &XOracleAdminCap) {
        verify_admin(arg0, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::add_rule_by_id<T0>(&mut arg0.secondary_price_update_policy, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::for_policy(&borrow_policy_cap(arg0).secondary_price_update_policy_cap));
    }

    public fun add_secondary_price_update_rule_v2<T0, T1: drop>(arg0: &mut XOracle, arg1: &XOracleAdminCap) {
        verify_admin(arg0, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::add_rule_v2_by_id<T0, T1>(&mut arg0.secondary_price_update_policy, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::for_policy(&borrow_policy_cap(arg0).secondary_price_update_policy_cap));
    }

    public fun admin_address(arg0: &XOracle) : 0x1::option::Option<address> {
        arg0.admin_address
    }

    fun borrow_policy_cap(arg0: &XOracle) : &XOraclePolicyCap {
        let v0 = PolicyCapKey{dummy_field: false};
        0x2::dynamic_field::borrow<PolicyCapKey, XOraclePolicyCap>(&arg0.id, v0)
    }

    public fun confirm_price_update_request<T0>(arg0: &mut XOracle, arg1: XOraclePriceUpdateRequest<T0>, arg2: &0x2::clock::Clock) {
        let XOraclePriceUpdateRequest {
            primary_price_update_request   : v0,
            secondary_price_update_request : v1,
        } = arg1;
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&arg0.prices, v2)) {
            0x2::table::add<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&mut arg0.prices, v2, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::new(0, 0));
        };
        let v3 = determine_price(0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::confirm_request<T0>(v0, &arg0.primary_price_update_policy), 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::confirm_request<T0>(v1, &arg0.secondary_price_update_policy));
        let v4 = if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.gr_coin_type)) {
            if (v2 == *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.gr_coin_type)) {
                arg0.gr_computed_value_u64 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v5 = if (v4) {
            arg0.gr_computed_value_u64
        } else {
            0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::value(&v3)
        };
        *0x2::table::borrow_mut<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&mut arg0.prices, 0x1::type_name::with_defining_ids<T0>()) = 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::new(v5, 0x2::clock::timestamp_ms(arg2) / 1000);
    }

    fun determine_price(arg0: vector<0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>, arg1: vector<0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>) : 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed {
        assert!(0x1::vector::length<0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&arg0) == 1, 721);
        let v0 = 0x1::vector::pop_back<0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&mut arg0);
        let v1 = 0x1::vector::length<0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&arg1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v1) {
            if (price_feed_match(v0, 0x1::vector::pop_back<0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&mut arg1))) {
                v2 = v2 + 1;
            };
            v3 = v3 + 1;
        };
        assert!(v2 >= (v1 + 1) / 2, 720);
        v0
    }

    public fun gr_indicator_last_updated(arg0: &XOracle) : u64 {
        arg0.gr_indicator_last_updated
    }

    public fun gr_indicator_value(arg0: &XOracle) : u64 {
        arg0.gr_indicator_value_u64
    }

    fun init(arg0: X_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg1);
        let v2 = v0;
        let v3 = XOracleOwnerCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = XOracleAdminCap{
            id            : 0x2::object::new(arg1),
            admin_address : v4,
        };
        let v6 = GrIndicatorCap{id: 0x2::object::new(arg1)};
        v2.admin_address = 0x1::option::some<address>(v4);
        let v7 = PolicyCapKey{dummy_field: false};
        0x2::dynamic_field::add<PolicyCapKey, XOraclePolicyCap>(&mut v2.id, v7, v1);
        let v8 = GrIndicatorCapKey{dummy_field: false};
        0x2::dynamic_field::add<GrIndicatorCapKey, GrIndicatorCap>(&mut v2.id, v8, v6);
        let v9 = &mut v2;
        init_rules_df_if_not_exist(v9, arg1);
        0x2::transfer::share_object<XOracle>(v2);
        0x2::transfer::transfer<XOracleOwnerCap>(v3, v4);
        0x2::transfer::transfer<XOracleAdminCap>(v5, v4);
        0x2::package::claim_and_keep<X_ORACLE>(arg0, arg1);
    }

    fun init_rules_df_if_not_exist(arg0: &mut XOracle, arg1: &mut 0x2::tx_context::TxContext) {
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::init_rules_df_if_not_exist_by_id(0x2::object::id<0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::PriceUpdatePolicy>(&arg0.primary_price_update_policy), &mut arg0.primary_price_update_policy, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::init_rules_df_if_not_exist_by_id(0x2::object::id<0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::PriceUpdatePolicy>(&arg0.secondary_price_update_policy), &mut arg0.secondary_price_update_policy, arg1);
    }

    public fun init_rules_df_if_not_exist_admin(arg0: &mut XOracle, arg1: &XOracleAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg1);
        init_rules_df_if_not_exist(arg0, arg2);
    }

    fun price_feed_match(arg0: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed, arg1: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed) : bool {
        let v0 = 1000;
        let v1 = 1 * v0 / 100;
        let v2 = 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::value(&arg0) * v0 / 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::value(&arg1);
        v2 <= v0 + v1 && v2 >= v0 - v1
    }

    public fun price_update_request<T0>(arg0: &XOracle) : XOraclePriceUpdateRequest<T0> {
        XOraclePriceUpdateRequest<T0>{
            primary_price_update_request   : 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::new_request<T0>(&arg0.primary_price_update_policy),
            secondary_price_update_request : 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::new_request<T0>(&arg0.secondary_price_update_policy),
        }
    }

    public fun prices(arg0: &XOracle) : &0x2::table::Table<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed> {
        &arg0.prices
    }

    public fun remove_primary_price_update_rule<T0: drop>(arg0: &mut XOracle, arg1: &XOracleAdminCap) {
        verify_admin(arg0, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::remove_rule_by_id<T0>(&mut arg0.primary_price_update_policy, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::for_policy(&borrow_policy_cap(arg0).primary_price_update_policy_cap));
    }

    public fun remove_primary_price_update_rule_v2<T0, T1: drop>(arg0: &mut XOracle, arg1: &XOracleAdminCap) {
        verify_admin(arg0, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::remove_rule_v2_by_id<T0, T1>(&mut arg0.primary_price_update_policy, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::for_policy(&borrow_policy_cap(arg0).primary_price_update_policy_cap));
    }

    public fun remove_secondary_price_update_rule<T0: drop>(arg0: &mut XOracle, arg1: &XOracleAdminCap) {
        verify_admin(arg0, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::remove_rule_by_id<T0>(&mut arg0.secondary_price_update_policy, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::for_policy(&borrow_policy_cap(arg0).secondary_price_update_policy_cap));
    }

    public fun remove_secondary_price_update_rule_v2<T0, T1: drop>(arg0: &mut XOracle, arg1: &XOracleAdminCap) {
        verify_admin(arg0, arg1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::remove_rule_v2_by_id<T0, T1>(&mut arg0.secondary_price_update_policy, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::for_policy(&borrow_policy_cap(arg0).secondary_price_update_policy_cap));
    }

    public fun set_admin(arg0: &mut XOracle, arg1: &XOracleOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : XOracleAdminCap {
        arg0.admin_address = 0x1::option::some<address>(arg2);
        XOracleAdminCap{
            id            : 0x2::object::new(arg3),
            admin_address : arg2,
        }
    }

    public fun set_gr_coin_type<T0>(arg0: &mut XOracle, arg1: &XOracleAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg1);
        arg0.gr_coin_type = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
    }

    public fun set_gr_formula_params(arg0: &mut XOracle, arg1: &XOracleAdminCap, arg2: u64, arg3: u64) {
        verify_admin(arg0, arg1);
        assert!(arg2 <= 1000000000, 0);
        assert!(arg3 <= 1000000000, 0);
        arg0.gr_alpha_fp = arg2;
        arg0.gr_beta_fp = arg3;
    }

    public fun set_gr_indicator(arg0: &mut XOracle, arg1: &XOracleAdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg1);
        assert!(arg3 >= arg0.gr_indicator_last_updated, 0);
        assert!(arg2 > 0, 0);
        arg0.gr_indicator_value_u64 = arg2;
        arg0.gr_indicator_last_updated = arg3;
    }

    public fun set_gr_indicators(arg0: &mut XOracle, arg1: &XOracleAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg1);
        assert!(arg5 >= arg0.gr_indicator_last_updated, 0);
        arg0.gr_indicator_last_updated = arg5;
        arg0.xaum_ema120_value_u64 = arg2;
        arg0.xaum_ema90_value_u64 = arg3;
        arg0.xaum_spot_value_u64 = arg4;
        let v0 = 1000000000;
        let v1 = (arg0.gr_alpha_fp as u128);
        let v2 = (arg0.gr_beta_fp as u128);
        let v3 = if (arg0.gr_alpha_fp <= 1000000000) {
            if (arg0.gr_beta_fp <= 1000000000) {
                if (arg2 > 0) {
                    if (arg3 > 0) {
                        arg4 > 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        let v4 = if (v3) {
            let v5 = (v1 * (arg2 as u128) * v0 + (v0 - v1) * (v2 * (arg3 as u128) + (v0 - v2) * (arg4 as u128))) / v0 * v0;
            if (0x1::option::is_some<0x1::type_name::TypeName>(&arg0.xaum_coin_type)) {
                let v6 = *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.xaum_coin_type);
                if (0x2::table::contains<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&arg0.prices, v6)) {
                    let v7 = (0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::value(0x2::table::borrow<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(&arg0.prices, v6)) as u128);
                    if (v7 < v5) {
                        v7
                    } else {
                        v5
                    }
                } else {
                    v5
                }
            } else {
                v5
            }
        } else {
            0
        };
        arg0.gr_svalue_u64 = (v4 as u64);
        let v8 = if (v4 > 0) {
            v4 / 100
        } else {
            0
        };
        arg0.gr_computed_value_u64 = (v8 as u64);
    }

    public fun set_primary_price<T0, T1: drop>(arg0: T1, arg1: &mut XOraclePriceUpdateRequest<T0>, arg2: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed) {
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::add_price_feed<T0, T1>(arg0, &mut arg1.primary_price_update_request, arg2);
    }

    public fun set_secondary_price<T0, T1: drop>(arg0: T1, arg1: &mut XOraclePriceUpdateRequest<T0>, arg2: 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed) {
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_update_policy::add_price_feed<T0, T1>(arg0, &mut arg1.secondary_price_update_request, arg2);
    }

    public fun set_xaum_coin_type<T0>(arg0: &mut XOracle, arg1: &XOracleAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg0, arg1);
        arg0.xaum_coin_type = 0x1::option::some<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T0>());
    }

    fun verify_admin(arg0: &XOracle, arg1: &XOracleAdminCap) {
        assert!(0x1::option::is_some<address>(&arg0.admin_address), 723);
        assert!(arg1.admin_address == *0x1::option::borrow<address>(&arg0.admin_address), 722);
    }

    // decompiled from Move bytecode v6
}

