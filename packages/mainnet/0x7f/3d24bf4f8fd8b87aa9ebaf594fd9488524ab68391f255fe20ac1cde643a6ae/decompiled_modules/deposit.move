module 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::deposit {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        liquidity_initial: u128,
        liquidity_final: u128,
        vault_coin_minted: u64,
        lp_coin_a: u64,
        lp_coin_b: u64,
        sender: address,
    }

    public fun deposit<T0, T1, T2>(arg0: &mut 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::version::assert_current_version(arg8);
        0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        assert!(0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::seed_balance<T0, T1, T2>(arg0) > 0, 4);
        assert!(0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::is_deposit_enabled<T0, T1, T2>(arg0), 7);
        let (v0, v1) = 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::get_position_tick_range<T0, T1, T2>(arg0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1);
        let (v3, v4, v5) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v2, v0)) {
            (0x2::coin::value<T0>(&arg3), 0, true)
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v2, v1)) {
            (0, 0x2::coin::value<T1>(&arg4), false)
        } else {
            let (v6, v7, v8) = 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::utils::check_is_fix_coin_a(v0, v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x2::coin::value<T0>(&arg3), 0x2::coin::value<T1>(&arg4));
            (v7, v8, v6)
        };
        assert!(v3 >= arg5, 5);
        assert!(v4 >= arg6, 6);
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::position_borrow<T0, T1, T2>(arg0));
        let v10 = if (v5) {
            v3
        } else {
            v4
        };
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::position_borrow_mut<T0, T1, T2>(arg0), v10, v5, arg7);
        let (v12, v13, v14, v15) = take_lp_coins<T0, T1>(&v11, arg3, arg4, arg9);
        let v16 = v13;
        let v17 = v12;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::coin::into_balance<T0>(v17), 0x2::coin::into_balance<T1>(v16), v11);
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::position_borrow<T0, T1, T2>(arg0));
        let v19 = 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::mint_vault_coin<T0, T1, T2>(arg0, v18 - v9, v9, arg9);
        emit_event(0x2::object::id<0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::Vault<T0, T1, T2>>(arg0), v9, v18, 0x2::coin::value<T2>(&v19), 0x2::coin::value<T0>(&v17), 0x2::coin::value<T1>(&v16), 0x2::tx_context::sender(arg9));
        (v19, v14, v15)
    }

    public entry fun deposit_entry<T0, T1, T2>(arg0: &mut 0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x7f3d24bf4f8fd8b87aa9ebaf594fd9488524ab68391f255fe20ac1cde643a6ae::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = deposit<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v4), 0x2::tx_context::sender(arg9));
        };
        if (0x1::option::is_some<0x2::coin::Coin<T1>>(&v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::extract<0x2::coin::Coin<T1>>(&mut v3), 0x2::tx_context::sender(arg9));
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v4);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg9));
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

    fun emit_event(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: address) {
        let v0 = DepositEvent{
            vault_id          : arg0,
            liquidity_initial : arg1,
            liquidity_final   : arg2,
            vault_coin_minted : arg3,
            lp_coin_a         : arg4,
            lp_coin_b         : arg5,
            sender            : arg6,
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

