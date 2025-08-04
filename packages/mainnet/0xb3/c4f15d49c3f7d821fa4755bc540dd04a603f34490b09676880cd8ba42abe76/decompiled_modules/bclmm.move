module 0xb3c4f15d49c3f7d821fa4755bc540dd04a603f34490b09676880cd8ba42abe76::bclmm {
    struct AS has copy, drop {
        ai: u64,
        ao: u64,
    }

    public fun exs<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0xb3c4f15d49c3f7d821fa4755bc540dd04a603f34490b09676880cd8ba42abe76::ct::cmnsp() + 1
        } else {
            0xb3c4f15d49c3f7d821fa4755bc540dd04a603f34490b09676880cd8ba42abe76::ct::cmxsp() - 1
        };
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg2, arg3, arg0, arg4, true, 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::giv(arg1), v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v7 >= arg5, 0xb3c4f15d49c3f7d821fa4755bc540dd04a603f34490b09676880cd8ba42abe76::ct::e_amount_out_too_low());
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4);
        let (v9, v10) = if (arg4) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg1, v8, arg6), 0x2::coin::zero<T1>(arg6))
        } else {
            (0x2::coin::zero<T0>(arg6), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg1, v8, arg6))
        };
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v12, v8, arg6)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v11, v8, arg6)))
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg3, arg0, v13, v14, v4);
        0x2::coin::join<T0>(&mut v12, 0x2::coin::from_balance<T0>(v6, arg6));
        0x2::coin::join<T1>(&mut v11, 0x2::coin::from_balance<T1>(v5, arg6));
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg1, v12, arg6);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg1, v11, arg6);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::siv(arg1, v7, arg6);
        let v15 = AS{
            ai : v8,
            ao : v7,
        };
        0x2::event::emit<AS>(v15);
    }

    // decompiled from Move bytecode v6
}

