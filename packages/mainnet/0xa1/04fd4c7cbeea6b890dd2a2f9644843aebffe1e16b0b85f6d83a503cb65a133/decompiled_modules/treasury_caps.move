module 0x390e0f6824b66844de3763c00afb9d70718097e0f09108a6da6939c37b2bf8ff::treasury_caps {
    struct TreasuryCaps has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun get_mut_treasury_cap<T0>(arg0: &mut TreasuryCaps) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCaps{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TreasuryCaps>(v0);
    }

    public(friend) fun remove_treasury_cap<T0>(arg0: &mut TreasuryCaps) : 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::remove<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public(friend) fun store_treasury_cap<T0>(arg0: &mut TreasuryCaps, arg1: 0x2::coin::TreasuryCap<T0>) {
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), arg1);
    }

    // decompiled from Move bytecode v6
}

