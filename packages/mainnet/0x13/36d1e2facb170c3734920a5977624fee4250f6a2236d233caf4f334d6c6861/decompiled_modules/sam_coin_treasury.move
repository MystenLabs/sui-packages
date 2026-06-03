module 0xd2550407673e08d06c4b1f16f31bb7313e5de02c5212f6e0627250e3bc72f282::sam_coin_treasury {
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

    // decompiled from Move bytecode v7
}

