module 0x875c47a2b1fb2a156755e310d8fde174652d15827a86f1d39bd7c5f39054cda1::dc {
    struct B<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct AL has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    public fun deposit<T0>(arg0: &mut B<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    fun is_admin(arg0: &AL, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.admin == 0x2::tx_context::sender(arg1)
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x5b712236facb45aeadb0f48fcb90f3e9b17a5b4740ab33c5f119e98209d94208, 1);
        let v0 = AL{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<AL>(v0);
    }

    public fun new_b<T0>(arg0: &mut AL, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 1);
        let v0 = B<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<T0>(arg1),
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<B<T0>>(v0);
    }

    public fun withdraw<T0>(arg0: &mut AL, arg1: &mut B<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_admin(arg0, arg3), 1);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

