module 0x4fe71d751c5f72c468f06effe68dffb57925570fdd23b1cdd43e2db5c5d65924::coin {
    struct Coin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun join<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Coin<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Coin<T0>>(v0);
    }

    public fun merge<T0, T1>(arg0: &mut Coin<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&arg0.id, v0)) {
            0x2::coin::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.id, v0, arg1);
        };
    }

    public fun split<T0, T1>(arg0: &mut Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg1) == @0xcbb90d8c8c287d804f50b4328876a44a78ab44771a1cefffdb4e4937ccdf299c, 100);
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::coin::Coin<T1>>(&mut arg0.id, 0x1::type_name::get<T1>())
    }

    // decompiled from Move bytecode v6
}

