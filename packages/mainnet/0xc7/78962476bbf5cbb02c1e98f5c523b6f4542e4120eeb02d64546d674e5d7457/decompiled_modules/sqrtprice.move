module 0xc778962476bbf5cbb02c1e98f5c523b6f4542e4120eeb02d64546d674e5d7457::sqrtprice {
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

    public fun get_sqrtprice_1<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        v0
    }

    public fun get_sqrtprice_2<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        let v2 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v2);
        v0
    }

    public fun get_sqrtprice_4<T0, T1, T2, T3, T4, T5, T6, T7>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        let v2 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v2);
        let v3 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>>(arg2),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T4, T5>(arg2),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v3);
        let v4 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>>(arg3),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T6, T7>(arg3),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v4);
        v0
    }

    public fun get_sqrtprice_8<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T8, T9>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T10, T11>, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T12, T13>, arg7: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T14, T15>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        let v2 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg1),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T2, T3>(arg1),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v2);
        let v3 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T4, T5>>(arg2),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T4, T5>(arg2),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v3);
        let v4 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T6, T7>>(arg3),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T6, T7>(arg3),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v4);
        let v5 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T8, T9>>(arg4),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T8, T9>(arg4),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v5);
        let v6 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T10, T11>>(arg5),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T10, T11>(arg5),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v6);
        let v7 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T12, T13>>(arg6),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T12, T13>(arg6),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v7);
        let v8 = SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T14, T15>>(arg7),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T14, T15>(arg7),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v8);
        v0
    }

    // decompiled from Move bytecode v6
}

