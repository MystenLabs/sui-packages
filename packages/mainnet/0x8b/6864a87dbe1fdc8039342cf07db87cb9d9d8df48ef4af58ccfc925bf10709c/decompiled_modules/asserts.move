module 0x31f5b17ed5d7fc0e0bc8fc9c90e29bd0186e4df258c0c2ca72df5b1c0e832562::asserts {
    public(friend) fun address_is_whitelisted(arg0: bool) {
        assert!(arg0, 105);
    }

    public(friend) fun loan_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) == arg1, 101);
    }

    public(friend) fun payout_amount<T0>(arg0: &0x2::balance::Balance<T0>) {
        assert!(0x2::balance::value<T0>(arg0) > 0, 107);
    }

    public(friend) fun profit_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 102);
    }

    public(friend) fun sender_is_admin(arg0: address) {
        assert!(arg0 == 0x31f5b17ed5d7fc0e0bc8fc9c90e29bd0186e4df258c0c2ca72df5b1c0e832562::admin::get_address(), 104);
    }

    public(friend) fun sender_is_whitelisted(arg0: bool) {
        assert!(arg0, 106);
    }

    public(friend) fun total_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 103);
    }

    // decompiled from Move bytecode v6
}

