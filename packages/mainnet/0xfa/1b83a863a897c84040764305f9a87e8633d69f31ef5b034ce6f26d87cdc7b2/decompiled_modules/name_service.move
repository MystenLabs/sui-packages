module 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::name_service {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ObligationNameService has store, key {
        id: 0x2::object::UID,
        registry: 0x1::option::Option<0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::Registry>,
    }

    public fun destroy_registry(arg0: &AdminCap, arg1: &mut ObligationNameService) {
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::destroy(0x1::option::extract<0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::Registry>(&mut arg1.registry));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObligationNameService{
            id       : 0x2::object::new(arg0),
            registry : 0x1::option::none<0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::Registry>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = &mut v0;
        new_registry(&v1, v2, arg0);
        0x2::transfer::public_share_object<ObligationNameService>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun new_registry(arg0: &AdminCap, arg1: &mut ObligationNameService, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::Registry>(&arg1.registry), 0);
        0x1::option::fill<0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::Registry>(&mut arg1.registry, 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::new(arg2));
    }

    public fun register_name(arg0: 0x1::string::String, arg1: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::ObligationKey, arg2: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::Obligation, arg3: &mut 0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::Registry, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::assert_key_match(arg2, arg1);
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::add_record(arg3, arg0, 0x2::object::id<0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::Obligation>(arg2), arg4);
    }

    public fun resolve_name(arg0: 0x1::string::String, arg1: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::Registry) : 0x1::option::Option<0x2::object::ID> {
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::lookup_by_name(arg1, arg0)
    }

    public fun resolve_obligation_id(arg0: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::Obligation, arg1: &0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::Registry) : 0x1::option::Option<0x1::string::String> {
        0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::registry::lookup_by_id(arg1, 0x2::object::id<0xfa1b83a863a897c84040764305f9a87e8633d69f31ef5b034ce6f26d87cdc7b2::obligation::Obligation>(arg0))
    }

    // decompiled from Move bytecode v6
}

