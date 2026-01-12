module 0xc3138b8ebde2b38b60d0f88fb03bb3381baedc58b9166dfc1633cdce42493bc7::swap {
    struct SwapExecuted has copy, drop {
        sui_in: u64,
        quote_out: u64,
        sqrt_price: u128,
    }

    public fun swap_half_sui<T0>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2) / 2;
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let (v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T0>(arg3, arg0, arg1, true, true, v0, 4295048016);
        let v5 = v3;
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut v1, v0), 0x2::balance::zero<T0>(), v4);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
        let v6 = SwapExecuted{
            sui_in     : v0,
            quote_out  : 0x2::balance::value<T0>(&v5),
            sqrt_price : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0x2::sui::SUI, T0>(arg1),
        };
        0x2::event::emit<SwapExecuted>(v6);
        (0x2::coin::from_balance<0x2::sui::SUI>(v1, arg4), 0x2::coin::from_balance<T0>(v5, arg4))
    }

    // decompiled from Move bytecode v6
}

