module 0x48da52844a5e1b2e87b1e81dfce74101b678d670fe194809a383a058cbcd7c44::bolt {
    public(friend) fun borrowable(arg0: u64, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = (arg3 as u128);
        let v2 = v0 * 10000 / (10000 + v1);
        let v3 = v2;
        if (v2 + 1 + (v2 + 1) * v1 / 10000 <= v0) {
            v3 = v2 + 1;
        };
        let v4 = (0x1::u256::min((((v3 as u256) + 1) * (arg1 as u256) - 1) / (arg2 as u256), (arg4 as u256)) as u64);
        if (v4 == 0 || (v4 as u256) * (arg2 as u256) / (arg1 as u256) == 0) {
            0
        } else {
            v4
        }
    }

    public fun buy<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), false, 0);
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg1, arg2, arg4, arg3, 0x1::option::none<u64>(), arg5);
        refund<T1>(v1, arg5);
        v0
    }

    public fun flash_sell<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::FlashSwapPromise<T0, T1>) {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T0>(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), true, 0);
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg2, arg4);
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::flash_borrow<T0, T1>(arg1, arg2, arg4, borrowable(0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::open_loan<T0>(arg0), v0, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision(), arg3, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg1)), arg5)
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: bool, arg4: &0x2::clock::Clock) {
        let v0 = if (arg3) {
            let (v1, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg2, arg4);
            let v3 = vector[];
            let v4 = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amounts<T2>(arg0);
            0x1::vector::reverse<u64>(&mut v4);
            let v5 = 0;
            while (v5 < 0x1::vector::length<u64>(&v4)) {
                let v6 = 0x1::vector::pop_back<u64>(&mut v4);
                let v7 = if (v6 == 0 || (v6 as u128) * 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision() / v1 > (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg1) as u128)) {
                    0
                } else {
                    let v8 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg1, arg2, arg4, v6);
                    let (_, v10, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v8);
                    v10
                };
                0x1::vector::push_back<u64>(&mut v3, v7);
                v5 = v5 + 1;
            };
            0x1::vector::destroy_empty<u64>(v4);
            v3
        } else {
            let v18 = vector[];
            let v19 = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amounts<T2>(arg0);
            0x1::vector::reverse<u64>(&mut v19);
            let v20 = 0;
            while (v20 < 0x1::vector::length<u64>(&v19)) {
                let v21 = 0x1::vector::pop_back<u64>(&mut v19);
                let v22 = if (v21 == 0) {
                    0
                } else {
                    let v23 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg1, arg2, arg4, v21);
                    let (v24, _, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v23);
                    v24
                };
                0x1::vector::push_back<u64>(&mut v18, v22);
                v20 = v20 + 1;
            };
            0x1::vector::destroy_empty<u64>(v19);
            v18
        };
        let v33 = v0;
        let v34 = &v33;
        let v35 = vector[];
        let v36 = 0;
        while (v36 < 0x1::vector::length<u64>(v34)) {
            0x1::vector::push_back<u64>(&mut v35, 0);
            v36 = v36 + 1;
        };
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_quote<T2>(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), arg3, v33, v35);
    }

    public fun quote_flash<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: u64, arg4: &0x2::clock::Clock) {
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg2, arg4);
        let v2 = vector[];
        let v3 = 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::amounts<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v3)) {
            0x1::vector::push_back<u64>(&mut v2, borrowable(0x1::vector::pop_back<u64>(&mut v3), v0, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision(), arg3, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg1)));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u64>(v3);
        let v5 = &v2;
        let v6 = vector[];
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(v5)) {
            0x1::vector::push_back<u64>(&mut v6, 0);
            v7 = v7 + 1;
        };
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_quote<T0>(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), true, v2, v6);
    }

    fun refund<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun repay_sell<T0, T1>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::FlashSwapPromise<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::promise_inner<T0, T1>(&arg2);
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::keep<T0>(arg0, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::flash_repay<T0, T1>(arg1, arg2, 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::close_loan<T0>(arg0, v2), arg3));
    }

    public fun sell<T0, T1, T2>(arg0: &mut 0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::Session<T2>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x6c088e567321dbcf28a9d24d6c75d3dc66e13b3d371fdc6a66a12ec444a99842::session::record_leg<T2>(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), true, 0);
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg1, arg2, arg4, arg3, 0x1::option::none<u64>(), arg5);
        refund<T0>(v0, arg5);
        v1
    }

    // decompiled from Move bytecode v7
}

