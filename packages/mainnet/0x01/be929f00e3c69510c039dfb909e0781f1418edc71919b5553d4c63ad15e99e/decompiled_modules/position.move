module 0x1be929f00e3c69510c039dfb909e0781f1418edc71919b5553d4c63ad15e99e::position {
    public fun flash_pool<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u32, arg6: u32, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, arg5, arg6, arg8);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, arg4, true, arg7);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        let (v4, v5) = 0x1be929f00e3c69510c039dfb909e0781f1418edc71919b5553d4c63ad15e99e::flash_loan::borrow_a_repay_a_later<T0, T1>(arg0, arg1, v2, arg7, arg8);
        let v6 = v5;
        let (v7, v8) = 0x1be929f00e3c69510c039dfb909e0781f1418edc71919b5553d4c63ad15e99e::flash_loan::borrow_b_repay_b_later<T0, T1>(arg0, arg1, v3, arg7, arg8);
        let v9 = v8;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v4), 0x2::coin::into_balance<T1>(v7), v1);
        let (v10, v11) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut v0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0), arg7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg0, arg1, v0);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v10, arg8));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v11, arg8));
        0x1be929f00e3c69510c039dfb909e0781f1418edc71919b5553d4c63ad15e99e::flash_loan::repay_a<T0, T1>(arg0, arg1, 0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6), arg8), v6);
        0x1be929f00e3c69510c039dfb909e0781f1418edc71919b5553d4c63ad15e99e::flash_loan::repay_b<T0, T1>(arg0, arg1, 0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg8), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg8));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

