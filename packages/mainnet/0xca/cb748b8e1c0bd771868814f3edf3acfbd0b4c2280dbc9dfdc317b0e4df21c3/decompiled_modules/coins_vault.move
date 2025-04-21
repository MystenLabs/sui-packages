module 0xcacb748b8e1c0bd771868814f3edf3acfbd0b4c2280dbc9dfdc317b0e4df21c3::coins_vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        deposits: 0x2::table::Table<address, u64>,
        authorized_withdrawers: 0x2::table::Table<address, vector<address>>,
    }

    struct BalanceChangeEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct AuthorizationEvent has copy, drop {
        depositor: address,
        authorized_withdrawer: address,
    }

    struct RevocationEvent has copy, drop {
        depositor: address,
        unauthorized_withdrawer: address,
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id                     : 0x2::object::new(arg0),
            balance                : 0x2::balance::zero<T0>(),
            deposits               : 0x2::table::new<address, u64>(arg0),
            authorized_withdrawers : 0x2::table::new<address, vector<address>>(arg0),
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
            0x2::table::add<address, vector<address>>(&mut arg0.authorized_withdrawers, v0, 0x1::vector::empty<address>());
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

    public fun grant_withdrawal_permission<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 0);
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.authorized_withdrawers, v0), arg1);
        let v1 = AuthorizationEvent{
            depositor             : v0,
            authorized_withdrawer : arg1,
        };
        0x2::event::emit<AuthorizationEvent>(v1);
    }

    public fun is_authorized<T0>(arg0: &Vault<T0>, arg1: address, arg2: address) : bool {
        if (!0x2::table::contains<address, vector<address>>(&arg0.authorized_withdrawers, arg1)) {
            return false
        };
        0x1::vector::contains<address>(0x2::table::borrow<address, vector<address>>(&arg0.authorized_withdrawers, arg1), &arg2)
    }

    public fun revoke_withdrawal_permission<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 0);
        assert!(0x2::table::contains<address, vector<address>>(&arg0.authorized_withdrawers, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.authorized_withdrawers, v0);
        let (v2, v3) = 0x1::vector::index_of<address>(v1, &arg1);
        assert!(v2, 4);
        0x1::vector::remove<address>(v1, v3);
        let v4 = RevocationEvent{
            depositor               : v0,
            unauthorized_withdrawer : arg1,
        };
        0x2::event::emit<RevocationEvent>(v4);
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_authorized<T0>(arg0, arg1, 0x2::tx_context::sender(arg3)), 1);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, arg1), 0);
        assert!(*0x2::table::borrow<address, u64>(&arg0.deposits, arg1) >= arg2, 2);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, arg1);
        *v0 = *v0 - arg2;
        if (*v0 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.deposits, arg1);
            0x2::table::remove<address, vector<address>>(&mut arg0.authorized_withdrawers, arg1);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

