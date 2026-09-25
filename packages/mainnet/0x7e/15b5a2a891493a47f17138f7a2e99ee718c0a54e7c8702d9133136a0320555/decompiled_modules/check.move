module 0x7e15b5a2a891493a47f17138f7a2e99ee718c0a54e7c8702d9133136a0320555::check {
    fun check(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 <= arg1, 101);
        } else {
            assert!(arg0 >= arg1, 101);
        };
    }

    public fun fullsail<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        check(0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun steamm<T0, T1, T2: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>, arg1: u128, arg2: bool) {
        let (v0, v1) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::balance_amounts<T0, T1, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>(arg0);
        if (arg2) {
            assert!(((v1 as u256) + (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::offset<T0, T1, T2>(arg0) as u256) << 128) / (v0 as u256) <= (arg1 as u256) * (arg1 as u256), 101);
        } else {
            assert!(((v1 as u256) + (0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::offset<T0, T1, T2>(arg0) as u256) << 128) / (v0 as u256) >= (arg1 as u256) * (arg1 as u256), 101);
        };
    }

    // decompiled from Move bytecode v7
}

