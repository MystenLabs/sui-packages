module 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::factory {
    struct BondingCurveInfo has copy, drop, store {
        bonding_curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        deployer: address,
        owner: address,
        initialize_price: u128,
        tick_spacing: u32,
        vault_bps: u16,
    }

    struct BondingCurveRegistry has store, key {
        id: 0x2::object::UID,
        list: 0x2::table::Table<0x2::object::ID, BondingCurveInfo>,
        index: u64,
    }

    struct DepositFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        tier: u8,
    }

    struct BondingCurveRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        bonding_curve_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        deployer: address,
        owner: address,
        initialize_price: u128,
        tick_spacing: u32,
        vault_bps: u16,
        index: u64,
    }

    public fun create_bonding_curve<T0, T1>(arg0: &0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::Config, arg1: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::config::GlobalConfig, arg2: &mut 0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::factory::Pools, arg3: &mut BondingCurveRegistry, arg4: 0x2::coin::TreasuryCap<T0>, arg5: u32, arg6: u128, arg7: address, arg8: vector<u32>, arg9: vector<u32>, arg10: vector<u16>, arg11: vector<address>, arg12: vector<u16>, arg13: vector<address>, arg14: u16, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::assert_not_paused(arg0);
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::assert_current_version(arg0);
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::assert_deployer_whitelisted(arg0, 0x2::tx_context::sender(arg16));
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::assert_quote_token_whitelisted<T1>(arg0);
        let v0 = 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::new<T0, T1>(arg0, arg4, arg7, arg6, arg5, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        let (v1, v2, v3, v4, v5, v6, v7) = 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::get_launch_config(arg0);
        let v8 = 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::borrow_position_config_mut<T0, T1>(&mut v0, 0);
        let (v9, v10, v11) = 0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::factory::create_pool<T0, T1>(arg1, arg2, arg5, arg6, 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::position_tick_lower<T0>(v8), 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::position_tick_upper<T0>(v8), v7, 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::take_position_coin<T0>(v8, arg16), 0x2::coin::zero<T1>(arg16), v1, v2, v3, v4, v5, v6, 0x2::clock::timestamp_ms(arg15), arg15, arg16);
        let v12 = v9;
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::deposit_leftover<T0, T1>(&mut v0, v10);
        0x2::coin::destroy_zero<T1>(v11);
        let v13 = 0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::position::pool_id(&v12);
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::set_curve_pool_id<T0, T1>(&mut v0, v13);
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::add_position_to_config<T0>(0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::borrow_position_config_mut<T0, T1>(&mut v0, 0), v12);
        let v14 = 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::id<T0, T1>(&v0);
        let v15 = 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::token<T0, T1>(&v0);
        let v16 = BondingCurveInfo{
            bonding_curve_id : v14,
            pool_id          : v13,
            token            : v15,
            deployer         : 0x2::tx_context::sender(arg16),
            owner            : arg7,
            initialize_price : arg6,
            tick_spacing     : arg5,
            vault_bps        : arg14,
        };
        0x2::table::add<0x2::object::ID, BondingCurveInfo>(&mut arg3.list, v14, v16);
        let v17 = arg3.index;
        arg3.index = v17 + 1;
        let v18 = BondingCurveRegistered{
            registry_id      : 0x2::object::id<BondingCurveRegistry>(arg3),
            bonding_curve_id : v14,
            token            : v15,
            deployer         : 0x2::tx_context::sender(arg16),
            owner            : arg7,
            initialize_price : arg6,
            tick_spacing     : arg5,
            vault_bps        : arg14,
            index            : v17,
        };
        0x2::event::emit<BondingCurveRegistered>(v18);
        0x2::transfer::public_share_object<0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::BondingCurve<T0, T1>>(v0);
    }

    public fun deposit_fee(arg0: &mut 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::FeeVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 1 && arg2 <= 4, 301);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::fee_tier(arg0, arg2), 302);
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::join_fee_vault_balance(arg0, arg1);
        let v1 = DepositFeeEvent{
            vault_id  : 0x2::object::id<0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::FeeVault>(arg0),
            depositor : 0x2::tx_context::sender(arg3),
            amount    : v0,
            tier      : arg2,
        };
        0x2::event::emit<DepositFeeEvent>(v1);
    }

    public fun get_info(arg0: &BondingCurveRegistry, arg1: 0x2::object::ID) : BondingCurveInfo {
        assert!(0x2::table::contains<0x2::object::ID, BondingCurveInfo>(&arg0.list, arg1), 300);
        *0x2::table::borrow<0x2::object::ID, BondingCurveInfo>(&arg0.list, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BondingCurveRegistry{
            id    : 0x2::object::new(arg0),
            list  : 0x2::table::new<0x2::object::ID, BondingCurveInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<BondingCurveRegistry>(v0);
    }

    public fun migrate_liquidity_to_pool<T0, T1>(arg0: &0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::Config, arg1: &0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::config::GlobalConfig, arg2: &mut 0xf9df0f7fab7c453818f33f04c6dbb7518c369fd879b7535d39e683a45bafae19::pool::Pool<T0, T1>, arg3: &mut 0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::BondingCurve<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::assert_not_paused(arg0);
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::assert_current_version(arg0);
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::config::assert_deployer_whitelisted(arg0, 0x2::tx_context::sender(arg5));
        0x3dae9c59376448aae3b6038ec975b85b7982f01df50aa5f439cbe793612dae5a::bonding_curve::add_liquidity_positions<T0, T1>(arg0, arg1, arg3, arg2, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

