module 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::token_trade {
    struct TokenTrades has store, key {
        id: 0x2::object::UID,
        token_trade_cap: 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::TokenTradeCap,
        claim_locked: bool,
        bag: 0x2::bag::Bag,
        module_version: u64,
    }

    struct SwapResultInfo has copy, drop {
        x_offer_amt: u64,
        x_return_amt: u64,
        x_total_fee: u64,
        y_offer_amt: u64,
        y_return_amt: u64,
        y_total_fee: u64,
        creator_fee_amt: u64,
        amm_fee_amt: u64,
        protocol_fee_amt: u64,
        error: u64,
        token_tax_amt: u64,
        honey_tax_amt: u64,
        admin_tax_amt: u64,
    }

    public fun claim_trader_honey_for_user<T0, T1, T2>(arg0: &TokenTrades, arg1: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg2: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::honeyjar::HoneyJar, arg3: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg4: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg5: &mut 0x2::token::TokenPolicy<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.module_version == 0, 5036);
        assert!(!arg0.claim_locked, 5038);
        assert!(0x2::tx_context::sender(arg6) == 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::honeyjar::get_owner(arg2), 5037);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::from_coin_and_transfer<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(0x2::coin::from_balance<0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey::HONEY>(0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::claim_trader_honey_for_user<T0, T1, T2>(&arg0.token_trade_cap, arg1, arg2), arg6), arg3, arg4, arg5, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun add_liquidity_to_token_x_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &TokenTrades, arg2: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T0>, arg3: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg4: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg5: 0x2::token::Token<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T0>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>> {
        let (v0, v1) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::to_coin_for_add_liquidity_with_tax<T0>(&arg1.token_trade_cap, arg2, arg3, 0x2::token::split<T0>(&mut arg5, arg7, arg11), arg10, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg10, v1, arg11);
        let (v6, v7) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::transfer_with_tax<T0>(arg5, 0x2::tx_context::sender(arg11), arg2, arg3, arg10, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg10, v7, arg11);
        0x2::token::destroy_zero<T0>(v6);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<T1>(0x2::coin::into_balance<T1>(arg6), 0x2::tx_context::sender(arg11), arg11);
        0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::add_liquidity<T0, T1, T2>(arg0, arg4, 0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, arg8, arg11)), arg9)
    }

    public fun add_liquidity_to_x_token_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &TokenTrades, arg2: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T1>, arg3: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg4: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::token::Token<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>> {
        let (v0, v1) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::to_coin_for_add_liquidity_with_tax<T1>(&arg1.token_trade_cap, arg2, arg3, 0x2::token::split<T1>(&mut arg6, arg8, arg11), arg10, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v1, arg11);
        let (v6, v7) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::transfer_with_tax<T1>(arg6, 0x2::tx_context::sender(arg11), arg2, arg3, arg10, arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, v7, arg11);
        0x2::token::destroy_zero<T1>(v6);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<T0>(0x2::coin::into_balance<T0>(arg5), 0x2::tx_context::sender(arg11), arg11);
        0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::add_liquidity<T0, T1, T2>(arg0, arg4, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, arg7, arg11)), 0x2::coin::into_balance<T1>(v0), arg9)
    }

    public fun entry_add_liquidity_to_token_x_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &TokenTrades, arg2: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T0>, arg3: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg4: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg5: 0x2::token::Token<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T0>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity_to_token_x_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg11), arg11);
    }

    public fun entry_add_liquidity_to_x_token_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &TokenTrades, arg2: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T1>, arg3: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg4: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::token::Token<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = add_liquidity_to_x_token_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg11), arg11);
    }

    public fun increment_token_trades(arg0: &mut TokenTrades) {
        assert!(arg0.module_version < 0, 5035);
        arg0.module_version = 0;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun kraft_token_trade_obj(arg0: 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::TokenTradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenTrades{
            id              : 0x2::object::new(arg1),
            token_trade_cap : arg0,
            claim_locked    : true,
            bag             : 0x2::bag::new(arg1),
            module_version  : 0,
        };
        0x2::transfer::share_object<TokenTrades>(v0);
    }

    public fun make_swap_token_x_pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::PoolRegistry, arg2: &TokenTrades, arg3: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T0>, arg4: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg5: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg6: &mut 0x2::token::TokenPolicy<T0>, arg7: 0x2::token::Token<T0>, arg8: u64, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 5036);
        let v0 = 0x2::coin::value<T1>(&arg9) > 0;
        let v1 = 0x2::balance::zero<T0>();
        if (!v0) {
            let (v2, v3) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::sell_tokens_with_tax<T0>(&arg2.token_trade_cap, arg3, arg4, arg7, arg6, arg12);
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg6, v3, arg12);
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(v2));
        } else {
            0x2::token::destroy_zero<T0>(arg7);
        };
        let (v8, v9) = 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::swap_with_tax<T0, T1, T2, T3, T4>(arg0, arg1, arg5, v1, arg8, 0x2::coin::into_balance<T1>(arg9), arg10, arg11);
        let v10 = v8;
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<T1>(v9, 0x2::tx_context::sender(arg12), arg12);
        if (v0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg6, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::buy_tokens_with_tax<T0>(&arg2.token_trade_cap, 0x2::coin::from_balance<T0>(v10, arg12), arg3, arg4, arg6, 0x2::tx_context::sender(arg12), arg12), arg12);
        } else if (0x2::balance::value<T0>(&v10) > 0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg6, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::transfer_without_tax<T0>(&arg2.token_trade_cap, arg6, 0x2::coin::from_balance<T0>(v10, arg12), 0x2::tx_context::sender(arg12), arg12), arg12);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
    }

    public fun make_swap_token_x_pool_w_rewards<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::PoolRegistry, arg2: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::honeyjar::HoneyJar, arg3: &TokenTrades, arg4: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T0>, arg5: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg6: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg7: &mut 0x2::token::TokenPolicy<T0>, arg8: 0x2::token::Token<T0>, arg9: u64, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = 0x2::coin::value<T1>(&arg10) > 0;
        let v1 = 0x2::balance::zero<T0>();
        if (!v0) {
            let (v2, v3) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::sell_tokens_with_tax<T0>(&arg3.token_trade_cap, arg4, arg5, arg8, arg7, arg13);
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg7, v3, arg13);
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(v2));
        } else {
            0x2::token::destroy_zero<T0>(arg8);
        };
        let (v8, v9) = 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::swap_with_rewards_with_tax<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg6, v1, arg9, 0x2::coin::into_balance<T1>(arg10), arg11, arg12);
        let v10 = v8;
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<T1>(v9, 0x2::tx_context::sender(arg13), arg13);
        if (v0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg7, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::buy_tokens_with_tax<T0>(&arg3.token_trade_cap, 0x2::coin::from_balance<T0>(v10, arg13), arg4, arg5, arg7, 0x2::tx_context::sender(arg13), arg13), arg13);
        } else if (0x2::balance::value<T0>(&v10) > 0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg7, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::transfer_without_tax<T0>(&arg3.token_trade_cap, arg7, 0x2::coin::from_balance<T0>(v10, arg13), 0x2::tx_context::sender(arg13), arg13), arg13);
        } else {
            0x2::balance::destroy_zero<T0>(v10);
        };
    }

    public fun make_swap_x_token_pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::PoolRegistry, arg2: &TokenTrades, arg3: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T1>, arg4: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg5: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg6: &mut 0x2::token::TokenPolicy<T1>, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: 0x2::token::Token<T1>, arg10: u64, arg11: bool, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.module_version == 0, 5036);
        let v0 = 0x2::coin::value<T0>(&arg7) > 0;
        let v1 = 0x2::balance::zero<T1>();
        if (!v0) {
            let (v2, v3) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::sell_tokens_with_tax<T1>(&arg2.token_trade_cap, arg3, arg4, arg9, arg6, arg12);
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, v3, arg12);
            0x2::balance::join<T1>(&mut v1, 0x2::coin::into_balance<T1>(v2));
        } else {
            0x2::token::destroy_zero<T1>(arg9);
        };
        let (v8, v9) = 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::swap_with_tax<T0, T1, T2, T3, T4>(arg0, arg1, arg5, 0x2::coin::into_balance<T0>(arg7), arg8, v1, arg10, arg11);
        let v10 = v9;
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<T0>(v8, 0x2::tx_context::sender(arg12), arg12);
        if (v0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::buy_tokens_with_tax<T1>(&arg2.token_trade_cap, 0x2::coin::from_balance<T1>(v10, arg12), arg3, arg4, arg6, 0x2::tx_context::sender(arg12), arg12), arg12);
        } else if (0x2::balance::value<T1>(&v10) > 0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg6, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::transfer_without_tax<T1>(&arg2.token_trade_cap, arg6, 0x2::coin::from_balance<T1>(v10, arg12), 0x2::tx_context::sender(arg12), arg12), arg12);
        } else {
            0x2::balance::destroy_zero<T1>(v10);
        };
    }

    public fun make_swap_x_token_pool_w_rewards<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::PoolRegistry, arg2: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::honeyjar::HoneyJar, arg3: &TokenTrades, arg4: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T1>, arg5: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg6: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg7: &mut 0x2::token::TokenPolicy<T1>, arg8: 0x2::coin::Coin<T0>, arg9: u64, arg10: 0x2::token::Token<T1>, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.module_version == 0, 5036);
        let v0 = 0x2::coin::value<T0>(&arg8) > 0;
        let v1 = 0x2::balance::zero<T1>();
        if (!v0) {
            let (v2, v3) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::sell_tokens_with_tax<T1>(&arg3.token_trade_cap, arg4, arg5, arg10, arg7, arg13);
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg7, v3, arg13);
            0x2::balance::join<T1>(&mut v1, 0x2::coin::into_balance<T1>(v2));
        } else {
            0x2::token::destroy_zero<T1>(arg10);
        };
        let (v8, v9) = 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::swap_with_rewards_with_tax<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg6, 0x2::coin::into_balance<T0>(arg8), arg9, v1, arg11, arg12);
        let v10 = v9;
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<T0>(v8, 0x2::tx_context::sender(arg13), arg13);
        if (v0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg7, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::buy_tokens_with_tax<T1>(&arg3.token_trade_cap, 0x2::coin::from_balance<T1>(v10, arg13), arg4, arg5, arg7, 0x2::tx_context::sender(arg13), arg13), arg13);
        } else if (0x2::balance::value<T1>(&v10) > 0) {
            let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg7, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::transfer_without_tax<T1>(&arg3.token_trade_cap, arg7, 0x2::coin::from_balance<T1>(v10, arg13), 0x2::tx_context::sender(arg13), arg13), arg13);
        } else {
            0x2::balance::destroy_zero<T1>(v10);
        };
    }

    public fun query_swap_token_x_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::PoolRegistry, arg2: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg3: &0x2::token::TokenPolicy<T0>, arg4: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = arg7 > 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        if (!v0) {
            let (v4, v5, v6, v7) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::calculate_sell_tax_amounts<T0>(arg3, arg4, arg5, arg10);
            v1 = v7;
            v2 = v6;
            v3 = v5;
            arg5 = v4;
        };
        let (v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::query_swap<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9);
        let v18 = v9;
        if (v0) {
            let (v19, v20, v21, v22) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::calculate_buy_tax_amounts<T0>(arg3, arg4, v9, arg10);
            v1 = v22;
            v2 = v21;
            v3 = v20;
            v18 = v19;
        };
        (v8, v18, v10, v11, v12, v13, v14, v15, v16, v17, v3, v2, v1)
    }

    public fun query_swap_token_x_pool_info<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::PoolRegistry, arg2: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg3: &0x2::token::TokenPolicy<T0>, arg4: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address) : SwapResultInfo {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12) = query_swap_token_x_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        SwapResultInfo{
            x_offer_amt      : v0,
            x_return_amt     : v1,
            x_total_fee      : v2,
            y_offer_amt      : v3,
            y_return_amt     : v4,
            y_total_fee      : v5,
            creator_fee_amt  : v6,
            amm_fee_amt      : v7,
            protocol_fee_amt : v8,
            error            : v9,
            token_tax_amt    : v10,
            honey_tax_amt    : v11,
            admin_tax_amt    : v12,
        }
    }

    public fun query_swap_x_token_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::PoolRegistry, arg2: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg3: &0x2::token::TokenPolicy<T1>, arg4: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address) : (u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = arg5 > 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        if (!v0) {
            let (v4, v5, v6, v7) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::calculate_sell_tax_amounts<T1>(arg3, arg4, arg7, arg10);
            v1 = v7;
            v2 = v6;
            v3 = v5;
            arg7 = v4;
        };
        let (v8, v9, v10, v11, v12, v13, v14, v15, v16, v17) = 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::query_swap<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg9);
        let v18 = v12;
        if (v0) {
            let (v19, v20, v21, v22) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::calculate_buy_tax_amounts<T1>(arg3, arg4, v12, arg10);
            v1 = v22;
            v2 = v21;
            v3 = v20;
            v18 = v19;
        };
        (v8, v9, v10, v11, v18, v13, v14, v15, v16, v17, v3, v2, v1)
    }

    public fun query_swap_x_token_pool_info<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::PoolRegistry, arg2: &0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg3: &0x2::token::TokenPolicy<T1>, arg4: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: address) : SwapResultInfo {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12) = query_swap_x_token_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        SwapResultInfo{
            x_offer_amt      : v0,
            x_return_amt     : v1,
            x_total_fee      : v2,
            y_offer_amt      : v3,
            y_return_amt     : v4,
            y_total_fee      : v5,
            creator_fee_amt  : v6,
            amm_fee_amt      : v7,
            protocol_fee_amt : v8,
            error            : v9,
            token_tax_amt    : v10,
            honey_tax_amt    : v11,
            admin_tax_amt    : v12,
        }
    }

    public fun remove_liquidity_from_x_token_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &TokenTrades, arg2: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T1>, arg3: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg4: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg5: 0x2::coin::Coin<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T1>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        let v0 = 0x2::coin::into_balance<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(arg5);
        let (v1, v2, v3) = 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::remove_liquidity_burn_tax<T0, T1, T2>(arg0, arg4, 0x2::balance::split<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(&mut v0, arg6), arg7, arg8, arg9);
        0x2::balance::join<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(&mut v0, v3);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<T0>(v1, 0x2::tx_context::sender(arg11), arg11);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg11), arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T1>(arg10, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::from_coin_for_remove_liquidity_with_tax<T1>(&arg1.token_trade_cap, 0x2::coin::from_balance<T1>(v2, arg11), arg2, arg3, arg10, 0x2::tx_context::sender(arg11), arg11), arg11);
    }

    public fun remove_liquidity_token_x_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &TokenTrades, arg2: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T0>, arg3: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg4: &mut 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LiquidityPool<T0, T1, T2>, arg5: 0x2::coin::Coin<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::token::TokenPolicy<T0>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 5036);
        let v0 = 0x2::coin::into_balance<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(arg5);
        let (v1, v2, v3) = 0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::remove_liquidity_burn_tax<T0, T1, T2>(arg0, arg4, 0x2::balance::split<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(&mut v0, arg6), arg7, arg8, arg9);
        0x2::balance::join<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(&mut v0, v3);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg11), arg11);
        0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::coin_helper::destroy_or_transfer_balance<0xb8874ad9153a01efc9f048bd94f79b13b1cac473a086165d0739b2352d2e475e::amm::LP<T0, T1, T2>>(v0, 0x2::tx_context::sender(arg11), arg11);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg10, 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::from_coin_for_remove_liquidity_with_tax<T0>(&arg1.token_trade_cap, 0x2::coin::from_balance<T0>(v1, arg11), arg2, arg3, arg10, 0x2::tx_context::sender(arg11), arg11), arg11);
    }

    public fun transfer_token<T0>(arg0: 0x2::token::Token<T0>, arg1: &mut 0x2::token::TokenPolicy<T0>, arg2: &mut 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::FeeCollector<T0>, arg3: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYield, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::transfer_with_tax<T0>(0x2::token::split<T0>(&mut arg0, arg4, arg6), arg5, arg2, arg3, arg1, arg6);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg1, v1, arg6);
        0x2::token::destroy_zero<T0>(v0);
        let (v6, v7) = 0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::token_rules::transfer_with_tax<T0>(arg0, 0x2::tx_context::sender(arg6), arg2, arg3, arg1, arg6);
        let (_, _, _, _) = 0x2::token::confirm_request<T0>(arg1, v7, arg6);
        0x2::token::destroy_zero<T0>(v6);
    }

    public fun unlock_honey_claim(arg0: &0x196e804e4bbd815f06ebc29a48c7999462e7eed67c36a2cd8d1f1386d47ea106::honey_yield::HoneyYieldAdminCap, arg1: &mut TokenTrades) {
        arg1.claim_locked = false;
    }

    // decompiled from Move bytecode v6
}

