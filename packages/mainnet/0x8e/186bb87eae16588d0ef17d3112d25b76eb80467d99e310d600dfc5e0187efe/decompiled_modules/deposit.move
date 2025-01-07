module 0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::deposit {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        liquidity_initial: u128,
        liquidity_final: u128,
        vault_coin_minted: u64,
        lp_coin_a: u64,
        lp_coin_b: u64,
    }

    public fun deposit<T0, T1, T2>(arg0: &mut 0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        assert!(0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::seed_balance<T0, T1, T2>(arg0) > 0, 4);
        assert!(0x2::coin::value<T0>(&arg3) > 0, 2);
        assert!(0x2::coin::value<T1>(&arg4) > 0, 3);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::position_borrow<T0, T1, T2>(arg0));
        let v1 = if (arg5) {
            0x2::coin::value<T0>(&arg3)
        } else {
            0x2::coin::value<T1>(&arg4)
        };
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::position_borrow_mut<T0, T1, T2>(arg0), v1, arg5, arg6);
        let (v3, v4, v5, v6) = take_lp_coins<T0, T1>(&v2, arg3, arg4, arg7);
        let v7 = v4;
        let v8 = v3;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::coin::into_balance<T0>(v8), 0x2::coin::into_balance<T1>(v7), v2);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::position_borrow<T0, T1, T2>(arg0));
        let v10 = 0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::mint_vault_coin<T0, T1, T2>(arg0, v9 - v0, v0, arg7);
        emit_event(0x2::object::id<0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::Vault<T0, T1, T2>>(arg0), v0, v9, 0x2::coin::value<T2>(&v10), 0x2::coin::value<T0>(&v8), 0x2::coin::value<T1>(&v7));
        (v10, v5, v6)
    }

    public entry fun deposit_entry<T0, T1, T2>(arg0: &mut 0x8e186bb87eae16588d0ef17d3112d25b76eb80467d99e310d600dfc5e0187efe::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v4), 0x2::tx_context::sender(arg7));
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v3), 0x2::tx_context::sender(arg7));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg7));
    }

    fun destroy_if_zero<T0>(arg0: 0x2::coin::Coin<T0>) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        let v0 = 0x1::option::none<0x2::coin::Coin<T0>>();
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x1::option::fill<0x2::coin::Coin<T0>>(&mut v0, arg0);
        };
        v0
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = DepositEvent{
            vault_id          : arg0,
            liquidity_initial : arg1,
            liquidity_final   : arg2,
            vault_coin_minted : arg3,
            lp_coin_a         : arg4,
            lp_coin_b         : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    fun take_lp_coins<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::AddLiquidityReceipt<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) >= v0, 0);
        assert!(0x2::coin::value<T1>(&arg2) >= v1, 1);
        (0x2::coin::split<T0>(&mut arg1, v0, arg3), 0x2::coin::split<T1>(&mut arg2, v1, arg3), destroy_if_zero<T0>(arg1), destroy_if_zero<T1>(arg2))
    }

    // decompiled from Move bytecode v6
}

