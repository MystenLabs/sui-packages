module 0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::name_service {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ObligationNameService has store, key {
        id: 0x2::object::UID,
        registry: 0x1::option::Option<0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::Registry>,
    }

    public fun destroy_registry(arg0: &AdminCap, arg1: &mut ObligationNameService) {
        0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::destroy(0x1::option::extract<0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::Registry>(&mut arg1.registry));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObligationNameService{
            id       : 0x2::object::new(arg0),
            registry : 0x1::option::none<0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::Registry>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = &mut v0;
        new_registry(&v1, v2, arg0);
        0x2::transfer::public_share_object<ObligationNameService>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun new_registry(arg0: &AdminCap, arg1: &mut ObligationNameService, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::Registry>(&arg1.registry), 0);
        0x1::option::fill<0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::Registry>(&mut arg1.registry, 0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::new(arg2));
    }

    public fun register_name(arg0: &mut ObligationNameService, arg1: 0x1::string::String, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg3, arg2);
        0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::add_record(0x1::option::borrow_mut<0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::Registry>(&mut arg0.registry), arg1, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg3), arg4);
    }

    public fun resolve_name(arg0: &mut ObligationNameService, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::lookup_by_name(0x1::option::borrow_mut<0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::Registry>(&mut arg0.registry), arg1)
    }

    public fun resolve_obligation_id(arg0: &mut ObligationNameService, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : 0x1::option::Option<0x1::string::String> {
        0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::lookup_by_id(0x1::option::borrow_mut<0xf59342ba66255109b7f432aa7877596f9a4c9f7635278ea5fa6d0e3a202ce3cd::registry::Registry>(&mut arg0.registry), 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1))
    }

    // decompiled from Move bytecode v6
}

