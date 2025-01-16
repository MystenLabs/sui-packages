module 0xc337a669f78c338a7baf4edabdf768e67506dc0e8a6d6a4346f33bea8abd1949::sqrtprice {
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

    public fun get_sqrtprice_1<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            sp : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        v0
    }

    public fun get_sqrtprice_2<T0, T1, T2, T3, T4, T5>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T4, T5>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            sp : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        let v2 = SqrtPrice{
            id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T4, T5>>(arg1),
            sp : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T3, T4, T5>(arg1),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v2);
        v0
    }

    public fun get_sqrtprice_4<T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T4, T5>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T6, T7, T8>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T9, T10, T11>) : vector<SqrtPrice> {
        let v0 = 0x1::vector::empty<SqrtPrice>();
        let v1 = SqrtPrice{
            id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg0),
            sp : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v1);
        let v2 = SqrtPrice{
            id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T3, T4, T5>>(arg1),
            sp : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T3, T4, T5>(arg1),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v2);
        let v3 = SqrtPrice{
            id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T6, T7, T8>>(arg2),
            sp : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T6, T7, T8>(arg2),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v3);
        let v4 = SqrtPrice{
            id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T9, T10, T11>>(arg3),
            sp : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T9, T10, T11>(arg3),
        };
        0x1::vector::push_back<SqrtPrice>(&mut v0, v4);
        v0
    }

    // decompiled from Move bytecode v6
}

