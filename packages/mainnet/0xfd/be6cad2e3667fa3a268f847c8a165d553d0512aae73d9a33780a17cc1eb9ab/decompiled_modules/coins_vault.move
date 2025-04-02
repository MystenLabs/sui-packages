module 0xfdbe6cad2e3667fa3a268f847c8a165d553d0512aae73d9a33780a17cc1eb9ab::coins_vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        deposits: 0x2::table::Table<address, u64>,
    }

    struct BalanceChangeEvent has copy, drop {
        user: address,
        amount: u64,
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id       : 0x2::object::new(arg0),
            balance  : 0x2::balance::zero<T0>(),
            deposits : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.deposits, v0)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, v0);
            *v1 = *v1 + 0x2::coin::value<T0>(&arg1);
        } else {
            0x2::table::add<address, u64>(&mut arg0.deposits, v0, 0x2::coin::value<T0>(&arg1));
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_deposit_balance<T0>(arg0: &Vault<T0>, arg1: address) {
        let v0 = 0;
        if (0x2::table::contains<address, u64>(&arg0.deposits, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(&arg0.deposits, arg1);
        };
        let v1 = BalanceChangeEvent{
            user   : arg1,
            amount : v0,
        };
        0x2::event::emit<BalanceChangeEvent>(v1);
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 0);
        assert!(*0x2::table::borrow<address, u64>(&arg0.deposits, v0) >= arg1, 1);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, v0);
        *v1 = *v1 - arg1;
        if (*v1 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.deposits, v0);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    public fun withdraw_coins_vec<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 0);
        assert!(*0x2::table::borrow<address, u64>(&arg0.deposits, v0) >= arg1, 1);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, v0);
        *v1 = *v1 - arg1;
        if (*v1 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.deposits, v0);
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2));
        v2
    }

    // decompiled from Move bytecode v6
}

