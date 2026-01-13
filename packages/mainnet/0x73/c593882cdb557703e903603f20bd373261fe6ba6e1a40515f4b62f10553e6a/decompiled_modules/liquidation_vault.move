module 0x73c593882cdb557703e903603f20bd373261fe6ba6e1a40515f4b62f10553e6a::liquidation_vault {
    struct LIQUIDATION_VAULT has drop {
        dummy_field: bool,
    }

    struct LiquidationVault has key {
        id: 0x2::object::UID,
        vault: 0x2::bag::Bag,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct LiquidationAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LiquidationByVault has copy, drop {
        vault_id: 0x2::object::ID,
        margin_manager_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        base_in: u64,
        base_out: u64,
        quote_in: u64,
        quote_out: u64,
        repay_balance_remaining: u64,
        base_liquidation: bool,
    }

    public fun balance<T0>(arg0: &LiquidationVault) : u64 {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.vault, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&arg0.vault, v0))
        } else {
            0
        }
    }

    fun id(arg0: &LiquidationVault) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun create_liquidation_vault(arg0: &LiquidationAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidationVault{
            id    : 0x2::object::new(arg1),
            vault : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<LiquidationVault>(v0);
    }

    public fun deposit<T0>(arg0: &mut LiquidationVault, arg1: &LiquidationAdminCap, arg2: 0x2::coin::Coin<T0>) {
        deposit_int<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
    }

    fun deposit_int<T0>(arg0: &mut LiquidationVault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (0x2::bag::contains<BalanceKey<T0>>(&arg0.vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), arg1);
        } else {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, arg1);
        };
    }

    fun init(arg0: LIQUIDATION_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LiquidationAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<LiquidationAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun liquidate_base<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = balance<T0>(arg0);
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg7), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg1, arg2, arg3, arg4, arg7, arg5, arg6, arg9)) || v0 < 1000) {
            return
        };
        let v1 = 0x1::option::destroy_with_default<u64>(arg8, v0);
        let v2 = withdraw_int<T0>(arg0, v1);
        let (v3, v4, v5) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T0>(arg1, arg2, arg3, arg4, arg5, arg7, 0x2::coin::from_balance<T0>(v2, arg10), arg9, arg10);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = LiquidationByVault{
            vault_id                : id(arg0),
            margin_manager_id       : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            margin_pool_id          : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T0>(arg5),
            base_in                 : v1,
            base_out                : 0x2::coin::value<T0>(&v8),
            quote_in                : 0,
            quote_out               : 0x2::coin::value<T1>(&v7),
            repay_balance_remaining : 0x2::coin::value<T0>(&v6),
            base_liquidation        : true,
        };
        0x2::event::emit<LiquidationByVault>(v9);
        0x2::coin::join<T0>(&mut v8, v6);
        deposit_int<T0>(arg0, 0x2::coin::into_balance<T0>(v8));
        deposit_int<T1>(arg0, 0x2::coin::into_balance<T1>(v7));
    }

    public fun liquidate_quote<T0, T1>(arg0: &mut LiquidationVault, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg8: 0x1::option::Option<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = balance<T1>(arg0);
        if (!0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::can_liquidate(arg2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::id<T0, T1>(arg7), 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::risk_ratio<T0, T1>(arg1, arg2, arg3, arg4, arg7, arg5, arg6, arg9)) || v0 < 1000) {
            return
        };
        let v1 = 0x1::option::destroy_with_default<u64>(arg8, v0);
        let v2 = withdraw_int<T1>(arg0, v1);
        let (v3, v4, v5) = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::liquidate<T0, T1, T1>(arg1, arg2, arg3, arg4, arg6, arg7, 0x2::coin::from_balance<T1>(v2, arg10), arg9, arg10);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = LiquidationByVault{
            vault_id                : id(arg0),
            margin_manager_id       : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::id<T0, T1>(arg1),
            margin_pool_id          : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::id<T1>(arg6),
            base_in                 : 0,
            base_out                : 0x2::coin::value<T0>(&v8),
            quote_in                : v1,
            quote_out               : 0x2::coin::value<T1>(&v7),
            repay_balance_remaining : 0x2::coin::value<T1>(&v6),
            base_liquidation        : false,
        };
        0x2::event::emit<LiquidationByVault>(v9);
        0x2::coin::join<T1>(&mut v7, v6);
        deposit_int<T0>(arg0, 0x2::coin::into_balance<T0>(v8));
        deposit_int<T1>(arg0, 0x2::coin::into_balance<T1>(v7));
    }

    public fun withdraw<T0>(arg0: &mut LiquidationVault, arg1: &LiquidationAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(withdraw_int<T0>(arg0, arg2), arg3)
    }

    fun withdraw_int<T0>(arg0: &mut LiquidationVault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        if (!0x2::bag::contains<BalanceKey<T0>>(&arg0.vault, v0)) {
            0x2::bag::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, 0x2::balance::zero<T0>());
        };
        let v1 = 0x2::bag::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 1);
        0x2::balance::split<T0>(v1, arg1)
    }

    // decompiled from Move bytecode v6
}

