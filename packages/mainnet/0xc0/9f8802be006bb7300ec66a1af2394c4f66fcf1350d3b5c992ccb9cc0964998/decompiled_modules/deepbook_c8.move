module 0xc09f8802be006bb7300ec66a1af2394c4f66fcf1350d3b5c992ccb9cc0964998::deepbook_c8 {
    public fun check<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64, arg6: u64) {
        let (v0, v1, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg0, arg4, 0, arg3);
        assert!(v1 > arg5, 1);
        let v3 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg1, arg2, arg3, v1 - arg5);
        let (v4, _, _, _, _, _, _, v11, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v3);
        let (v13, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_base_liquidity_inner<T0>(arg1);
        check_return(arg4, arg6, v0, v4, v11, v13);
    }

    public(friend) fun check_return(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!((arg3 as u128) + (arg4 as u128) <= (arg5 as u128), 2);
        assert!((arg3 as u128) + (arg2 as u128) >= (arg0 as u128) + (arg1 as u128), 3);
    }

    // decompiled from Move bytecode v7
}

