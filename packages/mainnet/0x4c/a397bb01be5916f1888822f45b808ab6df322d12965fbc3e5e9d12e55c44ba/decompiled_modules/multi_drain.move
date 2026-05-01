module 0x4ca397bb01be5916f1888822f45b808ab6df322d12965fbc3e5e9d12e55c44ba::multi_drain {
    public entry fun drain<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, 300000, 300060, arg5);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v0, 10384593717069655257060992658440192, arg4);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v1);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        let v5 = 0x2::coin::into_balance<T1>(arg3);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut v4, v2), 0x2::balance::split<T1>(&mut v5, v3), v1);
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut v0, 10384593717069655257060992658440192, arg4);
        0x2::balance::join<T0>(&mut v4, v6);
        0x2::balance::join<T1>(&mut v5, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg5), @0xca72913a26448b7d12a8561025a1c494034711eaf85e1d2d7f292253ad6bf0bb);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg5), @0xca72913a26448b7d12a8561025a1c494034711eaf85e1d2d7f292253ad6bf0bb);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, @0xca72913a26448b7d12a8561025a1c494034711eaf85e1d2d7f292253ad6bf0bb);
    }

    // decompiled from Move bytecode v7
}

