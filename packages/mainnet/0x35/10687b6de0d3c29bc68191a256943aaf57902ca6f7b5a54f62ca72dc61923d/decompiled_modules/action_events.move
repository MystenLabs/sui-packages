module 0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::action_events {
    struct IntentActionsStaged has copy, drop {
        source_type: u8,
        source_id: 0x2::object::ID,
        outcome_index: u64,
        action_types: vector<0x1::string::String>,
    }

    struct ActionParamsStaged has copy, drop {
        source_type: u8,
        source_id: 0x2::object::ID,
        outcome_index: u64,
        action_index: u64,
        action_type: 0x1::string::String,
        param_types: vector<0x1::string::String>,
        param_names: vector<0x1::string::String>,
        param_values: vector<0x1::string::String>,
    }

    struct ParamsBuilder has drop {
        types: vector<0x1::string::String>,
        names: vector<0x1::string::String>,
        values: vector<0x1::string::String>,
    }

    public fun add_address(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: address) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"address"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, address_to_hex(arg2));
    }

    public fun add_bool(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: bool) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"bool"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = if (arg2) {
            0x1::string::utf8(b"true")
        } else {
            0x1::string::utf8(b"false")
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_id(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: 0x2::object::ID) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"ID"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, address_to_hex(0x2::object::id_to_address(&arg2)));
    }

    public fun add_option_address(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: 0x1::option::Option<address>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"Option<address>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = if (0x1::option::is_some<address>(&arg2)) {
            address_to_hex(*0x1::option::borrow<address>(&arg2))
        } else {
            0x1::string::utf8(b"null")
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_option_bool(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: 0x1::option::Option<bool>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"Option<bool>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = if (0x1::option::is_some<bool>(&arg2)) {
            if (*0x1::option::borrow<bool>(&arg2)) {
                0x1::string::utf8(b"true")
            } else {
                0x1::string::utf8(b"false")
            }
        } else {
            0x1::string::utf8(b"null")
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_option_string(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: &0x1::option::Option<0x1::string::String>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"Option<String>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = if (0x1::option::is_some<0x1::string::String>(arg2)) {
            let v1 = 0x1::string::utf8(b"{\"some_hex\":\"");
            0x1::string::append(&mut v1, bytes_to_hex(0x1::string::as_bytes(0x1::option::borrow<0x1::string::String>(arg2))));
            0x1::string::append_utf8(&mut v1, b"\"}");
            v1
        } else {
            0x1::string::utf8(b"{\"none\":true}")
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_option_u128(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: 0x1::option::Option<u128>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"Option<u128>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = if (0x1::option::is_some<u128>(&arg2)) {
            u128_to_string(*0x1::option::borrow<u128>(&arg2))
        } else {
            0x1::string::utf8(b"null")
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_option_u64(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: 0x1::option::Option<u64>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"Option<u64>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            u64_to_string(*0x1::option::borrow<u64>(&arg2))
        } else {
            0x1::string::utf8(b"null")
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_option_vector_address(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: &0x1::option::Option<vector<address>>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"Option<vector<address>>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = if (0x1::option::is_some<vector<address>>(arg2)) {
            let v1 = 0x1::option::borrow<vector<address>>(arg2);
            let v2 = 0x1::string::utf8(b"{\"some\":[");
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(v1)) {
                if (v3 > 0) {
                    0x1::string::append_utf8(&mut v2, b", ");
                };
                0x1::string::append_utf8(&mut v2, b"\"");
                0x1::string::append(&mut v2, address_to_hex(*0x1::vector::borrow<address>(v1, v3)));
                0x1::string::append_utf8(&mut v2, b"\"");
                v3 = v3 + 1;
            };
            0x1::string::append_utf8(&mut v2, b"]}");
            v2
        } else {
            0x1::string::utf8(b"{\"none\":true}")
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_string(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: 0x1::string::String) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"String"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, bytes_to_hex(0x1::string::as_bytes(&arg2)));
    }

    public fun add_u128(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: u128) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"u128"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, u128_to_string(arg2));
    }

    public fun add_u64(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: u64) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"u64"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, u64_to_string(arg2));
    }

    public fun add_u8(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: u8) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"u8"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, u64_to_string((arg2 as u64)));
    }

    public fun add_vector_address(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: &vector<address>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"vector<address>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = 0x1::string::utf8(b"[");
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg2)) {
            if (v1 > 0) {
                0x1::string::append_utf8(&mut v0, b", ");
            };
            0x1::string::append_utf8(&mut v0, b"\"");
            0x1::string::append(&mut v0, address_to_hex(*0x1::vector::borrow<address>(arg2, v1)));
            0x1::string::append_utf8(&mut v0, b"\"");
            v1 = v1 + 1;
        };
        0x1::string::append_utf8(&mut v0, b"]");
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_vector_string(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: &vector<0x1::string::String>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"vector<String>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        let v0 = 0x1::string::utf8(b"[");
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(arg2)) {
            if (v1 > 0) {
                0x1::string::append_utf8(&mut v0, b", ");
            };
            0x1::string::append_utf8(&mut v0, b"\"");
            0x1::string::append(&mut v0, bytes_to_hex(0x1::string::as_bytes(0x1::vector::borrow<0x1::string::String>(arg2, v1))));
            0x1::string::append_utf8(&mut v0, b"\"");
            v1 = v1 + 1;
        };
        0x1::string::append_utf8(&mut v0, b"]");
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, v0);
    }

    public fun add_vector_u8(arg0: &mut ParamsBuilder, arg1: vector<u8>, arg2: &vector<u8>) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.types, 0x1::string::utf8(b"vector<u8>"));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.names, 0x1::string::utf8(arg1));
        0x1::vector::push_back<0x1::string::String>(&mut arg0.values, bytes_to_hex(arg2));
    }

    fun address_to_hex(arg0: address) : 0x1::string::String {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(0x2::address::to_bytes(arg0)));
        0x1::string::utf8(v0)
    }

    fun bytes_to_hex(arg0: &vector<u8>) : 0x1::string::String {
        let v0 = b"0x";
        0x1::vector::append<u8>(&mut v0, 0x2::hex::encode(*arg0));
        0x1::string::utf8(v0)
    }

    public fun emit_action_params(arg0: ParamsBuilder, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::string::String, arg5: u64) {
        let ParamsBuilder {
            types  : v0,
            names  : v1,
            values : v2,
        } = arg0;
        let v3 = ActionParamsStaged{
            source_type   : arg1,
            source_id     : arg2,
            outcome_index : arg3,
            action_index  : arg5,
            action_type   : arg4,
            param_types   : v0,
            param_names   : v1,
            param_values  : v2,
        };
        0x2::event::emit<ActionParamsStaged>(v3);
    }

    public fun emit_intent_actions(arg0: u8, arg1: 0x2::object::ID, arg2: u64, arg3: vector<0x1::string::String>) {
        let v0 = IntentActionsStaged{
            source_type   : arg0,
            source_id     : arg1,
            outcome_index : arg2,
            action_types  : arg3,
        };
        0x2::event::emit<IntentActionsStaged>(v0);
    }

    public fun new_builder() : ParamsBuilder {
        ParamsBuilder{
            types  : 0x1::vector::empty<0x1::string::String>(),
            names  : 0x1::vector::empty<0x1::string::String>(),
            values : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun source_factory_init() : u8 {
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::source_factory_init()
    }

    public fun source_launchpad_failure() : u8 {
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::source_launchpad_failure()
    }

    public fun source_launchpad_success() : u8 {
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::source_launchpad_success()
    }

    public fun source_proposal() : u8 {
        0x3510687b6de0d3c29bc68191a256943aaf57902ca6f7b5a54f62ca72dc61923d::constants::source_proposal()
    }

    fun u128_to_string(arg0: u128) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::insert<u8>(&mut v0, ((arg0 % 10) as u8) + 48, 0);
            arg0 = arg0 / 10;
        };
        0x1::string::utf8(v0)
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::insert<u8>(&mut v0, ((arg0 % 10) as u8) + 48, 0);
            arg0 = arg0 / 10;
        };
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

