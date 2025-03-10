module 0xeb3c317d64d128c6a34135a4811853fb14c523ddda5cea85f7b9ee1953d87cd7::profile {
    struct Registry has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        profiles: 0x2::table::Table<address, address>,
        names: 0x2::table::Table<0x1::string::String, address>,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        x_account: 0x1::string::String,
        telegram: 0x1::string::String,
        data: 0x1::string::String,
    }

    struct EventCreateRegistry has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct EventCreateProfile has copy, drop {
        profile_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
    }

    struct LookupResult {
        lookup_addr: address,
        profile_addr: address,
    }

    struct PROFILE has drop {
        dummy_field: bool,
    }

    public fun add_dynamic_field<T0: copy + drop + store, T1: store>(arg0: &mut Profile, arg1: T0, arg2: T1) {
        0x2::dynamic_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun add_dynamic_object_field<T0: copy + drop + store, T1: store + key>(arg0: &mut Profile, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public entry fun add_to_registry(arg0: &mut Registry, arg1: &mut Profile, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.names, arg1.name), 100);
        0x2::table::add<address, address>(&mut arg0.profiles, v0, 0x2::object::id_address<Profile>(arg1));
        0x2::table::add<0x1::string::String, address>(&mut arg0.names, arg1.name, v0);
    }

    public entry fun create_profile(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.names, v0), 100);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = Profile{
            id          : v1,
            name        : v0,
            image_url   : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            x_account   : 0x1::string::utf8(arg4),
            telegram    : 0x1::string::utf8(arg5),
            data        : 0x1::string::utf8(arg6),
        };
        0x2::table::add<address, address>(&mut arg0.profiles, v2, 0x2::object::uid_to_address(&v1));
        0x2::table::add<0x1::string::String, address>(&mut arg0.names, v0, v2);
        0x2::transfer::transfer<Profile>(v3, v2);
        let v4 = EventCreateProfile{
            profile_id  : 0x2::object::uid_to_inner(&v1),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        0x2::event::emit<EventCreateProfile>(v4);
    }

    public entry fun create_registry(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Registry{
            id       : v0,
            name     : 0x1::string::utf8(arg0),
            profiles : 0x2::table::new<address, address>(arg1),
            names    : 0x2::table::new<0x1::string::String, address>(arg1),
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = EventCreateRegistry{registry_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<EventCreateRegistry>(v2);
    }

    public entry fun edit_profile(arg0: &mut Profile, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        arg0.image_url = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
        arg0.x_account = 0x1::string::utf8(arg3);
        arg0.telegram = 0x1::string::utf8(arg4);
        arg0.data = 0x1::string::utf8(arg5);
    }

    public fun get_profiles(arg0: &Registry, arg1: vector<address>) : vector<LookupResult> {
        let v0 = 0x1::vector::empty<LookupResult>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<address>(&arg1, v1);
            if (0x2::table::contains<address, address>(&arg0.profiles, v2)) {
                let v3 = LookupResult{
                    lookup_addr  : v2,
                    profile_addr : *0x2::table::borrow<address, address>(&arg0.profiles, v2),
                };
                0x1::vector::push_back<LookupResult>(&mut v0, v3);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: PROFILE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PROFILE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"x_account"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"telegram"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{x_account}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{telegram}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://profile.tardinator.com/view/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://tardinator.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Tardinator Profile Hub"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://profile.tardinator.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://profile.tardinator.com/img/project_image.png"));
        let v5 = 0x2::display::new_with_fields<Profile>(&v0, v1, v3, arg1);
        0x2::display::update_version<Profile>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Profile>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_username_available(arg0: &Registry, arg1: vector<u8>) : bool {
        !0x2::table::contains<0x1::string::String, address>(&arg0.names, 0x1::string::utf8(arg1))
    }

    public fun remove_dynamic_field<T0: copy + drop + store, T1: store>(arg0: &mut Profile, arg1: T0) : T1 {
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun remove_dynamic_object_field<T0: copy + drop + store, T1: store + key>(arg0: &mut Profile, arg1: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    fun validate_username(arg0: &0x1::string::String) : bool {
        let v0 = *0x1::string::bytes(arg0);
        !0x1::vector::is_empty<u8>(&v0)
    }

    // decompiled from Move bytecode v6
}

