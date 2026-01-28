module 0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::lens {
    public fun get_cetus_batch<T0, T1>(arg0: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>) : (vector<0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::RawPoolState>, vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>) {
        let v0 = 0x1::vector::empty<0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::RawPoolState>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&arg0)) {
            0x1::vector::push_back<0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::RawPoolState>(&mut v0, get_cetus_raw<T0, T1>(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(&arg0, v1)));
            v1 = v1 + 1;
        };
        (v0, arg0)
    }

    public fun get_cetus_raw<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : 0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::RawPoolState {
        0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::new(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0)), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, T1>(arg0))
    }

    public fun get_turbos_batch<T0, T1, T2>(arg0: vector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>) : (vector<0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::RawPoolState>, vector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>) {
        let v0 = 0x1::vector::empty<0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::RawPoolState>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&arg0)) {
            0x1::vector::push_back<0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::RawPoolState>(&mut v0, get_turbos_raw<T0, T1, T2>(0x1::vector::borrow<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(&arg0, v1)));
            v1 = v1 + 1;
        };
        (v0, arg0)
    }

    public fun get_turbos_raw<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : 0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::RawPoolState {
        0x463ad54e800d85b4496c19f8cc02a896c9077694d8f12566c0ea0fc68b358c96::dto::new(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0)), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0) as u64), !0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<T0, T1, T2>(arg0))
    }

    // decompiled from Move bytecode v6
}

