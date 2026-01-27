module 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::lens {
    public fun get_bluefin_batch<T0, T1>(arg0: vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::Pool<T0, T1>>) : (vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>, vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::Pool<T0, T1>>) {
        let v0 = 0x1::vector::empty<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::Pool<T0, T1>>(&arg0)) {
            0x1::vector::push_back<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>(&mut v0, get_bluefin_raw<T0, T1>(0x1::vector::borrow<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::Pool<T0, T1>>(&arg0, v1)));
            v1 = v1 + 1;
        };
        (v0, arg0)
    }

    public fun get_bluefin_raw<T0, T1>(arg0: &0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::Pool<T0, T1>) : 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState {
        0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::new(0x2::object::id<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::Pool<T0, T1>>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::current_sqrt_price<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::current_tick_index_as_u32<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::liquidity<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::bluefin::get_fee_rate<T0, T1>(arg0), false)
    }

    public fun get_cetus_batch<T0, T1>(arg0: vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::Pool<T0, T1>>) : (vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>, vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::Pool<T0, T1>>) {
        let v0 = 0x1::vector::empty<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::Pool<T0, T1>>(&arg0)) {
            0x1::vector::push_back<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>(&mut v0, get_cetus_raw<T0, T1>(0x1::vector::borrow<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::Pool<T0, T1>>(&arg0, v1)));
            v1 = v1 + 1;
        };
        (v0, arg0)
    }

    public fun get_cetus_raw<T0, T1>(arg0: &0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::Pool<T0, T1>) : 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState {
        0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::new(0x2::object::id<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::Pool<T0, T1>>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::current_sqrt_price<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::current_tick_index_as_u32<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::liquidity<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::fee_rate<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::cetus::is_pause<T0, T1>(arg0))
    }

    public fun get_magma_batch<T0, T1>(arg0: vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::Pool<T0, T1>>) : (vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>, vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::Pool<T0, T1>>) {
        let v0 = 0x1::vector::empty<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::Pool<T0, T1>>(&arg0)) {
            0x1::vector::push_back<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>(&mut v0, get_magma_raw<T0, T1>(0x1::vector::borrow<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::Pool<T0, T1>>(&arg0, v1)));
            v1 = v1 + 1;
        };
        (v0, arg0)
    }

    public fun get_magma_raw<T0, T1>(arg0: &0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::Pool<T0, T1>) : 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState {
        0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::new(0x2::object::id<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::Pool<T0, T1>>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::current_sqrt_price<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::current_tick_index_as_u32<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::liquidity<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::fee_rate<T0, T1>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::magma::is_pause<T0, T1>(arg0))
    }

    public fun get_turbos_batch<T0, T1, T2>(arg0: vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::Pool<T0, T1, T2>>) : (vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>, vector<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::Pool<T0, T1, T2>>) {
        let v0 = 0x1::vector::empty<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::Pool<T0, T1, T2>>(&arg0)) {
            0x1::vector::push_back<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState>(&mut v0, get_turbos_raw<T0, T1, T2>(0x1::vector::borrow<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::Pool<T0, T1, T2>>(&arg0, v1)));
            v1 = v1 + 1;
        };
        (v0, arg0)
    }

    public fun get_turbos_raw<T0, T1, T2>(arg0: &0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::Pool<T0, T1, T2>) : 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::RawPoolState {
        0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::dto::new(0x2::object::id<0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::Pool<T0, T1, T2>>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::get_pool_sqrt_price<T0, T1, T2>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::get_pool_current_index_as_u32<T0, T1, T2>(arg0), 0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::get_pool_liquidity<T0, T1, T2>(arg0), (0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::get_pool_fee<T0, T1, T2>(arg0) as u64), !0x511ea07e54fc9bfeb6c53ffe991f3c060c00ae129ad6703ffddea7987bd9a840::turbos::get_pool_unlocked<T0, T1, T2>(arg0))
    }

    // decompiled from Move bytecode v6
}

