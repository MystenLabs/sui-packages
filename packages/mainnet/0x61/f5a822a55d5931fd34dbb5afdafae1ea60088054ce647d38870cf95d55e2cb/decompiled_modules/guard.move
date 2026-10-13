module 0x61f5a822a55d5931fd34dbb5afdafae1ea60088054ce647d38870cf95d55e2cb::guard {
    public fun assert_debt_at_least(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        assert!(v1 >= arg3, 1);
    }

    public fun threshold(arg0: u256, arg1: u64, arg2: u256) : u256 {
        let v0 = arg0 * (arg1 as u256) / 100;
        if (v0 > arg2) {
            v0
        } else {
            arg2
        }
    }

    // decompiled from Move bytecode v7
}

