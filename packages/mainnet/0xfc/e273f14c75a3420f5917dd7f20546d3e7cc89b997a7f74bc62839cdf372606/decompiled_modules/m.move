module 0xfce273f14c75a3420f5917dd7f20546d3e7cc89b997a7f74bc62839cdf372606::m {
    struct Hop has copy, drop {
        a: u256,
        b: u256,
        c: u256,
    }

    struct Sized has copy, drop {
        x: u64,
    }

    fun back(arg0: &Hop, arg1: u256) : u256 {
        if (arg1 == 0 || arg1 >= arg0.a) {
            return 0
        };
        let v0 = arg0.b * arg1 / (arg0.a - arg1);
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public fun bluefin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u128) : Hop {
        clmm(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), arg1, arg2)
    }

    public fun bolt<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64) : Hop {
        if (arg3) {
            let (v1, v2) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg1, arg2);
            let v3 = probe(v1, v2, (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0) as u256) * (v1 as u256) / 1000000000000000000, arg4);
            let v4 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg2, v3);
            let (_, v6, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v4);
            measured(v3, v6)
        } else {
            let (v14, v15) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg1, arg2);
            let (v16, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_base_liquidity_inner<T0>(arg0);
            let v18 = probe(v14, v15, (v16 as u256) * (v14 as u256) / 1000000000000000000, arg4);
            let v19 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg0, arg1, arg2, v18);
            let (v20, _, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v19);
            measured(v18, v20)
        }
    }

    fun ceil(arg0: u256, arg1: u256) : u256 {
        (arg0 + arg1 - 1) / arg1
    }

    public fun cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u128) : Hop {
        clmm(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), arg1, arg2)
    }

    fun clmm(arg0: u128, arg1: u128, arg2: u64, arg3: bool, arg4: u128) : Hop {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        let v3 = (arg4 as u256);
        let v4 = if (v0 > 0) {
            if (v1 > 0) {
                v2 < 1000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 102);
        let v5 = 1000000 - v2;
        let v6 = v1 * 18446744073709551616;
        let v7 = v1 * v0;
        let v8 = v6 / v0;
        let v9 = ceil(v7, 18446744073709551616);
        let v10 = v9;
        let v11 = 0;
        if (arg3) {
            v8 = v7 / 18446744073709551616;
            let v12 = ceil(v6, v0);
            v10 = v12;
            if (v3 > 0) {
                let v13 = if (v3 < v0) {
                    gap(v6 / v3, v12)
                } else {
                    1
                };
                v11 = v13;
            };
        } else if (v3 > 0) {
            let v14 = if (v3 > v0) {
                gap(v1 * v3 / 18446744073709551616, v9)
            } else {
                1
            };
            v11 = v14;
        };
        let v15 = ceil(v10 * 1000000, v5);
        let v16 = if (v8 > 0) {
            if (v8 < 170141183460469231731687303715884105728) {
                v15 < 170141183460469231731687303715884105728
            } else {
                false
            }
        } else {
            false
        };
        assert!(v16, 102);
        let v17 = v11 * 1000000 / v5;
        let v18 = if (v17 > 18446744073709551615) {
            18446744073709551615
        } else {
            v17
        };
        Hop{
            a : v8,
            b : v15,
            c : v18,
        }
    }

    fun gap(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1 + 1) {
            arg0 - arg1
        } else {
            1
        }
    }

    fun isqrt(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = 1;
        let v1 = 128;
        while (v1 > 0) {
            if (arg0 >> v1 > 0) {
                arg0 = arg0 >> v1;
                v0 = v0 + (v1 as u16);
            };
            v1 = v1 >> 1;
        };
        let v2 = 1 << (((v0 + 1) / 2) as u8);
        loop {
            let v3 = v2 + arg0 / v2 >> 1;
            if (v3 >= v2) {
                break
            };
            v2 = v3;
        };
        v2
    }

    fun join(arg0: Hop, arg1: Hop) : Hop {
        let v0 = arg0.a + arg1.b;
        Hop{
            a : arg0.a * arg1.a / v0,
            b : ceil(arg0.b * arg1.b, v0),
            c : least(arg0.c, back(&arg0, arg1.c)),
        }
    }

    fun least(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 > 0 && arg1 < arg0) {
            arg1
        } else {
            arg0
        }
    }

    public fun magma<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u128) : Hop {
        clmm(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, arg2)
    }

    fun measured(arg0: u64, arg1: u64) : Hop {
        let v0 = 79228162514264337593543950336 * (arg1 as u256) / (arg0 as u256);
        assert!(v0 > 0 && v0 < 170141183460469231731687303715884105728, 102);
        Hop{
            a : v0,
            b : 79228162514264337593543950336,
            c : (arg0 as u256),
        }
    }

    public fun momentum<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u128) : Hop {
        clmm(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg0), arg1, arg2)
    }

    fun probe(arg0: u128, arg1: bool, arg2: u256, arg3: u64) : u64 {
        let v0 = if (!arg1) {
            if (arg0 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 102);
        let v1 = if (arg2 < 4) {
            1
        } else {
            arg2 / 4
        };
        let v2 = if (arg3 == 0) {
            v1
        } else if ((arg3 as u256) < arg2) {
            (arg3 as u256)
        } else {
            arg2
        };
        let v3 = if (v2 > 18446744073709551615) {
            18446744073709551615
        } else {
            v2
        };
        (v3 as u64)
    }

    fun size(arg0: Hop, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0.a > arg0.b, 102);
        let v0 = isqrt(arg0.a * arg0.b) - arg0.b;
        let v1 = v0;
        if (arg0.c > 0 && v0 > arg0.c) {
            v1 = arg0.c;
        };
        if (v1 > (arg2 as u256)) {
            v1 = (arg2 as u256);
        };
        assert!(v1 > 0 && v1 >= (arg1 as u256), 103);
        assert!(arg0.a * v1 / (arg0.b + v1) >= v1 + (arg3 as u256), 103);
        let v2 = (v1 as u64);
        let v3 = Sized{x: v2};
        0x2::event::emit<Sized>(v3);
        v2
    }

    public fun size2(arg0: Hop, arg1: Hop, arg2: u64, arg3: u64, arg4: u64) : u64 {
        size(join(arg0, arg1), arg2, arg3, arg4)
    }

    public fun size3(arg0: Hop, arg1: Hop, arg2: Hop, arg3: u64, arg4: u64, arg5: u64) : u64 {
        size(join(join(arg0, arg1), arg2), arg3, arg4, arg5)
    }

    public fun size4(arg0: Hop, arg1: Hop, arg2: Hop, arg3: Hop, arg4: u64, arg5: u64, arg6: u64) : u64 {
        size(join(join(join(arg0, arg1), arg2), arg3), arg4, arg5, arg6)
    }

    public fun t100<T0, T1>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee100bps::FEE100BPS>, arg1: bool, arg2: u128) : Hop {
        turbos<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee100bps::FEE100BPS>(arg0, arg1, arg2)
    }

    public fun t10000<T0, T1>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee10000bps::FEE10000BPS>, arg1: bool, arg2: u128) : Hop {
        turbos<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee10000bps::FEE10000BPS>(arg0, arg1, arg2)
    }

    public fun t3000<T0, T1>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee3000bps::FEE3000BPS>, arg1: bool, arg2: u128) : Hop {
        turbos<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee3000bps::FEE3000BPS>(arg0, arg1, arg2)
    }

    public fun t500<T0, T1>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>, arg1: bool, arg2: u128) : Hop {
        turbos<T0, T1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::fee500bps::FEE500BPS>(arg0, arg1, arg2)
    }

    fun turbos<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u128) : Hop {
        clmm(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0) as u64), arg1, arg2)
    }

    public fun turbos_any<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u128) : Hop {
        turbos<T0, T1, T2>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

