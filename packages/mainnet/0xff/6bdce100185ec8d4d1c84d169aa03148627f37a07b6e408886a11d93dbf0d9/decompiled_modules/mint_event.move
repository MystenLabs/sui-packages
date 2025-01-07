module 0xff6bdce100185ec8d4d1c84d169aa03148627f37a07b6e408886a11d93dbf0d9::mint_event {
    struct MintEvent<phantom T0> has copy, drop {
        collection_id: 0x2::object::ID,
        object: 0x2::object::ID,
    }

    struct BurnEvent<phantom T0> has copy, drop {
        collection_id: 0x2::object::ID,
        object: 0x2::object::ID,
    }

    struct BurnGuard<phantom T0> {
        id: 0x2::object::ID,
    }

    public fun emit_burn<T0: key>(arg0: BurnGuard<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::UID) {
        let BurnGuard { id: v0 } = arg0;
        assert!(0x2::object::uid_to_inner(&arg2) == v0, 1);
        0x2::object::delete(arg2);
        let v1 = BurnEvent<T0>{
            collection_id : arg1,
            object        : v0,
        };
        0x2::event::emit<BurnEvent<T0>>(v1);
    }

    public fun emit_mint<T0: key>(arg0: 0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::witness::Witness<T0>, arg1: 0x2::object::ID, arg2: &T0) {
        let v0 = MintEvent<T0>{
            collection_id : arg1,
            object        : 0x2::object::id<T0>(arg2),
        };
        0x2::event::emit<MintEvent<T0>>(v0);
    }

    public fun start_burn<T0: key>(arg0: 0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::witness::Witness<T0>, arg1: &T0) : BurnGuard<T0> {
        BurnGuard<T0>{id: 0x2::object::id<T0>(arg1)}
    }

    // decompiled from Move bytecode v6
}

