module 0x4b7cbfe12b1c96e05ddc3a6c57d8bad8195ed51fb3905aae114fbb5d3acb251c::heo {
    struct SwapEvent has copy, drop, store {
        out: u64,
        a: u64,
        b: u64,
    }

    public entry fun p2<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg3, true, arg4, v0, arg5);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        if (arg3) {
            assert!(0x2::balance::value<T0>(&v6) == 0, 1);
            0x2::balance::destroy_zero<T0>(v6);
            let (v8, v9) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg6)), 0x2::balance::value<T1>(&v5), arg5, arg6);
            let v10 = v9;
            let v11 = v8;
            assert!(0x2::coin::value<T1>(&v11) == 0, 2);
            0x2::coin::destroy_zero<T1>(v11);
            assert!(0x2::coin::value<T0>(&v10) > v7, 3);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v10, v7, arg6)), 0x2::balance::zero<T1>(), v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x2::tx_context::sender(arg6));
        } else {
            assert!(0x2::balance::value<T1>(&v5) == 0, 4);
            0x2::balance::destroy_zero<T1>(v5);
            let (v12, v13) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg6)), 0x2::balance::value<T0>(&v6), arg5, arg6);
            let v14 = v13;
            let v15 = v12;
            assert!(0x2::coin::value<T0>(&v15) == 0, 5);
            0x2::coin::destroy_zero<T0>(v15);
            assert!(0x2::coin::value<T1>(&v14) > v7, 6);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v14, v7, arg6)), v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, 0x2::tx_context::sender(arg6));
        };
    }

    public entry fun do_swap_x_y<T0, T1>(arg0: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T0>>(arg1), arg2, arg3, arg4);
        let v2 = v1;
        let v3 = v0;
        transfer_or_destory<T0>(v3, arg4);
        transfer_or_destory<T1>(v2, arg4);
        let v4 = SwapEvent{
            out : arg2,
            a   : 0x2::coin::value<T0>(&v3),
            b   : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<SwapEvent>(v4);
    }

    public entry fun p<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T1, T0>, arg3: bool, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price()
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price()
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, arg5, v0, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4);
        if (arg4) {
            assert!(0x2::balance::value<T0>(&v6) == 0, 1);
            0x2::balance::destroy_zero<T0>(v6);
            let (v8, v9) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T1, T0>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg7)), 0x2::balance::value<T1>(&v5), arg6, arg7);
            let v10 = v9;
            let v11 = v8;
            assert!(0x2::coin::value<T1>(&v11) == 0, 2);
            0x2::coin::destroy_zero<T1>(v11);
            assert!(0x2::coin::value<T0>(&v10) > v7, 3);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v10, v7, arg7)), 0x2::balance::zero<T1>(), v4);
            if (arg3) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, 0x2::tx_context::sender(arg7));
            } else {
                0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::swap_y_to_x_all<T1, T0>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T0>>(v10), 0, arg6, arg7);
            };
        } else {
            assert!(0x2::balance::value<T1>(&v5) == 0, 4);
            0x2::balance::destroy_zero<T1>(v5);
            let (v12, v13) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T1, T0>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg7)), 0x2::balance::value<T0>(&v6), arg6, arg7);
            let v14 = v13;
            let v15 = v12;
            assert!(0x2::coin::value<T0>(&v15) == 0, 5);
            0x2::coin::destroy_zero<T0>(v15);
            assert!(0x2::coin::value<T1>(&v14) > v7, 6);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v14, v7, arg7)), v4);
            if (arg3) {
                0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::swap_x_to_y_all<T1, T0>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T1>>(v14), 0, arg6, arg7);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, 0x2::tx_context::sender(arg7));
            };
        };
    }

    fun transfer_or_destory<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

