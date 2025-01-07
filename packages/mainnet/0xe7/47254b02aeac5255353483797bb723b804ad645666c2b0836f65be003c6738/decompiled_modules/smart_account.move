module 0xe747254b02aeac5255353483797bb723b804ad645666c2b0836f65be003c6738::smart_account {
    struct Account<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AccountCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    public fun value<T0>(arg0: &Account<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun deposit<T0>(arg0: &mut Account<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun is_owner<T0>(arg0: &AccountCap<T0>, arg1: &Account<T0>) : bool {
        arg0.for == 0x2::object::id<Account<T0>>(arg1)
    }

    public fun open_account<T0>(arg0: &mut 0x2::tx_context::TxContext) : (Account<T0>, AccountCap<T0>) {
        let v0 = Account<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        let v1 = AccountCap<T0>{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<Account<T0>>(&v0),
        };
        (v0, v1)
    }

    public fun withdraw<T0>(arg0: &AccountCap<T0>, arg1: &mut Account<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_owner<T0>(arg0, arg1), 403);
        assert!(value<T0>(arg1) >= arg2, 404);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

