module 0x303102c57f63abdc744f42ba42a96d58c6565f2706a9dd09efb7d4c6901b85a1::executor {
    public entry fun arbitrage_pool<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg1);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T1, T0>(arg3);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg3);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1);
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T1, T0>(arg3);
        let v6 = 0x1::vector::empty<u128>();
        let v7 = &mut v6;
        0x1::vector::push_back<u128>(v7, v0);
        0x1::vector::push_back<u128>(v7, v1);
        let v8 = 0x1::vector::empty<u128>();
        let v9 = &mut v8;
        0x1::vector::push_back<u128>(v9, v2);
        0x1::vector::push_back<u128>(v9, v3);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v4);
        0x1::vector::push_back<u64>(v11, v5);
        let v12 = 0x303102c57f63abdc744f42ba42a96d58c6565f2706a9dd09efb7d4c6901b85a1::factory::best_trade_amount(v6, v8, v10);
        if (v12 > 0) {
            let (v13, v14, v15) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v12, 4295048016, arg4);
            let v16 = v14;
            let v17 = 0x2::balance::value<T1>(&v16);
            let (v18, v19, v20) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T0>(arg3, true, true, v17, 4295048016, arg4, arg2, arg5);
            let v21 = v19;
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v21, v12), 0x2::balance::zero<T1>(), v15);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T0>(arg3, v20, 0x2::balance::split<T1>(&mut v16, v17), 0x2::balance::zero<T0>(), arg2, arg5);
            0x2::balance::destroy_zero<T1>(v16);
            0x2::balance::destroy_zero<T0>(v13);
            0x2::balance::destroy_zero<T1>(v18);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg5), 0x2::tx_context::sender(arg5));
            return
        };
        let v22 = 0x1::vector::empty<u128>();
        let v23 = &mut v22;
        0x1::vector::push_back<u128>(v23, v1);
        0x1::vector::push_back<u128>(v23, v0);
        let v24 = 0x1::vector::empty<u128>();
        let v25 = &mut v24;
        0x1::vector::push_back<u128>(v25, ((340282366920938463463374607431768211456 / (v3 as u256)) as u128));
        0x1::vector::push_back<u128>(v25, ((340282366920938463463374607431768211456 / (v2 as u256)) as u128));
        let v26 = 0x1::vector::empty<u64>();
        let v27 = &mut v26;
        0x1::vector::push_back<u64>(v27, v5);
        0x1::vector::push_back<u64>(v27, v4);
        let v28 = 0x303102c57f63abdc744f42ba42a96d58c6565f2706a9dd09efb7d4c6901b85a1::factory::best_trade_amount(v22, v24, v26);
        if (v28 > 0) {
            let (v29, v30, v31) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T1, T0>(arg3, false, true, v28, 79226673515401279992447579055, arg4, arg2, arg5);
            let v32 = v29;
            let v33 = 0x2::balance::value<T1>(&v32);
            let (v34, v35, v36) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v33, 79226673515401279992447579055, arg4);
            let v37 = v34;
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T1, T0>(arg3, v31, 0x2::balance::zero<T1>(), 0x2::balance::split<T0>(&mut v37, v28), arg2, arg5);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v32, v33), v36);
            0x2::balance::destroy_zero<T1>(v32);
            0x2::balance::destroy_zero<T0>(v30);
            0x2::balance::destroy_zero<T1>(v35);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v37, arg5), 0x2::tx_context::sender(arg5));
            return
        };
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public entry fun swap_turbos_pool<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg2);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b<T0, T1, T2>(arg1, v0, arg5, 0, arg6, false, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7), arg7, arg0, arg8);
            send_coin<T1>(arg3, 0x2::tx_context::sender(arg8));
        } else {
            let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, arg3);
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg1, v1, arg5, 0, arg6, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7), arg7, arg0, arg8);
            send_coin<T0>(arg2, 0x2::tx_context::sender(arg8));
        };
    }

    // decompiled from Move bytecode v6
}

