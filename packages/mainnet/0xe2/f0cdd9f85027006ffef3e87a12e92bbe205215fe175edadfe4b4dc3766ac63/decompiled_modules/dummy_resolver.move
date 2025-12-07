module 0xe2f0cdd9f85027006ffef3e87a12e92bbe205215fe175edadfe4b4dc3766ac63::dummy_resolver {
    struct DummyResolver has key {
        id: 0x2::object::UID,
        resolver_cap: 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::resolver::ResolverCap,
    }

    struct DUMMY_RESOLVER has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMMY_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::resolver::create<Witness>(v0, 0x2::package::claim<DUMMY_RESOLVER>(arg0, arg1), arg1);
        0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::resolver::share(v1);
        let v3 = DummyResolver{
            id           : 0x2::object::new(arg1),
            resolver_cap : v2,
        };
        0x2::transfer::share_object<DummyResolver>(v3);
    }

    // decompiled from Move bytecode v6
}

