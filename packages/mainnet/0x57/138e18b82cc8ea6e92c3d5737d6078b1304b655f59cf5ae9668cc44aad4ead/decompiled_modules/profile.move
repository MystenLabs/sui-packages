module 0x57138e18b82cc8ea6e92c3d5737d6078b1304b655f59cf5ae9668cc44aad4ead::profile {
    struct Registry has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        profiles: 0x2::table::Table<address, address>,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
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
        0x2::table::add<address, address>(&mut arg0.profiles, 0x2::tx_context::sender(arg2), 0x2::object::id_address<Profile>(arg1));
    }

    public entry fun create_profile(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = Profile{
            id          : v0,
            name        : 0x1::string::utf8(arg1),
            image_url   : 0x1::string::utf8(arg2),
            description : 0x1::string::utf8(arg3),
            data        : 0x1::string::utf8(arg4),
        };
        0x2::table::add<address, address>(&mut arg0.profiles, v1, 0x2::object::uid_to_address(&v0));
        0x2::transfer::transfer<Profile>(v2, v1);
        let v3 = EventCreateProfile{
            profile_id  : 0x2::object::uid_to_inner(&v0),
            registry_id : 0x2::object::id<Registry>(arg0),
        };
        0x2::event::emit<EventCreateProfile>(v3);
    }

    public entry fun create_registry(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Registry{
            id       : v0,
            name     : 0x1::string::utf8(arg0),
            profiles : 0x2::table::new<address, address>(arg1),
        };
        0x2::transfer::share_object<Registry>(v1);
        let v2 = EventCreateRegistry{registry_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<EventCreateRegistry>(v2);
    }

    public entry fun edit_profile(arg0: &mut Profile, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.name = 0x1::string::utf8(arg1);
        arg0.image_url = 0x1::string::utf8(arg2);
        arg0.description = 0x1::string::utf8(arg3);
        arg0.data = 0x1::string::utf8(arg4);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://profile.polymedia.app/view/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://polymedia.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Polymedia Profile"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://profile.polymedia.app"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://profile.polymedia.app/img/project_image.png"));
        let v5 = 0x2::display::new_with_fields<Profile>(&v0, v1, v3, arg1);
        0x2::display::update_version<Profile>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Profile>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun remove_dynamic_field<T0: copy + drop + store, T1: store>(arg0: &mut Profile, arg1: T0) : T1 {
        0x2::dynamic_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun remove_dynamic_object_field<T0: copy + drop + store, T1: store + key>(arg0: &mut Profile, arg1: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

