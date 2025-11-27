module 0x266bf4c37c7d889368069a018ca967f64010392a3a791b3605913e78cde50c01::dummy_resolver {
    struct DummyResolver has key {
        id: 0x2::object::UID,
        resolver_cap: 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::ResolverCap,
    }

    struct DUMMY_RESOLVER has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMMY_RESOLVER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::create<Witness>(v0, 0x2::package::claim<DUMMY_RESOLVER>(arg0, arg1), arg1);
        0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::resolver::share(v1);
        let v3 = DummyResolver{
            id           : 0x2::object::new(arg1),
            resolver_cap : v2,
        };
        0x2::transfer::share_object<DummyResolver>(v3);
    }

    // decompiled from Move bytecode v6
}

