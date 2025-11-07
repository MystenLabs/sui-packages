module 0x6257c58feabffe3e1fa17c6a287b999405fbcfc0f3fb389783f481c514aec0ca::magma {
    struct MagmaSwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg3);
        let v4 = v1;
        0x2::balance::join<T0>(&mut v4, 0x2::coin::into_balance<T0>(arg2));
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, v4, 0x2::balance::zero<T1>(), v3);
        let v5 = 0x2::coin::from_balance<T1>(v2, arg4);
        let v6 = MagmaSwapEvent{
            pool_id      : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig>(arg0),
            a2b          : true,
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T1>(&v5),
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<MagmaSwapEvent>(v6);
        v5
    }

    public fun swap_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg3);
        let v4 = v2;
        0x2::balance::join<T1>(&mut v4, 0x2::coin::into_balance<T1>(arg2));
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), v4, v3);
        let v5 = 0x2::coin::from_balance<T0>(v1, arg4);
        let v6 = MagmaSwapEvent{
            pool_id      : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig>(arg0),
            a2b          : false,
            amount_in    : v0,
            amount_out   : 0x2::coin::value<T0>(&v5),
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<MagmaSwapEvent>(v6);
        v5
    }

    // decompiled from Move bytecode v6
}

