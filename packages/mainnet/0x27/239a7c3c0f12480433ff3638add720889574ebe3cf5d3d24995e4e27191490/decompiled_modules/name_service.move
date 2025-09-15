module 0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::name_service {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ObligationNameService has store, key {
        id: 0x2::object::UID,
        registry: 0x1::option::Option<0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::Registry>,
    }

    public fun destroy_registry(arg0: &AdminCap, arg1: &mut ObligationNameService) {
        0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::destroy(0x1::option::extract<0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::Registry>(&mut arg1.registry));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ObligationNameService{
            id       : 0x2::object::new(arg0),
            registry : 0x1::option::none<0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::Registry>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = &mut v0;
        new_registry(&v1, v2, arg0);
        0x2::transfer::public_share_object<ObligationNameService>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun new_registry(arg0: &AdminCap, arg1: &mut ObligationNameService, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::Registry>(&arg1.registry), 0);
        0x1::option::fill<0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::Registry>(&mut arg1.registry, 0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::new(arg2));
    }

    public fun register_name(arg0: 0x1::string::String, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::Registry, arg4: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg2, arg1);
        0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::add_record(arg3, arg0, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2), arg4);
    }

    public fun resolve_name(arg0: 0x1::string::String, arg1: &0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::Registry) : 0x1::option::Option<0x2::object::ID> {
        0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::lookup_by_name(arg1, arg0)
    }

    public fun resolve_obligation_id(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::Registry) : 0x1::option::Option<0x1::string::String> {
        0x27239a7c3c0f12480433ff3638add720889574ebe3cf5d3d24995e4e27191490::registry::lookup_by_id(arg1, 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg0))
    }

    // decompiled from Move bytecode v6
}

