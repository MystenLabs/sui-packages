module 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::asserts {
    public(friend) fun must_amount(arg0: u64) {
        assert!(arg0 > 0, 107);
    }

    public(friend) fun must_amount_equals(arg0: u64, arg1: u64) {
        assert!(arg0 == arg1, 109);
    }

    public fun must_amount_greated_than(arg0: u64, arg1: u64) {
        assert!(arg0 > arg1, 108);
    }

    public(friend) fun must_is_admin(arg0: address) {
        assert!(arg0 == 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::admin::get_address(), 104);
    }

    public(friend) fun must_is_whitelisted(arg0: bool) {
        assert!(arg0, 105);
    }

    // decompiled from Move bytecode v7
}

