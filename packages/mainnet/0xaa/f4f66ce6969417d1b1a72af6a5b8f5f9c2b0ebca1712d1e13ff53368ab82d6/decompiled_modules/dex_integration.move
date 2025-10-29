module 0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::dex_integration {
    struct SqrtPrice has copy, drop {
        id: 0x2::object::ID,
        sp: u128,
    }

    public fun bluefin_get_sqrtprice<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>) : SqrtPrice {
        SqrtPrice{
            id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg0),
            sp : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0),
        }
    }

    public fun cetus_get_sqrtprice<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : SqrtPrice {
        SqrtPrice{
            id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0),
            sp : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0),
        }
    }

    public fun get_btc_usdt_sqrtprice<T0, T1, T2>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>) : u128 {
        let v0 = bluefin_get_sqrtprice<T0, T1>(arg0);
        let v1 = cetus_get_sqrtprice<T2, T1>(arg1);
        0xaaf4f66ce6969417d1b1a72af6a5b8f5f9c2b0ebca1712d1e13ff53368ab82d6::arithmetic::div_128(v0.sp, v1.sp)
    }

    // decompiled from Move bytecode v6
}

