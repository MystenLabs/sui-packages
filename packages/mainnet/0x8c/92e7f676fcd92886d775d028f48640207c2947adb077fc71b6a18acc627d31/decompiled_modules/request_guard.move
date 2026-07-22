module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::request_guard {
    public(friend) fun validate_deadline_at(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg1 > 0, 107);
        assert!(arg0 <= arg2, 101);
        assert!(arg2 - arg0 <= 30000, 102);
    }

    public(friend) fun validate_request_at(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1 > 0, 107);
        assert!(arg2 > 0, 100);
        assert!(arg1 <= 18446744073709551615 - arg2, 109);
        assert!(arg3 >= arg1 + arg2, 105);
        assert!(arg0 <= arg4, 101);
        assert!(arg4 - arg0 <= 30000, 102);
    }

    // decompiled from Move bytecode v7
}

