module 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::asserts {
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
        assert!(arg0 == 0xff5e41e4af9f4ac8d5439be75e304a682ae33565fd5c5dd6ea9f0a565c08e053::admin::get_address(), 104);
    }

    public(friend) fun sender_is_whitelisted(arg0: bool) {
        assert!(arg0, 106);
    }

    public(friend) fun total_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 103);
    }

    // decompiled from Move bytecode v6
}

