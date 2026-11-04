module 0x34c71592663660a2dad459f306c13dfaca239b3ca8c80cb6361b79e3671369d6::execution {
    public fun maybe_a2b<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T1>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<T1>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg3);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&v0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::min_sqrt_price(), arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(v0), 0x2::balance::zero<T1>(), v3);
        0x2::balance::destroy_zero<T0>(v1);
        0x1::option::some<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg4))
    }

    public fun maybe_b2a<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x1::option::Option<0x2::coin::Coin<T1>>, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<T1>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<T1>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T1>>(arg3);
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::coin::value<T1>(&v0), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick_math::max_sqrt_price(), arg2);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(v0), v3);
        0x2::balance::destroy_zero<T1>(v2);
        0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg4))
    }

    // decompiled from Move bytecode v7
}

