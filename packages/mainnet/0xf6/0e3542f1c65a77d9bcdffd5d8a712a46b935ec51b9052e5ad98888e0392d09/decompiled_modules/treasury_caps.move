module 0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::treasury_caps {
    struct TreasuryCaps has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun get_mut_treasury_cap<T0>(arg0: &mut TreasuryCaps) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x1::type_name::with_defining_ids<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCaps{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<TreasuryCaps>(v0);
    }

    public fun manager_store_treasury_cap<T0>(arg0: &0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::admin::Version, arg1: &mut TreasuryCaps, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::tx_context::TxContext) {
        0x9003219180252ae6b81d2893b41d430488669027219537236675c0c2924c94d9::admin::verify(arg0, arg3);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::type_name::with_defining_ids<T0>(), arg2);
    }

    // decompiled from Move bytecode v6
}

