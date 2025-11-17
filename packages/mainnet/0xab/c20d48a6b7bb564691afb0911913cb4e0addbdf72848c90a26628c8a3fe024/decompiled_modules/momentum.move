module 0xabc20d48a6b7bb564691afb0911913cb4e0addbdf72848c90a26628c8a3fe024::momentum {
    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun momentum_swap_a2b_with_return<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg2, arg3, arg5, arg6, arg7);
        let v3 = v2;
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x2::balance::destroy_zero<T0>(v0);
        let v6 = 0x2::coin::from_balance<T1>(v1, arg7);
        let v7 = 0x2::coin::value<T1>(&v6);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg7)), 0x2::balance::zero<T1>(), arg6, arg7);
        if (v7 < arg4) {
            abort 1
        };
        destroy_or_transfer<T0>(arg1, arg7);
        let v8 = HopRecord{out_amount: v7};
        0x2::event::emit<HopRecord>(v8);
        (v6, v7)
    }

    public fun momentum_swap_b2a_with_return<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u128, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg2, arg3, arg5, arg6, arg7);
        let v3 = v2;
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        0x2::balance::destroy_zero<T1>(v1);
        let v6 = 0x2::coin::from_balance<T0>(v0, arg7);
        let v7 = 0x2::coin::value<T0>(&v6);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v5, arg7)), arg6, arg7);
        if (v7 < arg4) {
            abort 1
        };
        destroy_or_transfer<T1>(arg1, arg7);
        let v8 = HopRecord{out_amount: v7};
        0x2::event::emit<HopRecord>(v8);
        (v6, v7)
    }

    // decompiled from Move bytecode v6
}

