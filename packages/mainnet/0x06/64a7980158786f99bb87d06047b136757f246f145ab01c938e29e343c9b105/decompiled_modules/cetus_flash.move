module 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::cetus_flash {
    struct CetusFlashReceipt has drop, store {
        pool_id: address,
        amount: u64,
        fee: u64,
        a_to_b: bool,
    }

    public fun execute_cetus_arbitrage<T0, T1>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = flash_swap_cetus_example<T0, T1>(arg0, true, arg1);
        0x2::balance::destroy_zero<T1>(0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::move_balance_b_from_receipt<T0, T1, CetusFlashReceipt>(&mut v0, arg1));
        0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::destroy_swap_receipt<T0, T1, CetusFlashReceipt>(v0);
    }

    public fun flash_swap_cetus_example<T0, T1>(arg0: u64, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::SwapReceipt<T0, T1, CetusFlashReceipt> {
        let v0 = CetusFlashReceipt{
            pool_id : @0x0,
            amount  : arg0,
            fee     : arg0 * 30 / 10000,
            a_to_b  : arg1,
        };
        0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::create_swap_receipt<T0, T1, CetusFlashReceipt>(v0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg0 + arg0 * 30 / 10000, arg1)
    }

    public fun repay_cetus_flash_swap<T0, T1>(arg0: 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::SwapReceipt<T0, T1, CetusFlashReceipt>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let CetusFlashReceipt {
            pool_id : _,
            amount  : _,
            fee     : _,
            a_to_b  : _,
        } = 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::extract_flash_receipt<T0, T1, CetusFlashReceipt>(&mut arg0);
        0x2::balance::destroy_zero<T0>(arg1);
        0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::destroy_swap_receipt<T0, T1, CetusFlashReceipt>(arg0);
    }

    // decompiled from Move bytecode v6
}

