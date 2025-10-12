module 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::asserts {
    public(friend) fun must_is_admin(arg0: address) {
        assert!(arg0 == 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::admin::get_address(), 104);
    }

    public(friend) fun must_is_whitelisted(arg0: bool) {
        assert!(arg0, 105);
    }

    public(friend) fun must_loan_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) == arg1, 101);
    }

    public(friend) fun must_payout_amount<T0>(arg0: &0x2::balance::Balance<T0>) {
        assert!(0x2::balance::value<T0>(arg0) > 0, 106);
    }

    public(friend) fun must_profit_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 102);
    }

    public(friend) fun must_total_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 103);
    }

    // decompiled from Move bytecode v6
}

