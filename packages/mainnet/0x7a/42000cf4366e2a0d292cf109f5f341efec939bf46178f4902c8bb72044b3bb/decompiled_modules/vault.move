module 0x7a42000cf4366e2a0d292cf109f5f341efec939bf46178f4902c8bb72044b3bb::vault {
    struct DeepVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
    }

    struct AuthList has key {
        id: 0x2::object::UID,
        addresses: vector<address>,
    }

    public fun assert_authorized(arg0: &AuthList, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.addresses, &v0), 1);
    }

    public fun auth_add(arg0: &mut AuthList, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_authorized(arg0, arg2);
        0x1::vector::push_back<address>(&mut arg0.addresses, arg1);
    }

    public fun create_auth(arg0: vector<address>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AuthList{
            id        : 0x2::object::new(arg1),
            addresses : arg0,
        };
        0x2::transfer::share_object<AuthList>(v0);
    }

    public fun create_vault(arg0: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepVault{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0),
        };
        0x2::transfer::share_object<DeepVault>(v0);
    }

    public fun return_fee(arg0: &mut DeepVault, arg1: &AuthList, arg2: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &0x2::tx_context::TxContext) {
        assert_authorized(arg1, arg3);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, arg2);
    }

    public fun split_fee(arg0: &mut DeepVault, arg1: &AuthList, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert_authorized(arg1, arg3);
        0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, arg2)
    }

    public fun vault_deposit(arg0: &mut DeepVault, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &AuthList, arg3: &0x2::tx_context::TxContext) {
        assert_authorized(arg2, arg3);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    public fun vault_withdraw(arg0: &mut DeepVault, arg1: u64, arg2: &AuthList, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        assert_authorized(arg2, arg3);
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, arg1), arg3)
    }

    // decompiled from Move bytecode v7
}

