module 0x192c486f6bbaa9edd2525702bae5c6513f5efd1157aaa796994aadaeafaa3eac::bolt {
    public fun buy<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg1, arg2, arg3, arg4, 0x1::option::none<u64>(), arg5);
        let v2 = v0;
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), false, 0x2::balance::value<T0>(&v2));
        (v2, v1)
    }

    public fun quote<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: bool) {
        let v0 = vector[];
        let v1 = 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::quote_inputs(arg0);
        0x1::vector::reverse<u64>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            0x1::vector::push_back<u64>(&mut v0, simulate<T0, T1>(arg1, arg2, arg3, 0x1::vector::pop_back<u64>(&mut v1), arg4));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_quote(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), arg4, v0, vector[], vector[]);
    }

    public fun sell<T0, T1>(arg0: &mut 0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::Session, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg1, arg2, arg3, arg4, 0x1::option::none<u64>(), arg5);
        let v2 = v1;
        0xad5c08c267ab84c0651a82385d77ee8fa5c0e2fcad24bc9b2d97dacbca40149a::session::record_leg(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), true, 0x2::balance::value<T1>(&v2));
        (v2, v0)
    }

    fun simulate<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = if (arg4) {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg2, arg3)
        } else {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg0, arg1, arg2, arg3)
        };
        let v1 = v0;
        let (v2, v3, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v1);
        if (arg4) {
            v3
        } else {
            v2
        }
    }

    // decompiled from Move bytecode v7
}

