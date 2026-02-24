module 0x5262b018ce1c42651af4db272ef8d2a5cd97b8b7dd1a44faa83e80cd90e0d579::trash_can {
    struct TrashCan has key {
        id: 0x2::object::UID,
        bag: 0x2::bag::Bag,
    }

    public fun get_balance<T0>(arg0: &TrashCan) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.bag, v0))
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TrashCan{
            id  : 0x2::object::new(arg0),
            bag : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<TrashCan>(v0);
    }

    public fun trash_any_coin<T0>(arg0: &mut TrashCan, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    public fun withdraw<T0>(arg0: &mut TrashCan, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, v0), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.bag, v0), arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

