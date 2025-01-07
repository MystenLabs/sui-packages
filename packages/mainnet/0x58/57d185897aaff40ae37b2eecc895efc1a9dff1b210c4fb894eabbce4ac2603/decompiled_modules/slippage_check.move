module 0x5857d185897aaff40ae37b2eecc895efc1a9dff1b210c4fb894eabbce4ac2603::slippage_check {
    public entry fun check_slippage<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!(arg1 <= 1000000000, 1);
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 >= arg2) {
            return
        };
        assert!(arg2 * arg1 / 1000000000 >= arg2 - v0, 0);
    }

    // decompiled from Move bytecode v6
}

