module 0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::magma {
    public fun a2b_clmm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg1, true, true, 0x2::coin::value<T0>(&arg0), 0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::min_sqrt_price(), arg3);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v2);
        0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg4), arg4);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun a2b_propamm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg1, 0x2::coin::value<T0>(&arg0), 0x2::coin::into_balance<T0>(arg0), arg2, arg3);
        0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg3), arg3);
        0x2::coin::from_balance<T1>(v1, arg3)
    }

    public fun b2a_clmm<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg1, false, true, 0x2::coin::value<T1>(&arg0), 0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::max_sqrt_price(), arg3);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v2);
        0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg4), arg4);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun b2a_propamm<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg1, 0x2::coin::value<T1>(&arg0), 0x2::coin::into_balance<T1>(arg0), arg2, arg3);
        0x777737ac907230f723843d2c2585d14b9fbcc1661a4893949ae0784e78084868::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg3), arg3);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    // decompiled from Move bytecode v7
}

