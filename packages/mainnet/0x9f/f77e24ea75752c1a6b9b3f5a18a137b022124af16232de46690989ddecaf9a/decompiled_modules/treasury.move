module 0x9ff77e24ea75752c1a6b9b3f5a18a137b022124af16232de46690989ddecaf9a::treasury {
    struct WrappedTreasury<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun total_supply<T0>(arg0: &WrappedTreasury<T0>) : u64 {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::coin::total_supply<T0>(0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0))
    }

    public fun share<T0>(arg0: WrappedTreasury<T0>) {
        0x2::transfer::share_object<WrappedTreasury<T0>>(arg0);
    }

    public(friend) fun wrap<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : WrappedTreasury<T0> {
        let v0 = 0x2::object::new(arg1);
        let v1 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v0, v1, arg0);
        WrappedTreasury<T0>{id: v0}
    }

    // decompiled from Move bytecode v6
}

