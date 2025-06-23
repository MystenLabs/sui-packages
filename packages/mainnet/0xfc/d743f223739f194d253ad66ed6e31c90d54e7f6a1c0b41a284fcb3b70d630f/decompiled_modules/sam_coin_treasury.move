module 0xfcd743f223739f194d253ad66ed6e31c90d54e7f6a1c0b41a284fcb3b70d630f::sam_coin_treasury {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct SamTreasury<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : SamTreasury<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 5);
        let v0 = SamTreasury<T0>{id: 0x2::object::new(arg1)};
        let v1 = Key{dummy_field: false};
        0x2::dynamic_object_field::add<Key, 0x2::coin::TreasuryCap<T0>>(&mut v0.id, v1, arg0);
        v0
    }

    public(friend) fun inner<T0>(arg0: &SamTreasury<T0>) : &0x2::coin::TreasuryCap<T0> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_object_field::borrow<Key, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    public(friend) fun inner_mut<T0>(arg0: &mut SamTreasury<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = Key{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<Key, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

