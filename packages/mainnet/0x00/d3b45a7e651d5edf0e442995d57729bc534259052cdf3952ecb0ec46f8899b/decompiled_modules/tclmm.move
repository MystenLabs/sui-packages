module 0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::tclmm {
    struct AS has copy, drop {
        ai: u64,
        ao: u64,
    }

    public fun exs<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::ct::cmnsp() + 1
        } else {
            0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::ct::cmxsp() - 1
        };
        let (v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg6), arg4, (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::giv(arg1) as u128), true, v0, arg2, arg3, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::coin::value<T1>(&v5)
        } else {
            0x2::coin::value<T0>(&v6)
        };
        assert!(v7 >= arg5, 0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::ct::e_amount_out_too_low());
        let (_, _, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v4);
        let (v11, v12) = if (arg4) {
            (v10, 0)
        } else {
            (0, v10)
        };
        let (v13, v14) = if (arg4) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg1, v11, arg6), 0x2::coin::zero<T1>(arg6))
        } else {
            (0x2::coin::zero<T0>(arg6), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg1, v12, arg6))
        };
        let v15 = v14;
        let v16 = v13;
        let (v17, v18) = if (arg4) {
            (0x2::coin::split<T0>(&mut v16, v11, arg6), 0x2::coin::zero<T1>(arg6))
        } else {
            (0x2::coin::zero<T0>(arg6), 0x2::coin::split<T1>(&mut v15, v12, arg6))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg0, v17, v18, v4, arg3);
        0x2::coin::join<T0>(&mut v16, v6);
        0x2::coin::join<T1>(&mut v15, v5);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg1, v16, arg6);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg1, v15, arg6);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::siv(arg1, v7, arg6);
        let v19 = AS{
            ai : v10,
            ao : v7,
        };
        0x2::event::emit<AS>(v19);
    }

    // decompiled from Move bytecode v6
}

