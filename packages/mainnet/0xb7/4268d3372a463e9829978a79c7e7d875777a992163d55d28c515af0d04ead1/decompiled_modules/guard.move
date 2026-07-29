module 0xb74268d3372a463e9829978a79c7e7d875777a992163d55d28c515af0d04ead1::guard {
    public fun assert_debt_at_least(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u64) {
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg0, arg1, arg2) >= (arg3 as u256), 901);
    }

    // decompiled from Move bytecode v7
}

