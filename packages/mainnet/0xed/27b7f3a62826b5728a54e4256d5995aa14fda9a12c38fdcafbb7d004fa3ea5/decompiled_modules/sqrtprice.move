module 0xed27b7f3a62826b5728a54e4256d5995aa14fda9a12c38fdcafbb7d004fa3ea5::sqrtprice {
    struct SqrtPrice has copy, drop {
        id: 0x2::object::ID,
        sp: u128,
    }

    struct SqrtPrices has copy, drop {
        data: vector<SqrtPrice>,
    }

    public fun emit_sqrts(arg0: vector<SqrtPrice>) {
        let v0 = SqrtPrices{data: arg0};
        0x2::event::emit<SqrtPrices>(v0);
    }

    public fun get_sqrtprice_1<T0, T1>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg0),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        v0
    }

    public fun get_sqrtprice_2<T0, T1, T2, T3>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg0),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        let v2 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>>(arg1),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T2, T3>(arg1),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v2);
        v0
    }

    public fun get_sqrtprice_4<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T4, T5>, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T6, T7>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg0),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        let v2 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>>(arg1),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T2, T3>(arg1),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v2);
        let v3 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T4, T5>>(arg2),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T4, T5>(arg2),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v3);
        let v4 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T6, T7>>(arg3),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T6, T7>(arg3),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v4);
        v0
    }

    public fun get_sqrtprice_8<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(arg0: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T4, T5>, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T6, T7>, arg4: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T8, T9>, arg5: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T10, T11>, arg6: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T12, T13>, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T14, T15>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg0),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        let v2 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T2, T3>>(arg1),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T2, T3>(arg1),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v2);
        let v3 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T4, T5>>(arg2),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T4, T5>(arg2),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v3);
        let v4 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T6, T7>>(arg3),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T6, T7>(arg3),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v4);
        let v5 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T8, T9>>(arg4),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T8, T9>(arg4),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v5);
        let v6 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T10, T11>>(arg5),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T10, T11>(arg5),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v6);
        let v7 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T12, T13>>(arg6),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T12, T13>(arg6),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v7);
        let v8 = SqrtPrice{
            id : 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T14, T15>>(arg7),
            sp : 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T14, T15>(arg7),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v8);
        v0
    }

    // decompiled from Move bytecode v6
}

