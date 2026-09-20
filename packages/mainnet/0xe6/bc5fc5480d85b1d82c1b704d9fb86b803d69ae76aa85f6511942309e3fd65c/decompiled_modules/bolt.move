module 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::bolt {
    public fun check<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: bool, arg3: bool, arg4: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg5: &0x2::clock::Clock) {
        if (!0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::checking(arg0)) {
            return
        };
        let v0 = 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::check_amount(arg0);
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::check_step(arg0, v0, quote<T0, T1>(arg1, arg4, arg2, v0, arg5), arg3);
    }

    public fun fold_live<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: bool, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: &0x2::clock::Clock) {
        let v0 = 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::reference_input(arg0);
        let v1 = quote<T0, T1>(arg1, arg3, arg2, v0, arg4);
        if (v0 == 0 || v1 == 0) {
            0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_closed(arg0);
            return
        };
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
    }

    public fun quote<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg4, arg3)
        } else {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg0, arg1, arg4, arg3)
        };
        let v1 = v0;
        let (v2, v3, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v1);
        if (arg2) {
            v3
        } else {
            v2
        }
    }

    // decompiled from Move bytecode v7
}

