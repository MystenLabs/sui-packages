module 0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::magma {
    struct PropammQuote has copy, drop, store {
        a2b_out: u64,
        b2a_out: u64,
    }

    public fun a2b_clmm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg1, true, true, 0x2::coin::value<T0>(&arg0), 0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::min_sqrt_price(), arg3);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::coin::into_balance<T0>(arg0), 0x2::balance::zero<T1>(), v2);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg4), arg4);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun a2b_propamm<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T0, T1>(arg1, 0x2::coin::value<T0>(&arg0), 0x2::coin::into_balance<T0>(arg0), arg2, arg3);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg3), arg3);
        0x2::coin::from_balance<T1>(v1, arg3)
    }

    public fun b2a_clmm<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg1, false, true, 0x2::coin::value<T1>(&arg0), 0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::max_sqrt_price(), arg3);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg2, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v2);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg4), arg4);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    public fun b2a_propamm<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T0, T1>(arg1, 0x2::coin::value<T1>(&arg0), 0x2::coin::into_balance<T1>(arg0), arg2, arg3);
        0x61b68cc2ec000efdcfe4236805e1a9717bc7d39c10e36f238e8c717958c47e91::self::transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg3), arg3);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    public fun probe_propamm<T0, T1>(arg0: &0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>, arg1: u64, arg2: u64) : PropammQuote {
        let (v0, _) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::quote_x_2_y<T0, T1>(arg0, arg1);
        let (v2, _) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::quote_y_2_x<T0, T1>(arg0, arg2);
        PropammQuote{
            a2b_out : v0,
            b2a_out : v2,
        }
    }

    // decompiled from Move bytecode v7
}

