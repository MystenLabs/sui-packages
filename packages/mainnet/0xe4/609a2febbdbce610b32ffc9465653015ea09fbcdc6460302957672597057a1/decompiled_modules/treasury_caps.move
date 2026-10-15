module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::treasury_caps {
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

    public fun manager_store_treasury_cap<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut TreasuryCaps, arg2: 0x2::coin::TreasuryCap<T0>, arg3: &0x2::tx_context::TxContext) {
        0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin::verify(arg0, arg3);
        assert!(0x2::coin::total_supply<T0>(&arg2) == 0, 2703);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::type_name::with_defining_ids<T0>(), arg2);
    }

    // decompiled from Move bytecode v7
}

