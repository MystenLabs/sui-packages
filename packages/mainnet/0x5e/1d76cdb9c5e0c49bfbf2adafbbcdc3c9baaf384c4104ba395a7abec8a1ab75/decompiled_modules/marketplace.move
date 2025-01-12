module 0x5e1d76cdb9c5e0c49bfbf2adafbbcdc3c9baaf384c4104ba395a7abec8a1ab75::marketplace {
    struct Marketplace<phantom T0> has key {
        id: 0x2::object::UID,
        items: 0x2::bag::Bag,
        payments: 0x2::table::Table<address, 0x2::coin::Coin<T0>>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        ask: u64,
        owner: address,
    }

    fun buy<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>) : T0 {
        let Listing {
            id    : v0,
            ask   : v1,
            owner : v2,
        } = 0x2::bag::remove<0x2::object::ID, Listing>(&mut arg0.items, arg1);
        let v3 = v0;
        assert!(v1 == 0x2::coin::value<T1>(&arg2), 0);
        if (0x2::table::contains<address, 0x2::coin::Coin<T1>>(&arg0.payments, v2)) {
            0x2::coin::join<T1>(0x2::table::borrow_mut<address, 0x2::coin::Coin<T1>>(&mut arg0.payments, v2), arg2);
        } else {
            0x2::table::add<address, 0x2::coin::Coin<T1>>(&mut arg0.payments, v2, arg2);
        };
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public fun buy_and_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(buy<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace<T0>{
            id       : 0x2::object::new(arg0),
            items    : 0x2::bag::new(arg0),
            payments : 0x2::table::new<address, 0x2::coin::Coin<T0>>(arg0),
        };
        0x2::transfer::share_object<Marketplace<T0>>(v0);
    }

    fun delist<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : _,
            owner : v2,
        } = 0x2::bag::remove<0x2::object::ID, Listing>(&mut arg0.items, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public fun delist_and_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(delist<T0, T1>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun list<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing{
            id    : 0x2::object::new(arg3),
            ask   : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v0.id, true, arg1);
        0x2::bag::add<0x2::object::ID, Listing>(&mut arg0.items, 0x2::object::id<T0>(&arg1), v0);
    }

    fun take_profits<T0>(arg0: &mut Marketplace<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::table::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.payments, 0x2::tx_context::sender(arg1))
    }

    public fun take_profits_and_keep<T0>(arg0: &mut Marketplace<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take_profits<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

