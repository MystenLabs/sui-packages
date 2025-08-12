module 0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::mclmm {
    struct AS has copy, drop {
        ai: u64,
        ao: u64,
    }

    public fun exs<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::ct::cmnsp() + 1
        } else {
            0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::ct::cmxsp() - 1
        };
        let (v1, v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg4, true, 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::giv(arg1), v0, arg2, arg3, arg6);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        assert!(v7 >= arg5, 0xd3b45a7e651d5edf0e442995d57729bc534259052cdf3952ecb0ec46f8899b::ct::e_amount_out_too_low());
        let (v8, v9) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v4);
        let v10 = if (arg4) {
            v8
        } else {
            v9
        };
        let (v11, v12) = if (arg4) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg1, v8, arg6), 0x2::coin::zero<T1>(arg6))
        } else {
            (0x2::coin::zero<T0>(arg6), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg1, v9, arg6))
        };
        let v13 = v12;
        let v14 = v11;
        let (v15, v16) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v14, v8, arg6)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v13, v9, arg6)))
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v4, v15, v16, arg3, arg6);
        0x2::coin::join<T0>(&mut v14, 0x2::coin::from_balance<T0>(v6, arg6));
        0x2::coin::join<T1>(&mut v13, 0x2::coin::from_balance<T1>(v5, arg6));
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg1, v14, arg6);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg1, v13, arg6);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::siv(arg1, v7, arg6);
        let v17 = AS{
            ai : v10,
            ao : v7,
        };
        0x2::event::emit<AS>(v17);
    }

    // decompiled from Move bytecode v6
}

