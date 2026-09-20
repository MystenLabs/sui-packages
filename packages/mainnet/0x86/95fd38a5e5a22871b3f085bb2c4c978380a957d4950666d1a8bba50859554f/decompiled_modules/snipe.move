module 0x8695fd38a5e5a22871b3f085bb2c4c978380a957d4950666d1a8bba50859554f::snipe {
    public entry fun cetus_buy_bolt_sell<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 < 10000, 4);
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg3, arg4);
        assert!(v0 > 0, 3);
        let v2 = limit_sqrt(v0, arg6, true);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) > v2, 1);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg5, v2, arg4);
        let v6 = v5;
        0x2::balance::destroy_zero<T0>(v3);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        let (v8, v9) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T1, T0>(arg2, arg3, arg4, v4, 0x1::option::none<u64>(), arg8);
        let v10 = v9;
        assert!(0x2::balance::value<T0>(&v10) >= v7 + arg7, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v10, v7), 0x2::balance::zero<T1>(), v6);
        pay_out<T0>(v10, arg8);
        pay_out<T1>(v8, arg8);
    }

    public entry fun cetus_sell_bolt_buy<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T1>, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 < 10000, 4);
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg3, arg4);
        assert!(v0 > 0, 3);
        let v2 = limit_sqrt(v0, arg6, false);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) < v2, 1);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg5, v2, arg4);
        let v6 = v5;
        0x2::balance::destroy_zero<T1>(v4);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6);
        let (v8, v9) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T1, T0>(arg2, arg3, arg4, v3, 0x1::option::none<u64>(), arg8);
        let v10 = v8;
        assert!(0x2::balance::value<T1>(&v10) >= v7 + arg7, 2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v10, v7), v6);
        pay_out<T1>(v10, arg8);
        pay_out<T0>(v9, arg8);
    }

    public fun limit_sqrt(arg0: u128, arg1: u64, arg2: bool) : u128 {
        let v0 = if (arg2) {
            (1000000000000000000 << 128) / (arg0 as u256) * (10000 + (arg1 as u256)) / 10000
        } else {
            (1000000000000000000 << 128) / (arg0 as u256) * (10000 - (arg1 as u256)) / 10000
        };
        let v1 = sqrt_u256(v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price();
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price();
        if (v1 < (v2 as u256)) {
            v2
        } else if (v1 > (v3 as u256)) {
            v3
        } else {
            (v1 as u128)
        }
    }

    fun pay_out<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v7
}

