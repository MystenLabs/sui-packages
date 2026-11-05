module 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::xl {
    public fun qs<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg3: bool, arg4: &0x2::clock::Clock) {
        if (!0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::live(arg0)) {
            return
        };
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::fd(arg0, 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vl::qo<T0, T1>(arg2, arg1, arg3, 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::cy(arg0), arg4));
    }

    public fun sa<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vl::sa<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T1>(arg0, &v0);
        v0
    }

    public fun sb<T0, T1>(arg0: &mut 0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::M, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x4bf24f9da9df94354fba4d87224795b000593d211413c124a5e1773e49a28f7f::vl::sb<T0, T1>(arg1, arg2, arg3, arg4, arg5);
        0x22edefb7d3055509d604f5a5e6f67c79355f6c479076fd687fae1c284e14ea1c::m::hp<T0>(arg0, &v0);
        v0
    }

    // decompiled from Move bytecode v7
}

