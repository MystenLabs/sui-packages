module 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::treasury_caps {
    struct TreasuryCaps has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun get_mut_treasury_cap<T0>(arg0: &mut TreasuryCaps) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

