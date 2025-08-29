module 0x38172c7b6e2e87ae7e73c3968edc71150be2f92ae82223b9113d9bcefecea897::ca {
    struct BalanceChecked has copy, drop {
        user: address,
        asset_id: u8,
        supply_balance: u256,
        borrow_balance: u256,
    }

    public fun can(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        assert!(v1 >= arg3 * 99 / 100, 101);
    }

    public fun cane(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        let v2 = BalanceChecked{
            user           : arg2,
            asset_id       : arg1,
            supply_balance : v0,
            borrow_balance : v1,
        };
        0x2::event::emit<BalanceChecked>(v2);
    }

    // decompiled from Move bytecode v6
}

