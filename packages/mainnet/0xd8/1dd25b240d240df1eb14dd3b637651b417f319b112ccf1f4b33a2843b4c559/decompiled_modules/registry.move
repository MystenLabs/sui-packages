module 0xd81dd25b240d240df1eb14dd3b637651b417f319b112ccf1f4b33a2843b4c559::registry {
    struct UsernameRegistry has key {
        id: 0x2::object::UID,
        map: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        content_map: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : UsernameRegistry {
        UsernameRegistry{
            id          : 0x2::object::new(arg0),
            map         : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg0),
            content_map : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg0),
        }
    }

    public fun get_blob_content_bytes(arg0: &UsernameRegistry, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.content_map, v0)) {
            let v2 = *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.content_map, v0);
            *0x1::string::as_bytes(&v2)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun get_blob_content_entry(arg0: &UsernameRegistry, arg1: vector<u8>) : vector<u8> {
        get_blob_content_bytes(arg0, arg1)
    }

    public fun get_blob_id(arg0: &UsernameRegistry, arg1: vector<u8>) : 0x1::option::Option<0x1::string::String> {
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.map, v0)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.map, v0))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun get_blob_id_bytes(arg0: &UsernameRegistry, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.map, v0)) {
            let v2 = *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.map, v0);
            *0x1::string::as_bytes(&v2)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun get_blob_id_entry(arg0: &UsernameRegistry, arg1: vector<u8>) : vector<u8> {
        get_blob_id_bytes(arg0, arg1)
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<UsernameRegistry>(create(arg0));
    }

    public fun remove_username(arg0: &mut UsernameRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.map, v0), 2);
        0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.map, v0);
    }

    public fun set_blob_content(arg0: &mut UsernameRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x1::string::length(&v0) > 0, 3);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.content_map, v0)) {
            0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.content_map, v0);
        };
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.content_map, v0, 0x1::string::utf8(arg2));
    }

    public fun set_username(arg0: &mut UsernameRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x1::string::length(&v0) > 0, 3);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.map, v0)) {
            0x2::table::remove<0x1::string::String, 0x1::string::String>(&mut arg0.map, v0);
        };
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg0.map, v0, 0x1::string::utf8(arg2));
    }

    public fun set_username_entry(arg0: &mut UsernameRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        set_username(arg0, arg1, arg2, arg3);
    }

    public fun set_username_with_content(arg0: &mut UsernameRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        set_username(arg0, arg1, arg2, arg4);
        set_blob_content(arg0, arg1, arg3, arg4);
    }

    public fun set_username_with_content_entry(arg0: &mut UsernameRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        set_username_with_content(arg0, arg1, arg2, arg3, arg4);
    }

    public fun username_exists(arg0: &UsernameRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.map, 0x1::string::utf8(arg1))
    }

    // decompiled from Move bytecode v6
}

