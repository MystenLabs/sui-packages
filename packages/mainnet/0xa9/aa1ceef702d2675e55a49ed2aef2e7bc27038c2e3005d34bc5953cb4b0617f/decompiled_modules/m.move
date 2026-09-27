module 0xa9aa1ceef702d2675e55a49ed2aef2e7bc27038c2e3005d34bc5953cb4b0617f::m {
    public fun ba<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x9209954156fd8049606b5f0f7157595e3ffeb2338d6b555f2b455296ba312f40::m::ba<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun bb<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x9209954156fd8049606b5f0f7157595e3ffeb2338d6b555f2b455296ba312f40::m::bb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun bs<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        xq<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun bu<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        zx<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun close_b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = xz<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        xw<T0>(v0, arg4, arg5, arg6, arg7);
    }

    public fun close_q<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = xx<T0, T1>(arg0, arg1, arg2, arg3, arg7);
        xw<T1>(v0, arg4, arg5, arg6, arg7);
    }

    public fun open_b<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg1: &0x2::clock::Clock, arg2: u128, arg3: bool, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        zq<T2, T3>(arg0, arg1, arg2, arg3);
        z<T0, T1>(arg4, arg5, arg6)
    }

    public fun open_q<T0, T1, T2, T3>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg1: &0x2::clock::Clock, arg2: u128, arg3: bool, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        zq<T2, T3>(arg0, arg1, arg2, arg3);
        zz<T0, T1>(arg4, arg5, arg6)
    }

    public fun qab<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T2>, arg4: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: u128, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        zq<T1, T2>(arg1, arg5, arg6, true);
        let (v0, v1) = zz<T0, T1>(arg0, arg7, arg14);
        let v2 = 0x9209954156fd8049606b5f0f7157595e3ffeb2338d6b555f2b455296ba312f40::m::ba<T1, T2>(arg1, arg2, arg8, arg9, arg5, v0, arg14);
        let v3 = xq<T2, T1>(arg3, arg4, arg5, v2, arg10, arg14);
        let v4 = xx<T0, T1>(arg0, v3, arg7, v1, arg14);
        xw<T1>(v4, arg11, arg12, arg13, arg14);
    }

    public fun qbb<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T2>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: &0x2::clock::Clock, arg6: u128, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: &mut 0x2::tx_context::TxContext) {
        zq<T1, T2>(arg3, arg5, arg6, false);
        let (v0, v1) = zz<T0, T1>(arg0, arg7, arg14);
        let v2 = zx<T2, T1>(arg1, arg2, arg5, v0, arg9, arg14);
        let v3 = 0x9209954156fd8049606b5f0f7157595e3ffeb2338d6b555f2b455296ba312f40::m::bb<T1, T2>(arg3, arg4, arg8, arg10, arg5, v2, arg14);
        let v4 = xx<T0, T1>(arg0, v3, arg7, v1, arg14);
        xw<T1>(v4, arg11, arg12, arg13, arg14);
    }

    fun xq<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg2, arg3, zw(arg4), arg5);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun xw<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 100);
        if (arg2 > 0) {
            0x2::balance::send_funds<T0>(0x2::balance::split<T0>(&mut arg0, arg2), 0x2::tx_context::sender(arg4));
        };
        0x2::balance::send_funds<T0>(arg0, arg3);
    }

    fun xx<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_quote<T0, T1>(arg0, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1, arg2), arg4), arg3);
        arg1
    }

    fun xz<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1, arg2), arg4), arg3);
        arg1
    }

    fun z<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2);
        (0x2::coin::into_balance<T0>(v0), v1)
    }

    fun zq<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u128, arg3: bool) {
        assert!(arg3 && (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1) as u128) >= arg2 || (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::mid_price<T0, T1>(arg0, arg1) as u128) <= arg2, 101);
    }

    fun zw(arg0: u64) : 0x1::option::Option<u64> {
        if (arg0 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0)
        }
    }

    fun zx<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg2, arg3, zw(arg4), arg5);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    fun zz<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_quote<T0, T1>(arg0, arg1, arg2);
        (0x2::coin::into_balance<T1>(v0), v1)
    }

    // decompiled from Move bytecode v7
}

