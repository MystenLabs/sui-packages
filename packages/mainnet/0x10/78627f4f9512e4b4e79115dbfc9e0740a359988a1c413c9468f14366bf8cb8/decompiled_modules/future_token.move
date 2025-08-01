module 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::future_token {
    struct EventNewPool has copy, drop {
        future_token: 0x1::type_name::TypeName,
        underlying_asset: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct PoolsRegistry has key {
        id: 0x2::object::UID,
        pools_by_underlying_coin_type: 0x2::table::Table<0x1::type_name::TypeName, PoolInfo>,
        coin_type_to_underlying_coin_type: 0x2::table::Table<0x1::type_name::TypeName, 0x1::type_name::TypeName>,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        max_supply: u64,
        outstanding_debt: 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::OutstandingDebt<T0>,
        balance: 0x2::balance::Balance<T1>,
    }

    struct PoolCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut PoolsRegistry, arg3: &0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) : PoolCap<T0, T1> {
        let v0 = Pool<T0, T1>{
            id               : 0x2::object::new(arg4),
            treasury_cap     : arg0,
            max_supply       : arg1,
            outstanding_debt : 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::empty_outstanding_debt<T0>(),
            balance          : 0x2::balance::zero<T1>(),
        };
        let v1 = PoolCap<T0, T1>{
            id      : 0x2::object::new(arg4),
            pool_id : 0x2::object::id<Pool<T0, T1>>(&v0),
        };
        register<T0, T1>(arg2, &v0, &v1);
        let v2 = EventNewPool{
            future_token     : 0x1::type_name::get<T0>(),
            underlying_asset : 0x1::type_name::get<T1>(),
            pool_id          : 0x2::object::id<Pool<T0, T1>>(&v0),
            cap_id           : 0x2::object::id<PoolCap<T0, T1>>(&v1),
        };
        0x2::event::emit<EventNewPool>(v2);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
        v1
    }

    fun assert_for_pool<T0, T1>(arg0: &PoolCap<T0, T1>, arg1: &Pool<T0, T1>) {
        assert!(arg0.pool_id == 0x2::object::id<Pool<T0, T1>>(arg1), 1);
    }

    public fun burn_from_backing_asset<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        assert!(0x2::balance::value<T0>(&arg1) <= 0x2::balance::value<T1>(&arg0.balance), 5);
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury_cap), arg1);
        0x2::balance::split<T1>(&mut arg0.balance, 0x2::balance::value<T0>(&arg1))
    }

    public fun destroy_pool<T0, T1>(arg0: Pool<T0, T1>, arg1: PoolCap<T0, T1>, arg2: &mut PoolsRegistry) : 0x2::balance::Supply<T0> {
        unregister<T0, T1>(arg2, &arg0, &arg1);
        let PoolCap {
            id      : v0,
            pool_id : _,
        } = arg1;
        0x2::object::delete(v0);
        let Pool {
            id               : v2,
            treasury_cap     : v3,
            max_supply       : _,
            outstanding_debt : v5,
            balance          : v6,
        } = arg0;
        0x2::object::delete(v2);
        let v7 = 0x2::coin::treasury_into_supply<T0>(v3);
        assert!(0x2::balance::supply_value<T0>(&v7) == 0, 4);
        0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::destroy_zero_outstanding_debt<T0>(v5);
        0x2::balance::destroy_zero<T1>(v6);
        v7
    }

    fun internal_mint<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg0.treasury_cap) <= arg0.max_supply, 3);
        0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, arg1)
    }

    public(friend) fun internal_swap_borrow_and_check_later<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::MarginAccount, arg2: u64, arg3: &0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64, 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::MustCheckBorrowLimit) {
        let (v0, v1) = mint_from_margin_account<T0, T1>(arg0, arg2, arg1, arg3, arg4, arg5);
        (v0, 0, v1)
    }

    public(friend) fun internal_swap_repay_for_margin_account<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::MarginAccount, arg2: 0x2::balance::Balance<T0>, arg3: &0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        repay_debt_by_burn_for_margin_account<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun mint_from_backing_asset<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let v0 = internal_mint<T0, T1>(arg0, 0x2::balance::value<T1>(&arg1));
        0x2::balance::join<T1>(&mut arg0.balance, arg1);
        v0
    }

    public fun mint_from_margin_account<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::MarginAccount, arg3: &0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::MustCheckBorrowLimit) {
        let (v0, v1) = 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::inscrease_debt<T0>(arg2, arg1, arg3, arg4, arg5);
        0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::join_outstanding_debt<T0>(&mut arg0.outstanding_debt, v0);
        (internal_mint<T0, T1>(arg0, arg1), v1)
    }

    public(friend) fun new_pool_registry(arg0: &0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = PoolsRegistry{
            id                                : 0x2::object::new(arg1),
            pools_by_underlying_coin_type     : 0x2::table::new<0x1::type_name::TypeName, PoolInfo>(arg1),
            coin_type_to_underlying_coin_type : 0x2::table::new<0x1::type_name::TypeName, 0x1::type_name::TypeName>(arg1),
        };
        0x2::transfer::share_object<PoolsRegistry>(v0);
        0x2::object::id<PoolsRegistry>(&v0)
    }

    fun register<T0, T1>(arg0: &mut PoolsRegistry, arg1: &Pool<T0, T1>, arg2: &PoolCap<T0, T1>) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, PoolInfo>(&arg0.pools_by_underlying_coin_type, v0), 0);
        let v1 = PoolInfo{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg1),
            cap_id  : 0x2::object::id<PoolCap<T0, T1>>(arg2),
        };
        0x2::table::add<0x1::type_name::TypeName, PoolInfo>(&mut arg0.pools_by_underlying_coin_type, v0, v1);
        0x2::table::add<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg0.coin_type_to_underlying_coin_type, 0x1::type_name::get<T0>(), v0);
    }

    public fun repay_debt_by_backing_asset<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) : 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::OutstandingDebt<T0> {
        0x2::balance::join<T1>(&mut arg0.balance, arg1);
        0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::split_outstanding_debt<T0>(&mut arg0.outstanding_debt, 0x2::balance::value<T1>(&arg1))
    }

    public fun repay_debt_by_backing_asset_for_margin_account<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::MarginAccount, arg3: &0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::decrease_debt<T0>(arg2, repay_debt_by_backing_asset<T0, T1>(arg0, arg1), arg3, arg4, arg5);
    }

    public fun repay_debt_by_burn<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>) : 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::OutstandingDebt<T0> {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury_cap), arg1);
        0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::split_outstanding_debt<T0>(&mut arg0.outstanding_debt, 0x2::balance::value<T0>(&arg1))
    }

    public fun repay_debt_by_burn_for_margin_account<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::MarginAccount, arg2: 0x2::balance::Balance<T0>, arg3: &0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::risk_params::RiskParams, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x1078627f4f9512e4b4e79115dbfc9e0740a359988a1c413c9468f14366bf8cb8::margin_account::decrease_debt<T0>(arg1, repay_debt_by_burn<T0, T1>(arg0, arg2), arg3, arg4, arg5);
    }

    fun unregister<T0, T1>(arg0: &mut PoolsRegistry, arg1: &Pool<T0, T1>, arg2: &PoolCap<T0, T1>) {
        0x2::table::remove<0x1::type_name::TypeName, PoolInfo>(&mut arg0.pools_by_underlying_coin_type, 0x1::type_name::get<T1>());
        0x2::table::remove<0x1::type_name::TypeName, 0x1::type_name::TypeName>(&mut arg0.coin_type_to_underlying_coin_type, 0x1::type_name::get<T0>());
    }

    public fun update_max_supply<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &PoolCap<T0, T1>) {
        assert_for_pool<T0, T1>(arg2, arg0);
        arg0.max_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

