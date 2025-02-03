module 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::turbos {
    struct TurbosSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        fee: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::config::Config, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, arg2);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg1, v1, v0, 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_sqrt_price(), true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3) + 18000, arg3, arg4, arg5);
        let v4 = v2;
        let v5 = TurbosSwapEvent{
            pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1),
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v4),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
            fee          : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<TurbosSwapEvent>(v5);
        0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::utils::transfer_or_destroy_coin<T0>(v3, arg5);
        let (v6, _) = 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::config::pay_fee<T1>(arg0, v4, arg5);
        v6
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::config::Config, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, arg2);
        let (v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg1, v1, v0, 0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_sqrt_price(), true, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg3) + 18000, arg3, arg4, arg5);
        let v4 = v2;
        let v5 = TurbosSwapEvent{
            pool         : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1),
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v4),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
            fee          : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<TurbosSwapEvent>(v5);
        0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::utils::transfer_or_destroy_coin<T1>(v3, arg5);
        let (v6, _) = 0xc06ebb87c2753af79a5700778a7d8feabeaa88363cb45c576ec591437d52f201::config::pay_fee<T0>(arg0, v4, arg5);
        v6
    }

    // decompiled from Move bytecode v6
}

