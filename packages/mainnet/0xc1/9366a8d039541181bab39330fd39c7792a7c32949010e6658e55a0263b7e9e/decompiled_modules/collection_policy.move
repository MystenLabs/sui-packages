module 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::collection_policy {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        templates: 0x2::vec_set::VecSet<0x1::string::String>,
        collections: 0x2::vec_set::VecSet<0x1::string::String>,
    }

    struct RegistryChanged has copy, drop {
        registry: 0x2::object::ID,
        sku: 0x1::string::String,
        kind: u8,
        added: bool,
    }

    public fun admin_add_collection(arg0: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskMinter, arg1: &mut Registry, arg2: 0x1::string::String) {
        assert!(arg1.version == 2, 2);
        assert!(0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::valid_sku(&arg2), 3);
        if (!0x2::vec_set::contains<0x1::string::String>(&arg1.collections, &arg2)) {
            0x2::vec_set::insert<0x1::string::String>(&mut arg1.collections, arg2);
            let v0 = RegistryChanged{
                registry : 0x2::object::id<Registry>(arg1),
                sku      : arg2,
                kind     : 1,
                added    : true,
            };
            0x2::event::emit<RegistryChanged>(v0);
        };
    }

    public fun admin_add_template(arg0: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskMinter, arg1: &mut Registry, arg2: 0x1::string::String) {
        assert!(arg1.version == 2, 2);
        assert!(0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::valid_sku(&arg2), 3);
        if (!0x2::vec_set::contains<0x1::string::String>(&arg1.templates, &arg2)) {
            0x2::vec_set::insert<0x1::string::String>(&mut arg1.templates, arg2);
            let v0 = RegistryChanged{
                registry : 0x2::object::id<Registry>(arg1),
                sku      : arg2,
                kind     : 0,
                added    : true,
            };
            0x2::event::emit<RegistryChanged>(v0);
        };
    }

    public fun admin_create_registry(arg0: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskMinter, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id          : 0x2::object::new(arg1),
            version     : 2,
            templates   : 0x2::vec_set::empty<0x1::string::String>(),
            collections : 0x2::vec_set::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun admin_remove_collection(arg0: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskMinter, arg1: &mut Registry, arg2: 0x1::string::String) {
        assert!(arg1.version == 2, 2);
        if (0x2::vec_set::contains<0x1::string::String>(&arg1.collections, &arg2)) {
            0x2::vec_set::remove<0x1::string::String>(&mut arg1.collections, &arg2);
            let v0 = RegistryChanged{
                registry : 0x2::object::id<Registry>(arg1),
                sku      : arg2,
                kind     : 1,
                added    : false,
            };
            0x2::event::emit<RegistryChanged>(v0);
        };
    }

    public fun admin_remove_template(arg0: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskMinter, arg1: &mut Registry, arg2: 0x1::string::String) {
        assert!(arg1.version == 2, 2);
        if (0x2::vec_set::contains<0x1::string::String>(&arg1.templates, &arg2)) {
            0x2::vec_set::remove<0x1::string::String>(&mut arg1.templates, &arg2);
            let v0 = RegistryChanged{
                registry : 0x2::object::id<Registry>(arg1),
                sku      : arg2,
                kind     : 0,
                added    : false,
            };
            0x2::event::emit<RegistryChanged>(v0);
        };
    }

    public fun check_policy_desk(arg0: &vector<u8>, arg1: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskLicense, arg2: &Registry) : bool {
        if (!0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::is_desk_id(arg0)) {
            return false
        };
        let v0 = 0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::template_id(arg1);
        if (!0x2::vec_set::contains<0x1::string::String>(&arg2.collections, &v0)) {
            return false
        };
        let v1 = 0x1::vector::length<u8>(arg0);
        let v2 = 5;
        while (v2 < v1 && *0x1::vector::borrow<u8>(arg0, v2) != 58) {
            v2 = v2 + 1;
        };
        if (v2 == 5 || v2 + 1 >= v1) {
            return false
        };
        let v3 = b"";
        let v4 = 5;
        while (v4 < v2) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(arg0, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x1::string::utf8(v3);
        0x2::vec_set::contains<0x1::string::String>(&arg2.templates, &v5)
    }

    public fun is_collection(arg0: &Registry, arg1: &0x1::string::String) : bool {
        0x2::vec_set::contains<0x1::string::String>(&arg0.collections, arg1)
    }

    public fun is_template(arg0: &Registry, arg1: &0x1::string::String) : bool {
        0x2::vec_set::contains<0x1::string::String>(&arg0.templates, arg1)
    }

    public fun migrate(arg0: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskMinter, arg1: &mut Registry) {
        assert!(arg1.version < 2, 4);
        arg1.version = 2;
    }

    entry fun seal_approve_collection_desk(arg0: vector<u8>, arg1: &0x9a376d022cac31a7db36139a5695f979804913c0713fe28be06bc5d1ee1d41bb::desk_license::DeskLicense, arg2: &Registry) {
        assert!(arg2.version == 2, 2);
        assert!(check_policy_desk(&arg0, arg1, arg2), 1);
    }

    public fun templates(arg0: &Registry) : vector<0x1::string::String> {
        0x2::vec_set::into_keys<0x1::string::String>(arg0.templates)
    }

    // decompiled from Move bytecode v7
}

