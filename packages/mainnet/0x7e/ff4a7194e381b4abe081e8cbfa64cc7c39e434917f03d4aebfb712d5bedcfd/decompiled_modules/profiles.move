module 0x7eff4a7194e381b4abe081e8cbfa64cc7c39e434917f03d4aebfb712d5bedcfd::profiles {
    struct Registry has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, Profile>,
        names: 0x2::table::Table<0x1::string::String, address>,
    }

    struct Profile has copy, drop, store {
        name: 0x1::string::String,
        avatar: 0x1::string::String,
        x_handle: 0x1::string::String,
        updated_ms: u64,
    }

    struct ProfileSet has copy, drop {
        owner: address,
        name: 0x1::string::String,
        avatar: 0x1::string::String,
        x_handle: 0x1::string::String,
    }

    struct ProfileCleared has copy, drop {
        owner: address,
    }

    public fun avatar(arg0: &Profile) : 0x1::string::String {
        arg0.avatar
    }

    public fun clear_profile(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, v0), 4);
        let v1 = 0x2::table::remove<address, Profile>(&mut arg0.profiles, v0);
        0x2::table::remove<0x1::string::String, address>(&mut arg0.names, v1.name);
        let v2 = ProfileCleared{owner: v0};
        0x2::event::emit<ProfileCleared>(v2);
    }

    public fun has_profile(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, Profile>(&arg0.profiles, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg0),
            profiles : 0x2::table::new<address, Profile>(arg0),
            names    : 0x2::table::new<0x1::string::String, address>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_taken(arg0: &Registry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.names, arg1)
    }

    fun is_valid_handle(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 > 15) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 65 && v3 <= 90) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else {
                v3 == 95
            };
            if (!v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun is_valid_name(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 3 || v1 > 20) {
            return false
        };
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x1::vector::borrow<u8>(v0, v2);
            let v4 = if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else {
                v3 == 95
            };
            if (!v4) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun name(arg0: &Profile) : 0x1::string::String {
        arg0.name
    }

    public fun owner_of(arg0: &Registry, arg1: 0x1::string::String) : address {
        *0x2::table::borrow<0x1::string::String, address>(&arg0.names, arg1)
    }

    public fun profile(arg0: &Registry, arg1: address) : &Profile {
        0x2::table::borrow<address, Profile>(&arg0.profiles, arg1)
    }

    public fun set_profile(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(is_valid_name(&arg1), 0);
        assert!(is_valid_handle(&arg3), 2);
        assert!(0x1::string::length(&arg2) <= 64, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        if (0x2::table::contains<0x1::string::String, address>(&arg0.names, arg1)) {
            assert!(*0x2::table::borrow<0x1::string::String, address>(&arg0.names, arg1) == v0, 1);
        };
        if (0x2::table::contains<address, Profile>(&arg0.profiles, v0)) {
            let v1 = 0x2::table::remove<address, Profile>(&mut arg0.profiles, v0);
            0x2::table::remove<0x1::string::String, address>(&mut arg0.names, v1.name);
        };
        0x2::table::add<0x1::string::String, address>(&mut arg0.names, arg1, v0);
        let v2 = Profile{
            name       : arg1,
            avatar     : arg2,
            x_handle   : arg3,
            updated_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<address, Profile>(&mut arg0.profiles, v0, v2);
        let v3 = ProfileSet{
            owner    : v0,
            name     : arg1,
            avatar   : arg2,
            x_handle : arg3,
        };
        0x2::event::emit<ProfileSet>(v3);
    }

    public fun x_handle(arg0: &Profile) : 0x1::string::String {
        arg0.x_handle
    }

    // decompiled from Move bytecode v7
}

