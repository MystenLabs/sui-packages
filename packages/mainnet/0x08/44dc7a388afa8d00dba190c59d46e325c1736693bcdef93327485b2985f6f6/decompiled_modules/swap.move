module 0x844dc7a388afa8d00dba190c59d46e325c1736693bcdef93327485b2985f6f6::swap {
    struct SwapExecuted has copy, drop {
        sui_in: u64,
        quote_out: u64,
        sqrt_price: u128,
    }

    public fun swap_half_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2) / 2;
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, v0, 4295048016, arg3);
        let v5 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0), v4);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        let v6 = SwapExecuted{
            sui_in     : v0,
            quote_out  : 0x2::balance::value<T0>(&v5),
            sqrt_price : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, 0x2::sui::SUI>(arg1),
        };
        0x2::event::emit<SwapExecuted>(v6);
        (0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4), 0x2::coin::from_balance<T0>(v5, arg4))
    }

    // decompiled from Move bytecode v6
}

