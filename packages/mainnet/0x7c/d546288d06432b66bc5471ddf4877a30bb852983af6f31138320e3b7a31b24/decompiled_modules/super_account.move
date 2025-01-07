module 0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::super_account {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance_bag: 0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::BalanceBag,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun value<T0>(arg0: &Treasury) : u64 {
        0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::value<T0>(&arg0.balance_bag)
    }

    public fun add_whitelist_address(arg0: &mut Treasury, arg1: &TreasuryCap, arg2: address) {
        0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::whitelist::add_whitelist_address(&mut arg0.id, arg2);
    }

    public fun allow_all(arg0: &mut Treasury, arg1: &TreasuryCap) {
        0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::whitelist::allow_all(&mut arg0.id);
    }

    public fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        let v0 = &mut arg0.balance_bag;
        if (0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::contains<T0>(v0) == false) {
            0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::init_balance<T0>(v0);
        };
        0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::join<T0>(&mut arg0.balance_bag, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            balance_bag : 0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::new(arg0),
        };
        let v1 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::whitelist::allow_all(&mut v0.id);
        0x2::transfer::share_object<Treasury>(v0);
        0x2::transfer::transfer<TreasuryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun make_up<T0>(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::whitelist::is_address_allowed(&arg0.id, 0x2::tx_context::sender(arg3)) == true, 272);
        let v0 = 0x2::coin::value<T0>(arg1);
        if (arg2 == v0) {
            return
        };
        if (arg2 > v0) {
            0x2::coin::join<T0>(arg1, 0x2::coin::from_balance<T0>(0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::split<T0>(&mut arg0.balance_bag, arg2 - v0), arg3));
        } else {
            0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::join<T0>(&mut arg0.balance_bag, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v0 - arg2, arg3)));
        };
    }

    public fun reject_all(arg0: &mut Treasury, arg1: &TreasuryCap) {
        0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::whitelist::reject_all(&mut arg0.id);
    }

    public fun remove_whitelist_address(arg0: &mut Treasury, arg1: &TreasuryCap, arg2: address) {
        0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::whitelist::remove_whitelist_address(&mut arg0.id, arg2);
    }

    public fun switch_to_whitelist_mode(arg0: &mut Treasury, arg1: &TreasuryCap) {
        0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::whitelist::switch_to_whitelist_mode(&mut arg0.id);
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::whitelist::is_address_allowed(&arg0.id, 0x2::tx_context::sender(arg2)) == true, 272);
        0x2::coin::from_balance<T0>(0x7cd546288d06432b66bc5471ddf4877a30bb852983af6f31138320e3b7a31b24::balance_bag::split<T0>(&mut arg0.balance_bag, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

