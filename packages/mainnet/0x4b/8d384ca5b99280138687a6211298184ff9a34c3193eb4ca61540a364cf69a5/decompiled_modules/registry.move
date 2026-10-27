module 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        issuer_key: vector<u8>,
        games: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        profiles: 0x2::table::Table<address, 0x2::object::ID>,
    }

    public(friend) fun add_game(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.games, arg1), 104);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.games, arg1, arg2);
    }

    public(friend) fun add_profile(arg0: &mut Registry, arg1: address, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1), 105);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.profiles, arg1, arg2);
    }

    public(friend) fun assert_current(arg0: &Registry) {
        assert!(arg0.version == 1, 101);
    }

    public(friend) fun assert_live(arg0: &Registry) {
        assert_current(arg0);
        assert!(!arg0.paused, 102);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Registry{
            id         : 0x2::object::new(arg0),
            version    : 1,
            paused     : false,
            issuer_key : b"",
            games      : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            profiles   : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun game_count(arg0: &Registry) : u64 {
        0x2::table::length<0x1::string::String, 0x2::object::ID>(&arg0.games)
    }

    public fun game_id(arg0: &Registry, arg1: 0x1::string::String) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.games, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.games, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun has_prefix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (0x1::vector::length<u8>(arg0) < v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun issuer_key(arg0: &Registry) : vector<u8> {
        arg0.issuer_key
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Registry) {
        assert!(arg1.version < 1, 106);
        arg1.version = 1;
    }

    public fun paused(arg0: &Registry) : bool {
        arg0.paused
    }

    public fun profile_count(arg0: &Registry) : u64 {
        0x2::table::length<address, 0x2::object::ID>(&arg0.profiles)
    }

    public fun profile_id(arg0: &Registry, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.profiles, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun set_issuer_key(arg0: &AdminCap, arg1: &mut Registry, arg2: vector<u8>) {
        assert_current(arg1);
        assert!(0x1::vector::is_empty<u8>(&arg2) || 0x1::vector::length<u8>(&arg2) == 32, 103);
        arg1.issuer_key = arg2;
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::issuer_key_set(0x2::object::id<Registry>(arg1), arg2);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Registry, arg2: bool) {
        arg1.paused = arg2;
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::registry_paused(0x2::object::id<Registry>(arg1), arg2);
    }

    public(friend) fun studio_platform(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"rare:";
        let v2 = if (has_prefix(v0, &v1)) {
            b"rare"
        } else {
            let v3 = b"web:";
            assert!(has_prefix(v0, &v3), 107);
            b"web"
        };
        let v4 = v2;
        assert!(0x1::vector::length<u8>(v0) > 0x1::vector::length<u8>(&v4) + 1, 107);
        0x1::string::utf8(v4)
    }

    public fun version(arg0: &Registry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

