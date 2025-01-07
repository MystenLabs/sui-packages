module 0xcac24042de00f11a7c8e815aedc54a37857f59538fc8d471e5f7e35663e9a687::vault {
    struct DepositContract<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        white_list: vector<address>,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun add_to_white_list<T0>(arg0: &mut DepositContract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x1::vector::push_back<address>(&mut arg0.white_list, arg1);
    }

    public fun deposit<T0>(arg0: &mut DepositContract<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.white_list, &v0) || v0 == arg0.creator, 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun initialize<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositContract<T0>{
            id         : 0x2::object::new(arg0),
            creator    : 0x2::tx_context::sender(arg0),
            white_list : 0x1::vector::empty<address>(),
            balance    : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<DepositContract<T0>>(v0);
    }

    public fun remove_from_white_list<T0>(arg0: &mut DepositContract<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.white_list, &arg1);
        assert!(v0, 2);
        0x1::vector::remove<address>(&mut arg0.white_list, v1);
    }

    public fun withdraw<T0>(arg0: &mut DepositContract<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.white_list, &v0) || v0 == arg0.creator, 3);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), v0);
    }

    public fun withdraw_all<T0>(arg0: &mut DepositContract<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.creator, 1);
        let v1 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v1 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg1), v0);
    }

    // decompiled from Move bytecode v6
}

