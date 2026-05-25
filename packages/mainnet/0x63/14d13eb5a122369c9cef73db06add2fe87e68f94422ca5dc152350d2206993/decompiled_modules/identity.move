module 0x6314d13eb5a122369c9cef73db06add2fe87e68f94422ca5dc152350d2206993::identity {
    struct IDENTITY has drop {
        dummy_field: bool,
    }

    struct CellarIdentity has key {
        id: 0x2::object::UID,
        owner: address,
        level: u8,
        win_count: u64,
        perk_flags: u64,
        metadata_url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        by_owner: 0x2::table::Table<address, 0x2::object::ID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct IdentitySynced has copy, drop {
        owner: address,
        identity_id: 0x2::object::ID,
        level: u8,
        win_count: u64,
    }

    public fun create_identity(arg0: &AdminCap, arg1: &mut Registry, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg1.by_owner, arg2), 1);
        let v0 = CellarIdentity{
            id           : 0x2::object::new(arg8),
            owner        : arg2,
            level        : arg3,
            win_count    : arg4,
            perk_flags   : arg5,
            metadata_url : arg6,
            image_url    : arg7,
        };
        let v1 = 0x2::object::id<CellarIdentity>(&v0);
        0x2::table::add<address, 0x2::object::ID>(&mut arg1.by_owner, arg2, v1);
        let v2 = IdentitySynced{
            owner       : arg2,
            identity_id : v1,
            level       : arg3,
            win_count   : arg4,
        };
        0x2::event::emit<IdentitySynced>(v2);
        0x2::transfer::transfer<CellarIdentity>(v0, arg2);
    }

    fun identity_display_keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        v0
    }

    fun identity_display_values() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(x"43656c6c6172204964656e7469747920e28094204c6576656c207b6c6576656c7d"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"VinoBid HK collector credentials ({win_count} wins)"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{metadata_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://vino-bid.com"));
        v0
    }

    public fun identity_id_for_owner(arg0: &Registry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.by_owner, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.by_owner, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun init(arg0: IDENTITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<IDENTITY>(arg0, arg1);
        let v1 = Registry{
            id       : 0x2::object::new(arg1),
            by_owner : 0x2::table::new<address, 0x2::object::ID>(arg1),
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = 0x2::display::new_with_fields<CellarIdentity>(&v0, identity_display_keys(), identity_display_values(), arg1);
        0x2::display::update_version<CellarIdentity>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<CellarIdentity>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Registry>(v1);
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun sync_identity(arg0: &AdminCap, arg1: &mut CellarIdentity, arg2: u8, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        arg1.level = arg2;
        arg1.win_count = arg3;
        arg1.perk_flags = arg4;
        arg1.metadata_url = arg5;
        arg1.image_url = arg6;
        let v0 = IdentitySynced{
            owner       : arg1.owner,
            identity_id : 0x2::object::id<CellarIdentity>(arg1),
            level       : arg2,
            win_count   : arg3,
        };
        0x2::event::emit<IdentitySynced>(v0);
    }

    // decompiled from Move bytecode v7
}

