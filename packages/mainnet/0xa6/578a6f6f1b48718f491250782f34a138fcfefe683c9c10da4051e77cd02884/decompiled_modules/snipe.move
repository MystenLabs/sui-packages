module 0xa6578a6f6f1b48718f491250782f34a138fcfefe683c9c10da4051e77cd02884::snipe {
    public fun bolt_to_db_price(arg0: u128) : u64 {
        (((arg0 as u256) / 1000000000) as u64)
    }

    public entry fun db_buy_bolt_sell<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < 10000, 4);
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg2, arg3);
        assert!(v0 > 0, 3);
        let v2 = with_margin(bolt_to_db_price(v0), arg5, false);
        let (v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 1, v2, false, arg3);
        let v5 = v4;
        let v6 = v3;
        let (_, v8) = scan_levels(&v6, &v5, v2, false);
        let v9 = v8;
        assert!(v8 > 0, 1);
        if (v8 > arg4) {
            v9 = arg4;
        };
        let (v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, v9, arg7);
        let (v12, v13, v14) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, v10, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), 0, arg3, arg7);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v14);
        let (v15, v16) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg1, arg2, arg3, 0x2::coin::into_balance<T0>(v12), 0x1::option::none<u64>(), arg7);
        let v17 = v16;
        0x2::balance::join<T1>(&mut v17, 0x2::coin::into_balance<T1>(v13));
        assert!(0x2::balance::value<T1>(&v17) >= v9 + arg6, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v17, v9), arg7), v11);
        pay_out<T1>(v17, arg7);
        pay_out<T0>(v15, arg7);
    }

    public entry fun db_sell_bolt_buy<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < 10000, 4);
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg2, arg3);
        assert!(v0 > 0, 3);
        let v2 = with_margin(bolt_to_db_price(v0), arg5, true);
        let (v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, v2, 18446744073709551615, true, arg3);
        let v5 = v4;
        let v6 = v3;
        let (v7, _) = scan_levels(&v6, &v5, v2, true);
        let v9 = v7;
        assert!(v7 > 0, 1);
        if (v7 > arg4) {
            v9 = arg4;
        };
        let (v10, v11) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, v9, arg7);
        let (v12, v13, v14) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, v10, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), 0, arg3, arg7);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v14);
        let (v15, v16) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg1, arg2, arg3, 0x2::coin::into_balance<T1>(v13), 0x1::option::none<u64>(), arg7);
        let v17 = v15;
        0x2::balance::join<T0>(&mut v17, 0x2::coin::into_balance<T0>(v12));
        assert!(0x2::balance::value<T0>(&v17) >= v9 + arg6, 2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v17, v9), arg7), v11);
        pay_out<T0>(v17, arg7);
        pay_out<T1>(v16, arg7);
    }

    fun pay_out<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    public fun scan_levels(arg0: &vector<u64>, arg1: &vector<u64>, arg2: u64, arg3: bool) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg0)) {
            let v3 = *0x1::vector::borrow<u64>(arg0, v2);
            if (arg3 && v3 >= arg2 || v3 <= arg2) {
                let v4 = *0x1::vector::borrow<u64>(arg1, v2);
                v0 = v0 + v4;
                v1 = v1 + (((v4 as u256) * (v3 as u256) / 1000000000) as u64);
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun with_margin(arg0: u64, arg1: u64, arg2: bool) : u64 {
        let v0 = if (arg2) {
            (arg0 as u256) * (10000 + (arg1 as u256)) / 10000
        } else {
            (arg0 as u256) * (10000 - (arg1 as u256)) / 10000
        };
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

