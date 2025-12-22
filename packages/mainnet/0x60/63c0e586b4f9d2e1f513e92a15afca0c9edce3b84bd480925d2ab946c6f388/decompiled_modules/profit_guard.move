module 0x6063c0e586b4f9d2e1f513e92a15afca0c9edce3b84bd480925d2ab946c6f388::profit_guard {
    public entry fun check_profit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

