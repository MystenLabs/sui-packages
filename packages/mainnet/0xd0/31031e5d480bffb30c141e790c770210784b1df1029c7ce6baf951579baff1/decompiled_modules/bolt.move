module 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::bolt {
    fun addr<T0>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>) : address {
        0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg0)
    }

    public fun peek_buy<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: u64) : u64 {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg0, arg1, arg2, arg3);
        sim_out(&v0)
    }

    public fun peek_sell<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: u64) : u64 {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg2, arg3);
        sim_out(&v0)
    }

    public fun quote_buy<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64) {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg1, arg2, arg3, arg4);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::record_quote(arg0, sim_out(&v0));
    }

    public fun quote_sell<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64) {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg1, arg2, arg3, arg4);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::record_quote(arg0, sim_out(&v0));
    }

    public fun r_buy<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T1>(arg0, arg4);
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg4, 0x2::balance::zero<T0>(), addr<T0>(arg1));
            return
        };
        let (v1, v2) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg1, arg2, arg3, v0, 0x1::option::none<u64>(), arg5);
        let v3 = v2;
        assert!(0x2::balance::value<T1>(&v3) == 0, 100);
        0x2::balance::destroy_zero<T1>(v3);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg4, v1, addr<T0>(arg1));
    }

    public fun r_sell<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T0>(arg0, arg4);
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg4, 0x2::balance::zero<T1>(), addr<T0>(arg1));
            return
        };
        let (v1, v2) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg1, arg2, arg3, v0, 0x1::option::none<u64>(), arg5);
        let v3 = v1;
        assert!(0x2::balance::value<T0>(&v3) == 0, 100);
        0x2::balance::destroy_zero<T0>(v3);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg4, v2, addr<T0>(arg1));
    }

    fun sim_out(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::SwapSimulationResult) : u64 {
        let (v0, _, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(arg0);
        v0
    }

    // decompiled from Move bytecode v7
}

