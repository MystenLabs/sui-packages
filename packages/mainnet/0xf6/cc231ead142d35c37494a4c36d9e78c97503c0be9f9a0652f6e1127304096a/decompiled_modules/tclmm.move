module 0xf6cc231ead142d35c37494a4c36d9e78c97503c0be9f9a0652f6e1127304096a::tclmm {
    struct EE has copy, drop {
        e: u64,
        l: u64,
    }

    public fun elf<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg2: &0x2::clock::Clock, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: u64, arg5: u64, arg6: u64, arg7: vector<bool>, arg8: vector<bool>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe691aeb328ba898b3374ed75fdffd3306619ad71bab29aa303b0227bf2bb0708::sq::ct(arg2, arg4, true);
        if (v0 != 0) {
            let v1 = EE{
                e : v0,
                l : 232,
            };
            0x2::event::emit<EE>(v1);
            return
        };
        let v2 = 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::balance<T0>(arg1);
        let v3 = 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::balance<T1>(arg1);
        let v4 = if (v2 > arg5) {
            v2 - arg5
        } else {
            0
        };
        let v5 = v4;
        let v6 = if (v3 > arg6) {
            v3 - arg6
        } else {
            0
        };
        let v7 = v6;
        let v8 = 0;
        while (v8 < 0x1::vector::length<bool>(&arg7)) {
            let v9 = *0x1::vector::borrow<bool>(&arg8, v8);
            let v10 = if (v9) {
                0xf6cc231ead142d35c37494a4c36d9e78c97503c0be9f9a0652f6e1127304096a::ct::cmnsp() + 1
            } else {
                0xf6cc231ead142d35c37494a4c36d9e78c97503c0be9f9a0652f6e1127304096a::ct::cmxsp() - 1
            };
            let (v11, v12, v13, v14, v15) = if (*0x1::vector::borrow<bool>(&arg7, v8)) {
                sei<T0, T1, T2>(arg1, arg3, arg0, v9, *0x1::vector::borrow<u64>(&arg9, v8), *0x1::vector::borrow<u64>(&arg10, v8), v10, arg2, arg11)
            } else {
                seo<T0, T1, T2>(arg1, arg3, arg0, v9, *0x1::vector::borrow<u64>(&arg9, v8), *0x1::vector::borrow<u64>(&arg10, v8), v10, arg2, arg11)
            };
            if (v11 != 0xf6cc231ead142d35c37494a4c36d9e78c97503c0be9f9a0652f6e1127304096a::ct::e_no_error()) {
                let v16 = EE{
                    e : v11,
                    l : 306,
                };
                0x2::event::emit<EE>(v16);
                v8 = v8 + 1;
                continue
            };
            let v17 = v5 + v14;
            v5 = v17 - v12;
            let v18 = v7 + v15;
            v7 = v18 - v13;
            v8 = v8 + 1;
        };
    }

    fun sei<T0, T1, T2>(arg0: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg8), arg3, (arg4 as u128), true, arg6, arg7, arg1, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::coin::value<T0>(&v5);
        let v7 = 0x2::coin::value<T1>(&v4);
        let v8 = if (arg3) {
            v7
        } else {
            v6
        };
        assert!(v8 >= arg5, 0xf6cc231ead142d35c37494a4c36d9e78c97503c0be9f9a0652f6e1127304096a::ct::e_amount_out_too_low());
        let (_, _, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_flash_swap_receipt_info<T0, T1>(&v3);
        let (v12, v13) = if (arg3) {
            (v11, 0)
        } else {
            (0, v11)
        };
        let (v14, v15) = if (arg3) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg0, v12, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg0, v13, arg8))
        };
        let v16 = v15;
        let v17 = v14;
        let (v18, v19) = if (arg3) {
            (0x2::coin::split<T0>(&mut v17, v12, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0x2::coin::split<T1>(&mut v16, v13, arg8))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg2, v18, v19, v3, arg1);
        0x2::coin::join<T0>(&mut v17, v5);
        0x2::coin::join<T1>(&mut v16, v4);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg0, v17, arg8);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg0, v16, arg8);
        (0xf6cc231ead142d35c37494a4c36d9e78c97503c0be9f9a0652f6e1127304096a::ct::e_no_error(), v12, v13, v6, v7)
    }

    fun seo<T0, T1, T2>(arg0: &mut 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::CBM, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let (v0, v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::flash_swap<T0, T1, T2>(arg2, 0x2::tx_context::sender(arg8), arg3, (arg4 as u128), false, arg6, arg7, arg1, arg8);
        let v3 = v1;
        let v4 = v0;
        let v5 = 0;
        let (v6, v7) = if (arg3) {
            (v5, 0)
        } else {
            (0, v5)
        };
        assert!(v5 <= arg5, 0xf6cc231ead142d35c37494a4c36d9e78c97503c0be9f9a0652f6e1127304096a::ct::e_amount_in_too_high());
        let (v8, v9) = if (arg3) {
            (0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T0>(arg0, v6, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::wd<T1>(arg0, v7, arg8))
        };
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = if (arg3) {
            (0x2::coin::split<T0>(&mut v11, v5, arg8), 0x2::coin::zero<T1>(arg8))
        } else {
            (0x2::coin::zero<T0>(arg8), 0x2::coin::split<T1>(&mut v10, v5, arg8))
        };
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::repay_flash_swap<T0, T1, T2>(arg2, v12, v13, v2, arg1);
        0x2::coin::join<T0>(&mut v11, v4);
        0x2::coin::join<T1>(&mut v10, v3);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T0>(arg0, v11, arg8);
        0xa3e3162fb175b3068eee9c18a91c72aba52d1a2b69b68fcda1d34c629da6376a::bm::dp<T1>(arg0, v10, arg8);
        (0xf6cc231ead142d35c37494a4c36d9e78c97503c0be9f9a0652f6e1127304096a::ct::e_no_error(), v6, v7, 0x2::coin::value<T0>(&v4), 0x2::coin::value<T1>(&v3))
    }

    // decompiled from Move bytecode v6
}

