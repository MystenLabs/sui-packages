module 0xc09f8802be006bb7300ec66a1af2394c4f66fcf1350d3b5c992ccb9cc0964998::steamm_bank {
    public fun assert_funds<T0, T1, T2>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T2>, arg1: u64) {
        assert!(0x2::balance::value<T1>(0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::funds_available<T0, T1, T2>(arg0)) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

