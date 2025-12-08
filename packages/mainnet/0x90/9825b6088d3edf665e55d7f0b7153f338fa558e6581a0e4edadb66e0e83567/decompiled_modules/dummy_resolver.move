module 0x909825b6088d3edf665e55d7f0b7153f338fa558e6581a0e4edadb66e0e83567::dummy_resolver {
    struct DummyResolver has key {
        id: 0x2::object::UID,
        resolver_cap: 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::ResolverCap,
    }

    struct DUMMY_RESOLVER has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMMY_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::create<Witness>(v0, 0x2::package::claim<DUMMY_RESOLVER>(arg0, arg1), arg1);
        0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::resolver::share(v1);
        let v3 = DummyResolver{
            id           : 0x2::object::new(arg1),
            resolver_cap : v2,
        };
        0x2::transfer::share_object<DummyResolver>(v3);
    }

    // decompiled from Move bytecode v6
}

