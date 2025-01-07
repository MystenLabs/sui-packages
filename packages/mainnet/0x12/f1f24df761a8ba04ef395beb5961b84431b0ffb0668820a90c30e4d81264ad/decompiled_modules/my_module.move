module 0x12f1f24df761a8ba04ef395beb5961b84431b0ffb0668820a90c30e4d81264ad::my_module {
    struct Sword has store, key {
        id: 0x2::object::UID,
        magic: u64,
        strength: u64,
    }

    struct Forge has store, key {
        id: 0x2::object::UID,
        swords_created: u64,
    }

    struct SwapEvent has copy, drop {
        amount_y_out: u64,
    }

    struct SwapEvent3 has copy, drop {
        amount_y_out1: u64,
        amount_y_out2: u64,
        amount_y_out3: u64,
    }

    struct AdminData has copy, drop, store {
        dao_fee_to: address,
        admin_address: address,
        dao_fee: u64,
        swap_fee: u64,
        dao_fee_on: bool,
        is_pause: bool,
    }

    public fun animeswap_get_amount_out<T0, T1>(arg0: u64, arg1: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools) : u64 {
        if (0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::compare<T0, T1>()) {
            let (v1, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_pool<T0, T1>(arg1);
            let (v3, v4) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_reserves_size<T0, T1>(v1);
            0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::get_amount_out(arg0, v3, v4, 30)
        } else {
            let (v5, _) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_pool<T1, T0>(arg1);
            let (v7, v8) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::get_reserves_size<T1, T0>(v5);
            0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::get_amount_out(arg0, v8, v7, 30)
        }
    }

    public entry fun animeswap_swap<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = animeswap_swap_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun animeswap_swap_<T0, T1>(arg0: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap_library::compare<T0, T1>()) {
            let (v1, v2) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T0, T1>(arg0, arg1, 0x2::coin::split<T0>(&mut arg2, arg3, arg5), 0x2::coin::zero<T1>(arg5), arg5);
            0x2::coin::destroy_zero<T0>(v1);
            0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::return_remaining_coin<T0>(arg2, arg5);
            v2
        } else {
            let (v3, v4) = 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::swap_coins_for_coins<T1, T0>(arg0, arg1, 0x2::coin::zero<T1>(arg5), 0x2::coin::split<T0>(&mut arg2, arg3, arg5), arg5);
            0x2::coin::destroy_zero<T0>(v4);
            0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::return_remaining_coin<T0>(arg2, arg5);
            v3
        }
    }

    public fun cetus_get_amount_out<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, arg2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
    }

    public fun cetus_swap_<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg2) {
            let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, 4295048017, arg4);
            let v3 = v2;
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v0, arg7));
            0x2::coin::join<T1>(&mut arg6, 0x2::coin::from_balance<T1>(v1, arg7));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg7)), 0x2::balance::zero<T1>(), v3);
            (arg5, arg6)
        } else {
            let (v4, v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, 79226673515401279992447579050, arg4);
            let v7 = v6;
            0x2::coin::join<T0>(&mut arg5, 0x2::coin::from_balance<T0>(v4, arg7));
            0x2::coin::join<T1>(&mut arg6, 0x2::coin::from_balance<T1>(v5, arg7));
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v7), arg7)), v7);
            (arg5, arg6)
        }
    }

    public entry fun cetus_swap_btoa<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg6, 0x2::tx_context::sender(arg7));
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg7), 0x2::tx_context::sender(arg7));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg6, arg3, arg7)), v2);
    }

    public fun get_amount_out_<T0, T1>(arg0: u64, arg1: u8, arg2: bool, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools) : u64 {
        let v0 = 0;
        if (arg1 == 1) {
            v0 = cetus_get_amount_out<T0, T1>(arg3, arg2, arg0);
        } else if (arg1 == 2) {
            if (arg2) {
                v0 = animeswap_get_amount_out<T0, T1>(arg0, arg4);
            } else {
                v0 = animeswap_get_amount_out<T1, T0>(arg0, arg4);
            };
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Forge{
            id             : 0x2::object::new(arg0),
            swords_created : 0,
        };
        0x2::transfer::transfer<Forge>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun magic(arg0: &Sword) : u64 {
        arg0.magic
    }

    public fun strength(arg0: &Sword) : u64 {
        arg0.strength
    }

    public entry fun swap_3_1<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: u8, arg9: u8, arg10: u8, arg11: 0x2::coin::Coin<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = false;
        let v1 = true;
        let v2 = true;
        let v3 = get_amount_out_<T1, T0>(arg2, arg8, v0, arg1, arg4);
        let v4 = get_amount_out_<T1, T2>(v3, arg9, v1, arg6, arg4);
        let v5 = get_amount_out_<T2, T3>(v4, arg10, v2, arg7, arg4);
        let v6 = SwapEvent3{
            amount_y_out1 : v3,
            amount_y_out2 : v4,
            amount_y_out3 : v5,
        };
        0x2::event::emit<SwapEvent3>(v6);
        assert!(v5 >= arg5, 111);
        let v7 = 0x2::coin::zero<T1>(arg12);
        let (v8, v9) = swap_return_coin<T1, T0>(v7, arg11, arg0, arg2, arg8, v0, arg1, arg4, arg3, arg12);
        let v10 = 0x2::coin::zero<T2>(arg12);
        let (v11, v12) = swap_return_coin<T1, T2>(v8, v10, arg0, arg2, arg9, v1, arg6, arg4, arg3, arg12);
        let v13 = 0x2::coin::zero<T3>(arg12);
        let (v14, v15) = swap_return_coin<T2, T3>(v12, v13, arg0, arg2, arg10, v2, arg7, arg4, arg3, arg12);
        0x2::coin::destroy_zero<T0>(v9);
        0x2::coin::destroy_zero<T1>(v11);
        0x2::coin::destroy_zero<T2>(v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(v15, 0x2::tx_context::sender(arg12));
    }

    public entry fun swap_3_2<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg5: u64, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg8: u8, arg9: u8, arg10: u8, arg11: 0x2::coin::Coin<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg11, 0x2::tx_context::sender(arg12));
    }

    public fun swap_return_coin<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: u64, arg4: u8, arg5: bool, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: &mut 0x88d362329ede856f5f67867929ed570bba06c975abec2fab7f0601c56f6a8cb1::animeswap::LiquidityPools, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg4 == 1) {
            cetus_swap_<T0, T1>(arg2, arg6, arg5, arg3, arg8, arg0, arg1, arg9)
        } else if (arg5) {
            let v2 = animeswap_swap_<T0, T1>(arg7, arg8, arg0, arg3, 1, arg9);
            0x2::coin::join<T1>(&mut arg1, v2);
            (0x2::coin::zero<T0>(arg9), arg1)
        } else {
            let v3 = animeswap_swap_<T1, T0>(arg7, arg8, arg1, arg3, 1, arg9);
            0x2::coin::join<T0>(&mut arg0, v3);
            (arg0, 0x2::coin::zero<T1>(arg9))
        }
    }

    public fun swords_created(arg0: &Forge) : u64 {
        arg0.swords_created
    }

    // decompiled from Move bytecode v6
}

