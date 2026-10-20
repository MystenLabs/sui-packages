module 0x95856d3a325965f1fc863940aaf113e901f8c1774e15228fe5009952b1006c86::precheck {
    struct Bound {
        input: u64,
        amount: u64,
        dust: u64,
        floor: u64,
        unbounded: bool,
    }

    public fun begin(arg0: u64, arg1: u64) : Bound {
        Bound{
            input     : arg0,
            amount    : arg0,
            dust      : 0,
            floor     : arg1,
            unbounded : false,
        }
    }

    public fun bluefin<T0, T1>(arg0: &mut Bound, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg1), arg2);
    }

    public fun book(arg0: &mut Bound, arg1: u64, arg2: bool) {
        if (arg0.unbounded) {
            return
        };
        if (arg1 == 0) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        let (v0, v1) = if (arg2) {
            let v1 = ceil((arg0.dust as u256) * (arg1 as u256), 1000000000);
            let v0 = ceil((arg0.amount as u256) * (arg1 as u256), 1000000000);
            (v0, v1)
        } else {
            let v1 = ceil(((arg0.dust as u256) + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fills() as u256)) * 1000000000, (arg1 as u256));
            let v0 = ceil((arg0.amount as u256) * 1000000000, (arg1 as u256));
            (v0, v1)
        };
        set(arg0, v0, v1);
    }

    fun ceil(arg0: u256, arg1: u256) : u256 {
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    public fun cetus<T0, T1>(arg0: &mut Bound, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun deepbook<T0, T1>(arg0: &mut Bound, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let (v0, _, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg1, 1, arg3);
        let v4 = if (arg2) {
            v0
        } else {
            v2
        };
        let v5 = v4;
        let v6 = if (0x1::vector::is_empty<u64>(&v5)) {
            0
        } else {
            *0x1::vector::borrow<u64>(&v5, 0)
        };
        book(arg0, v6, arg2);
    }

    public fun ferra<T0, T1>(arg0: &mut Bound, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg1), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun finish(arg0: Bound) {
        let Bound {
            input     : v0,
            amount    : v1,
            dust      : v2,
            floor     : v3,
            unbounded : v4,
        } = arg0;
        let v5 = if (v1 > v0) {
            ((v1 - v0) as u128)
        } else {
            0
        };
        assert!(v4 || v5 + (v2 as u128) >= (v3 as u128), 0);
    }

    public fun fullsail<T0, T1>(arg0: &mut Bound, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg1), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun magma<T0, T1>(arg0: &mut Bound, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun momentum<T0, T1>(arg0: &mut Bound, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg1), arg2);
    }

    fun set(arg0: &mut Bound, arg1: u256, arg2: u256) {
        if (arg1 > 18446744073709551615 || arg2 > 18446744073709551615) {
            arg0.unbounded = true;
        };
        let v0 = if (arg1 > 18446744073709551615) {
            18446744073709551615
        } else {
            arg1
        };
        arg0.amount = (v0 as u64);
        let v1 = if (arg2 > 18446744073709551615) {
            18446744073709551615
        } else {
            arg2
        };
        arg0.dust = (v1 as u64);
    }

    public fun suidex_v3<T0, T1>(arg0: &mut Bound, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg1), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::swap_fee_rate<T0, T1>(arg1), arg2);
    }

    public fun tick(arg0: &mut Bound, arg1: u128, arg2: u64, arg3: bool) {
        if (arg0.unbounded) {
            return
        };
        if (arg2 >= (1000000 as u64)) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        let v0 = (arg1 as u256);
        if (v0 == 0) {
            arg0.unbounded = true;
            return
        };
        let v1 = tick_bound(arg0.amount, v0, arg2, arg3);
        let v2 = if (arg0.dust == 0) {
            0
        } else {
            tick_bound(arg0.dust, v0, arg2, arg3)
        };
        set(arg0, v1, v2);
    }

    fun tick_bound(arg0: u64, arg1: u256, arg2: u64, arg3: bool) : u256 {
        if (arg3) {
            let v1 = ceil((arg0 as u256) * (1000000 - (arg2 as u256)), 1000000) * arg1;
            if (v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
                115792089237316195423570985008687907853269984665640564039457584007913129639935
            } else {
                ceil(v1 * arg1, 340282366920938463463374607431768211456)
            }
        } else {
            ceil(ceil((arg0 as u256) * (1000000 - (arg2 as u256)), 1000000) * 340282366920938463463374607431768211456, arg1 * arg1)
        }
    }

    public fun turbos<T0, T1, T2>(arg0: &mut Bound, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool) {
        tick(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg1) as u64), arg2);
    }

    // decompiled from Move bytecode v7
}

