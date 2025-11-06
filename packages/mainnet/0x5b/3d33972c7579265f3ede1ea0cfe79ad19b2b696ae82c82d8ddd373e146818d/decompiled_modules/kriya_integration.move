module 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::kriya_integration {
    struct KriyaFlashReceipt has drop, store {
        amount: u64,
        fee: u64,
    }

    public fun flash_swap_kriya<T0, T1>(arg0: u64, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::SwapReceipt<T0, T1, KriyaFlashReceipt> {
        let v0 = KriyaFlashReceipt{
            amount : arg0,
            fee    : arg0 * 30 / 10000,
        };
        0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::create_swap_receipt<T0, T1, KriyaFlashReceipt>(v0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>(), arg0 + arg0 * 30 / 10000, arg1)
    }

    public fun get_kriya_sqrt_price<T0, T1>() : u128 {
        1000000000000000000
    }

    public fun repay_kriya_flash_swap<T0, T1>(arg0: 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::SwapReceipt<T0, T1, KriyaFlashReceipt>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::destroy_zero<T0>(arg1);
        0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para::destroy_swap_receipt<T0, T1, KriyaFlashReceipt>(arg0);
    }

    public fun swap_kriya_a_b<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::destroy_zero<T0>(arg0);
        assert!(0x2::balance::value<T0>(&arg0) * 997 / 1000 >= arg1, 100);
        0x2::balance::zero<T1>()
    }

    public fun swap_kriya_b_a<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::destroy_zero<T1>(arg0);
        assert!(0x2::balance::value<T1>(&arg0) * 997 / 1000 >= arg1, 100);
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

