module 0x941b6e22fc8748287026e3068858082a94415f8fae177361a1e6b9e744665c38::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct LiquidationVault has key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct TraderCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Liquidated has copy, drop {
        vault_id: 0x2::object::ID,
        manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        repay_in: u64,
        base_out: u64,
        quote_out: u64,
        repay_remaining: u64,
        base_debt: bool,
    }

    public fun balance<T0>(arg0: &LiquidationVault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
        } else {
            0
        }
    }

    fun assert_admin(arg0: &LiquidationVault, arg1: &AdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<LiquidationVault>(arg0), 0);
    }

    fun assert_trader(arg0: &LiquidationVault, arg1: &TraderCap) {
        assert!(arg1.vault_id == 0x2::object::id<LiquidationVault>(arg0), 0);
    }

    public(friend) fun bounded_repay(arg0: 0x1::option::Option<u64>, arg1: u64) : u64 {
        let v0 = if (0x1::option::is_some<u64>(&arg0)) {
            0x1::option::destroy_some<u64>(arg0)
        } else {
            0x1::option::destroy_none<u64>(arg0);
            arg1
        };
        if (v0 < arg1) {
            v0
        } else {
            arg1
        }
    }

    public fun deposit<T0>(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        assert_admin(arg0, arg1);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
    }

    fun deposit_balance<T0>(arg0: &mut LiquidationVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, arg1);
        };
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidationVault{
            id       : 0x2::object::new(arg1),
            balances : 0x2::bag::new(arg1),
        };
        let v1 = 0x2::object::id<LiquidationVault>(&v0);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::share_object<LiquidationVault>(v0);
        let v3 = AdminCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        0x2::transfer::public_transfer<AdminCap>(v3, v2);
        let v4 = TraderCap{
            id       : 0x2::object::new(arg1),
            vault_id : v1,
        };
        0x2::transfer::public_transfer<TraderCap>(v4, v2);
    }

    public fun liquidate_base<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &TraderCap, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : bool {
        assert_trader(arg0, arg8);
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::has_base_debt<T0, T1>(arg1)) {
            return false
        };
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg1, arg5, arg6, arg7, arg4, arg2, arg3, arg10))) {
            return false
        };
        let v0 = bounded_repay(arg9, balance<T0>(arg0));
        if (v0 < 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay()) {
            return false
        };
        let v1 = withdraw_balance<T0>(arg0, v0);
        let (v2, v3, v4) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T0>(arg1, arg5, arg6, arg7, arg2, arg4, 0x2::coin::from_balance<T0>(v1, arg11), arg10, arg11);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x2::object::id<LiquidationVault>(arg0);
        0x2::coin::join<T0>(&mut v7, v5);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v7));
        deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v6));
        let v9 = Liquidated{
            vault_id        : v8,
            manager_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            margin_pool_id  : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg2),
            repay_in        : v0,
            base_out        : 0x2::coin::value<T0>(&v7),
            quote_out       : 0x2::coin::value<T1>(&v6),
            repay_remaining : 0x2::coin::value<T0>(&v5),
            base_debt       : true,
        };
        0x2::event::emit<Liquidated>(v9);
        true
    }

    public fun liquidate_quote<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &TraderCap, arg9: 0x1::option::Option<u64>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : bool {
        assert_trader(arg0, arg8);
        if (0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::has_base_debt<T0, T1>(arg1)) {
            return false
        };
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg4), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg1, arg5, arg6, arg7, arg4, arg2, arg3, arg10))) {
            return false
        };
        let v0 = bounded_repay(arg9, balance<T1>(arg0));
        if (v0 < 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_constants::min_liquidation_repay()) {
            return false
        };
        let v1 = withdraw_balance<T1>(arg0, v0);
        let (v2, v3, v4) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T1>(arg1, arg5, arg6, arg7, arg3, arg4, 0x2::coin::from_balance<T1>(v1, arg11), arg10, arg11);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = 0x2::object::id<LiquidationVault>(arg0);
        0x2::coin::join<T1>(&mut v6, v5);
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v7));
        deposit_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v6));
        let v9 = Liquidated{
            vault_id        : v8,
            manager_id      : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            margin_pool_id  : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T1>(arg3),
            repay_in        : v0,
            base_out        : 0x2::coin::value<T0>(&v7),
            quote_out       : 0x2::coin::value<T1>(&v6),
            repay_remaining : 0x2::coin::value<T1>(&v5),
            base_debt       : false,
        };
        0x2::event::emit<Liquidated>(v9);
        true
    }

    public fun withdraw<T0>(arg0: &mut LiquidationVault, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_admin(arg0, arg1);
        0x2::coin::from_balance<T0>(withdraw_balance<T0>(arg0, arg2), arg3)
    }

    fun withdraw_balance<T0>(arg0: &mut LiquidationVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains<BalanceKey<T0>>(&arg0.balances, v0), 1);
        let v1 = 0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 1);
        0x2::balance::split<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v7
}

