module 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_margin {
    struct MarginAccount has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        total_allocated: u64,
        max_allocation_bps: u64,
        max_leverage: u64,
        enabled: bool,
        cumulative_profit: u64,
        cumulative_loss: u64,
        trade_count: u64,
    }

    struct MarginDepositAuth has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amount: u64,
        expires_at: u64,
    }

    struct MarginReturnAuth has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        min_return_amount: u64,
        expires_at: u64,
    }

    struct MarginAccountCreated has copy, drop {
        vault_id: 0x2::object::ID,
        margin_account_id: 0x2::object::ID,
        max_leverage: u64,
        max_allocation_bps: u64,
    }

    struct MarginDepositAuthorized has copy, drop {
        vault_id: 0x2::object::ID,
        auth_id: 0x2::object::ID,
        amount: u64,
    }

    struct MarginFundsExtracted has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        total_allocated: u64,
    }

    struct MarginFundsReturned has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        total_allocated: u64,
        pnl_amount: u64,
        is_profit: bool,
    }

    struct MarginSettingsUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        max_leverage: u64,
        max_allocation_bps: u64,
        enabled: bool,
    }

    struct CloseObligation {
        vault_id: 0x2::object::ID,
        min_return: u64,
    }

    struct AtomicSwapExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        base_amount: u64,
        quote_amount: u64,
        is_base_to_quote: bool,
    }

    public fun atomic_close_to_vault<T0>(arg0: &mut 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg3, arg4, arg8);
        let v2 = 0x2::coin::value<T0>(&v1);
        assert!(v2 >= arg6, 101);
        if (v2 >= arg5) {
            arg2.cumulative_profit = arg2.cumulative_profit + v2 - arg5;
        } else {
            arg2.cumulative_loss = arg2.cumulative_loss + arg5 - v2;
        };
        if (arg2.total_allocated >= arg5) {
            arg2.total_allocated = arg2.total_allocated - arg5;
        } else {
            arg2.total_allocated = 0;
        };
        arg2.trade_count = arg2.trade_count + 1;
        let (v3, v4) = if (v2 >= arg5) {
            (true, v2 - arg5)
        } else {
            (false, arg5 - v2)
        };
        let v5 = MarginFundsReturned{
            vault_id        : v0,
            amount          : v2,
            total_allocated : arg2.total_allocated,
            pnl_amount      : v4,
            is_profit       : v3,
        };
        0x2::event::emit<MarginFundsReturned>(v5);
        0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::deposit_usdc_from_trading<T0>(arg0, v1);
    }

    public fun atomic_deposit_to_bm<T0>(arg0: &mut 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        assert!(arg2.enabled, 100);
        assert!(arg4 > 0, 101);
        let v1 = arg2.total_allocated + arg4;
        assert!((v1 as u128) <= (0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::available_usdc_for_trading<T0>(arg0) as u128) * (arg2.max_allocation_bps as u128) / (10000 as u128), 102);
        arg2.total_allocated = v1;
        let v2 = MarginFundsExtracted{
            vault_id        : v0,
            amount          : arg4,
            total_allocated : arg2.total_allocated,
        };
        0x2::event::emit<MarginFundsExtracted>(v2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::extract_usdc_for_trading<T0>(arg0, arg4, arg6), arg6);
    }

    public fun atomic_deposit_to_mm<T0, T1>(arg0: &mut 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        assert!(arg2.enabled, 100);
        assert!(arg7 > 0, 101);
        let v1 = arg2.total_allocated + arg7;
        assert!((v1 as u128) <= (0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::available_usdc_for_trading<T1>(arg0) as u128) * (arg2.max_allocation_bps as u128) / (10000 as u128), 102);
        arg2.total_allocated = v1;
        let v2 = MarginFundsExtracted{
            vault_id        : v0,
            amount          : arg7,
            total_allocated : arg2.total_allocated,
        };
        0x2::event::emit<MarginFundsExtracted>(v2);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T1>(arg3, arg4, arg5, arg6, 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::extract_usdc_for_trading<T1>(arg0, arg7, arg9), arg8, arg9);
    }

    public fun atomic_margin_close_to_vault<T0, T1>(arg0: &mut 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        let v1 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::withdraw<T0, T1, T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14);
        let v2 = 0x2::coin::value<T1>(&v1);
        assert!(v2 >= arg12, 101);
        if (v2 >= arg11) {
            arg2.cumulative_profit = arg2.cumulative_profit + v2 - arg11;
        } else {
            arg2.cumulative_loss = arg2.cumulative_loss + arg11 - v2;
        };
        if (arg2.total_allocated >= arg11) {
            arg2.total_allocated = arg2.total_allocated - arg11;
        } else {
            arg2.total_allocated = 0;
        };
        arg2.trade_count = arg2.trade_count + 1;
        let (v3, v4) = if (v2 >= arg11) {
            (true, v2 - arg11)
        } else {
            (false, arg11 - v2)
        };
        let v5 = MarginFundsReturned{
            vault_id        : v0,
            amount          : v2,
            total_allocated : arg2.total_allocated,
            pnl_amount      : v4,
            is_profit       : v3,
        };
        0x2::event::emit<MarginFundsReturned>(v5);
        0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::deposit_usdc_from_trading<T1>(arg0, v1);
    }

    public fun atomic_margin_swap_base_to_quote<T0, T1>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &MarginAccount, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg10: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg9, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::withdraw<T0, T1, T0>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg13, arg14), arg10, arg12, arg13, arg14);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T1>(arg3, arg4, arg7, arg8, v5, arg13, arg14);
        let v7 = 0x2::coin::value<T0>(&v6);
        if (v7 > 0) {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T0>(arg3, arg4, arg7, arg8, v6, arg13, arg14);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v4, 0x2::tx_context::sender(arg14));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        };
        let v8 = AtomicSwapExecuted{
            vault_id         : v0,
            base_amount      : arg11 - v7,
            quote_amount     : 0x2::coin::value<T1>(&v5),
            is_base_to_quote : true,
        };
        0x2::event::emit<AtomicSwapExecuted>(v8);
    }

    public fun atomic_margin_swap_quote_to_base<T0, T1>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &MarginAccount, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::MarginManager<T0, T1>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg6: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T1>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg10: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg9, 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::withdraw<T0, T1, T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg13, arg14), arg10, arg12, arg13, arg14);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T0>(arg3, arg4, arg7, arg8, v6, arg13, arg14);
        let v7 = 0x2::coin::value<T1>(&v5);
        if (v7 > 0) {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_manager::deposit<T0, T1, T1>(arg3, arg4, arg7, arg8, v5, arg13, arg14);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>>(v4, 0x2::tx_context::sender(arg14));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        };
        let v8 = AtomicSwapExecuted{
            vault_id         : v0,
            base_amount      : 0x2::coin::value<T0>(&v6),
            quote_amount     : arg11 - v7,
            is_base_to_quote : false,
        };
        0x2::event::emit<AtomicSwapExecuted>(v8);
    }

    public fun atomic_swap_and_close<T0, T1>(arg0: &mut 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg3, arg6, arg12), arg5, arg7, arg11, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg3, v5, arg12);
        let v7 = 0x2::coin::value<T0>(&v6);
        if (v7 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, v6, arg12);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4) > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v4, arg12);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        };
        let v8 = AtomicSwapExecuted{
            vault_id         : v0,
            base_amount      : arg6 - v7,
            quote_amount     : 0x2::coin::value<T1>(&v5),
            is_base_to_quote : true,
        };
        0x2::event::emit<AtomicSwapExecuted>(v8);
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg3, arg8, arg12);
        let v10 = 0x2::coin::value<T1>(&v9);
        assert!(v10 >= arg10, 101);
        if (v10 >= arg9) {
            arg2.cumulative_profit = arg2.cumulative_profit + v10 - arg9;
        } else {
            arg2.cumulative_loss = arg2.cumulative_loss + arg9 - v10;
        };
        if (arg2.total_allocated >= arg9) {
            arg2.total_allocated = arg2.total_allocated - arg9;
        } else {
            arg2.total_allocated = 0;
        };
        arg2.trade_count = arg2.trade_count + 1;
        let (v11, v12) = if (v10 >= arg9) {
            (true, v10 - arg9)
        } else {
            (false, arg9 - v10)
        };
        let v13 = MarginFundsReturned{
            vault_id        : v0,
            amount          : v10,
            total_allocated : arg2.total_allocated,
            pnl_amount      : v12,
            is_profit       : v11,
        };
        0x2::event::emit<MarginFundsReturned>(v13);
        0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::deposit_usdc_from_trading<T1>(arg0, v9);
    }

    public fun atomic_swap_base_to_quote<T0, T1>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &MarginAccount, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg3, arg6, arg9), arg5, arg7, arg8, arg9);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg3, v5, arg9);
        let v7 = 0x2::coin::value<T0>(&v6);
        if (v7 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, v6, arg9);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4) > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v4, arg9);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        };
        let v8 = AtomicSwapExecuted{
            vault_id         : v0,
            base_amount      : arg6 - v7,
            quote_amount     : 0x2::coin::value<T1>(&v5),
            is_base_to_quote : true,
        };
        0x2::event::emit<AtomicSwapExecuted>(v8);
    }

    public fun atomic_swap_quote_to_base<T0, T1>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &MarginAccount, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T1>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        let (v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg4, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg3, arg6, arg9), arg5, arg7, arg8, arg9);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg3, v6, arg9);
        let v7 = 0x2::coin::value<T1>(&v5);
        if (v7 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg3, v5, arg9);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v4) > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3, v4, arg9);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4);
        };
        let v8 = AtomicSwapExecuted{
            vault_id         : v0,
            base_amount      : 0x2::coin::value<T0>(&v6),
            quote_amount     : arg6 - v7,
            is_base_to_quote : false,
        };
        0x2::event::emit<AtomicSwapExecuted>(v8);
    }

    public fun authorize_margin_deposit<T0>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : MarginDepositAuth {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        assert!(arg2.enabled, 100);
        assert!(arg3 > 0, 101);
        assert!(((arg2.total_allocated + arg3) as u128) <= (0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::available_usdc_for_trading<T0>(arg0) as u128) * (arg2.max_allocation_bps as u128) / (10000 as u128), 102);
        let v1 = MarginDepositAuth{
            id         : 0x2::object::new(arg6),
            vault_id   : v0,
            amount     : arg3,
            expires_at : 0x2::clock::timestamp_ms(arg5) / 1000 + arg4,
        };
        let v2 = MarginDepositAuthorized{
            vault_id : v0,
            auth_id  : 0x2::object::id<MarginDepositAuth>(&v1),
            amount   : arg3,
        };
        0x2::event::emit<MarginDepositAuthorized>(v2);
        v1
    }

    public fun authorize_margin_return<T0>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : MarginReturnAuth {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        MarginReturnAuth{
            id                : 0x2::object::new(arg5),
            vault_id          : v0,
            min_return_amount : arg2,
            expires_at        : 0x2::clock::timestamp_ms(arg4) / 1000 + arg3,
        }
    }

    public fun complete_margin_close<T0>(arg0: CloseObligation, arg1: &mut 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg2: &mut MarginAccount, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock) {
        let CloseObligation {
            vault_id   : v0,
            min_return : v1,
        } = arg0;
        assert!(v0 == 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg1), 100);
        assert!(v0 == arg2.vault_id, 100);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 >= v1, 101);
        if (v2 >= arg4) {
            arg2.cumulative_profit = arg2.cumulative_profit + v2 - arg4;
        } else {
            arg2.cumulative_loss = arg2.cumulative_loss + arg4 - v2;
        };
        if (arg2.total_allocated >= arg4) {
            arg2.total_allocated = arg2.total_allocated - arg4;
        } else {
            arg2.total_allocated = 0;
        };
        arg2.trade_count = arg2.trade_count + 1;
        let (v3, v4) = if (v2 >= arg4) {
            (true, v2 - arg4)
        } else {
            (false, arg4 - v2)
        };
        let v5 = MarginFundsReturned{
            vault_id        : v0,
            amount          : v2,
            total_allocated : arg2.total_allocated,
            pnl_amount      : v4,
            is_profit       : v3,
        };
        0x2::event::emit<MarginFundsReturned>(v5);
        0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::deposit_usdc_from_trading<T0>(arg1, arg3);
    }

    public fun consume_margin_deposit<T0>(arg0: MarginDepositAuth, arg1: &mut 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg2: &mut MarginAccount, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MarginDepositAuth {
            id         : v0,
            vault_id   : v1,
            amount     : v2,
            expires_at : v3,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 < v3, 103);
        assert!(v1 == 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg1), 100);
        assert!(v1 == arg2.vault_id, 100);
        0x2::object::delete(v0);
        arg2.total_allocated = arg2.total_allocated + v2;
        let v4 = MarginFundsExtracted{
            vault_id        : v1,
            amount          : v2,
            total_allocated : arg2.total_allocated,
        };
        0x2::event::emit<MarginFundsExtracted>(v4);
        0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::extract_usdc_for_trading<T0>(arg1, v2, arg4)
    }

    public fun create_margin_account<T0>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0), 100);
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0);
        let v1 = MarginAccount{
            id                 : 0x2::object::new(arg2),
            vault_id           : v0,
            total_allocated    : 0,
            max_allocation_bps : 5000,
            max_leverage       : 5000,
            enabled            : true,
            cumulative_profit  : 0,
            cumulative_loss    : 0,
            trade_count        : 0,
        };
        let v2 = MarginAccountCreated{
            vault_id           : v0,
            margin_account_id  : 0x2::object::id<MarginAccount>(&v1),
            max_leverage       : 5000,
            max_allocation_bps : 5000,
        };
        0x2::event::emit<MarginAccountCreated>(v2);
        0x2::transfer::share_object<MarginAccount>(v1);
    }

    public fun cumulative_loss(arg0: &MarginAccount) : u64 {
        arg0.cumulative_loss
    }

    public fun cumulative_profit(arg0: &MarginAccount) : u64 {
        arg0.cumulative_profit
    }

    public fun initiate_margin_close<T0>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &MarginAccount, arg3: u64) : CloseObligation {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        CloseObligation{
            vault_id   : v0,
            min_return : arg3,
        }
    }

    public fun is_enabled(arg0: &MarginAccount) : bool {
        arg0.enabled
    }

    public fun margin_vault_id(arg0: &MarginAccount) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun max_allocation_bps(arg0: &MarginAccount) : u64 {
        arg0.max_allocation_bps
    }

    public fun max_leverage(arg0: &MarginAccount) : u64 {
        arg0.max_leverage
    }

    public fun net_pnl(arg0: &MarginAccount) : (bool, u64) {
        if (arg0.cumulative_profit >= arg0.cumulative_loss) {
            (true, arg0.cumulative_profit - arg0.cumulative_loss)
        } else {
            (false, arg0.cumulative_loss - arg0.cumulative_profit)
        }
    }

    public fun reset_allocation<T0>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        arg2.total_allocated = 0;
    }

    public fun return_margin_funds<T0>(arg0: MarginReturnAuth, arg1: &mut 0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg2: &mut MarginAccount, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock) {
        let MarginReturnAuth {
            id                : v0,
            vault_id          : v1,
            min_return_amount : v2,
            expires_at        : v3,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg5) / 1000 < v3, 103);
        assert!(v1 == 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg1), 100);
        assert!(v1 == arg2.vault_id, 100);
        let v4 = 0x2::coin::value<T0>(&arg3);
        assert!(v4 >= v2, 101);
        0x2::object::delete(v0);
        if (v4 >= arg4) {
            arg2.cumulative_profit = arg2.cumulative_profit + v4 - arg4;
        } else {
            arg2.cumulative_loss = arg2.cumulative_loss + arg4 - v4;
        };
        if (arg2.total_allocated >= arg4) {
            arg2.total_allocated = arg2.total_allocated - arg4;
        } else {
            arg2.total_allocated = 0;
        };
        arg2.trade_count = arg2.trade_count + 1;
        let (v5, v6) = if (v4 >= arg4) {
            (true, v4 - arg4)
        } else {
            (false, arg4 - v4)
        };
        let v7 = MarginFundsReturned{
            vault_id        : v1,
            amount          : v4,
            total_allocated : arg2.total_allocated,
            pnl_amount      : v6,
            is_profit       : v5,
        };
        0x2::event::emit<MarginFundsReturned>(v7);
        0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::deposit_usdc_from_trading<T0>(arg1, arg3);
    }

    public fun total_allocated(arg0: &MarginAccount) : u64 {
        arg0.total_allocated
    }

    public fun trade_count(arg0: &MarginAccount) : u64 {
        arg0.trade_count
    }

    public fun update_margin_settings<T0>(arg0: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>, arg1: &0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiLeaderCap, arg2: &mut MarginAccount, arg3: u64, arg4: u64, arg5: bool) {
        let v0 = 0x2::object::id<0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::SuiVault<T0>>(arg0);
        assert!(0x38f8abec78daed811767295c0e7ac47a5d85bcf9cfccbdd6cd1a8f730456192e::sui_vault::leader_cap_vault_id(arg1) == v0, 100);
        assert!(arg2.vault_id == v0, 100);
        assert!(arg3 >= 1000 && arg3 <= 20000, 104);
        assert!(arg4 <= 8000, 102);
        if (!arg5) {
            assert!(arg2.total_allocated == 0, 107);
        };
        arg2.max_leverage = arg3;
        arg2.max_allocation_bps = arg4;
        arg2.enabled = arg5;
        let v1 = MarginSettingsUpdated{
            vault_id           : v0,
            max_leverage       : arg3,
            max_allocation_bps : arg4,
            enabled            : arg5,
        };
        0x2::event::emit<MarginSettingsUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

