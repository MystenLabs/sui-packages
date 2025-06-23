module 0x29ba7f7bc53e776f27a6d1289555ded2f407b4b1a799224f06b26addbcd1c33d::blizzard_treasury {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct BlizzardTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : BlizzardTreasury<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 4);
        let v0 = BlizzardTreasury<T0>{id: 0x2::object::new(arg1)};
        let v1 = Key{dummy_field: false};
        0x2::dynamic_object_field::add<Key, 0x2::coin::TreasuryCap<T0>>(&mut v0.id, v1, arg0);
        v0
    }

    public(friend) fun inner<T0>(arg0: &BlizzardTreasury<T0>) : &0x2::coin::TreasuryCap<T0> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_object_field::borrow<Key, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    public(friend) fun inner_mut<T0>(arg0: &mut BlizzardTreasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<Key, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

