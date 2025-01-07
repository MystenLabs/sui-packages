module 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::cetus {
    public(friend) fun swap<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = if (arg3) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg0, arg3, arg4, arg5, v0, arg7);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg3) {
        };
        let (v7, v8) = if (arg3) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg8)))
        };
        0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v5, arg8));
        0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v6, arg8));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg0, v7, v8, v4);
        (arg1, arg2)
    }

    public(friend) fun add_prices<T0, T1>(arg0: &mut vector<0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::PriceNode>, arg1: u64, arg2: u64, arg3: u16, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4);
        let v1 = 18446744073709551616 - 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::to_128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg4)) / 2000000;
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg4) != 0) {
            0x1::vector::push_back<0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::PriceNode>(arg0, 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::new_price_node(arg1, arg2, arg3, 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::mul_128(v0, v1)));
            0x1::vector::push_back<0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::PriceNode>(arg0, 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::new_price_node(arg2, arg1, arg3, 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::mul_128(0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::inv_128(v0), v1)));
        };
    }

    public(friend) fun add_prices_no_fee<T0, T1>(arg0: &mut vector<0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::PriceNode>, arg1: u64, arg2: u64, arg3: u16, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4);
        0x1::vector::push_back<0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::PriceNode>(arg0, 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::new_price_node(arg1, arg2, arg3, v0));
        0x1::vector::push_back<0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::PriceNode>(arg0, 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::paths::new_price_node(arg2, arg1, arg3, 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::inv_128(v0)));
    }

    public(friend) fun get_sqrt_price<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool) : u128 {
        if (arg1) {
            0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::mul_128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 18446744073709551616 - 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::to_128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0)) / 2000000)
        } else {
            0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::mul_128(0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::inv_128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0)), 18446744073709551616 - 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::to_128(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0)) / 2000000)
        }
    }

    public(friend) fun swap_bag<T0, T1>(arg0: &mut u128, arg1: &mut 0x2::bag::Bag, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u16, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 == 0;
        if (v0) {
            let v1 = swap_sell<T0, T1>(arg2, 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T0>>(arg1, b""), arg4, arg5, arg6);
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T1>>(arg1, b"", v1);
            *arg0 = 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::mul_128(*arg0, get_sqrt_price<T0, T1>(arg2, v0));
        } else {
            let v2 = swap_buy<T1, T0>(arg2, 0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T1>>(arg1, b""), arg4, arg5, arg6);
            0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(arg1, b"", v2);
            *arg0 = 0x41d93363eb418511ab3d94492512b8d9ffd34513ef92516bbdd0bd5eeb375d61::arithmetic::mul_128(*arg0, get_sqrt_price<T0, T1>(arg2, v0));
        };
    }

    public(friend) fun swap_buy<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg4);
        let (v1, v2) = swap<T1, T0>(arg0, v0, arg1, false, true, 0x2::coin::value<T0>(&arg1), arg2, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v2);
        v1
    }

    public(friend) fun swap_sell<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg4);
        let (v1, v2) = swap<T0, T1>(arg0, arg1, v0, true, true, 0x2::coin::value<T0>(&arg1), arg2, arg3, arg4);
        0x2::coin::destroy_zero<T0>(v1);
        v2
    }

    // decompiled from Move bytecode v6
}

