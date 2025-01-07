module 0x20ecc437a3b78ab78cdd2628ce74fc84aafc3d2cc121feedccfc8de90a761791::amh {
    struct MyBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        spam_event_id: 0x2::object::ID,
    }

    public fun new<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::object::new(arg1);
        let v1 = MyBalance<T0>{
            id      : v0,
            balance : arg0,
        };
        0x2::transfer::share_object<MyBalance<T0>>(v1);
        AdminCap{
            id            : 0x2::object::new(arg1),
            spam_event_id : 0x2::object::uid_to_inner(&v0),
        }
    }

    fun check_admin<T0>(arg0: &MyBalance<T0>, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<MyBalance<T0>>(arg0) == &arg1.spam_event_id, 3);
    }

    public entry fun creatBalance<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new<T0>(0x2::coin::into_balance<T0>(arg0), arg1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun deposit<T0>(arg0: &mut MyBalance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public entry fun withdraw<T0>(arg0: &mut MyBalance<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin<T0>(arg0, arg1);
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<T0>(v0) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

