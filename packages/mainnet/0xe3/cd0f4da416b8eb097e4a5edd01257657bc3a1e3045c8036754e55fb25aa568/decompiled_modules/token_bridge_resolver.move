module 0xe3cd0f4da416b8eb097e4a5edd01257657bc3a1e3045c8036754e55fb25aa568::token_bridge_resolver {
    struct ParsedVAA has copy, drop {
        token_address: vector<u8>,
        token_chain: u16,
        recipient: address,
    }

    fun build_coin_type_structured_key(arg0: vector<u8>, arg1: u16) : vector<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::StructField> {
        let v0 = 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::StructField>();
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::StructField>(&mut v0, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_struct_field(b"addr", arg0));
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::StructField>(&mut v0, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_struct_field(b"chain", 0x2::bcs::to_bytes<u16>(&arg1)));
        v0
    }

    fun build_redemption_ptb(arg0: &mut 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::PTBBuilder, arg1: vector<u8>, arg2: address, arg3: address, arg4: 0x1::string::String, arg5: address, arg6: address) {
        let v0 = parse_vaa(arg1);
        let v1 = v0.recipient;
        let v2 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_pure_input(arg0, arg1);
        let v3 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_object_input(arg0, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_object_ref(@0x6, 0, 0x1::vector::empty<u8>()));
        let v4 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_object_input(arg0, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_object_ref(arg5, 0, 0x1::vector::empty<u8>()));
        let v5 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_object_input(arg0, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_object_ref(arg6, 0, 0x1::vector::empty<u8>()));
        let v6 = 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(v7, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::input_handle_to_argument(&v4));
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(v7, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::input_handle_to_argument(&v2));
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(v7, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::input_handle_to_argument(&v3));
        let v8 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_move_call(arg0, arg2, 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"parse_and_verify"), 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::TypeTag>(), v6);
        let v9 = 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(v10, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::input_handle_to_argument(&v5));
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(v10, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::command_result_to_argument(&v8));
        let v11 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_move_call(arg0, arg3, 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"verify_only_once"), 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::TypeTag>(), v9);
        let v12 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_type_tag(*0x1::string::as_bytes(&arg4));
        let v13 = 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::TypeTag>();
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::TypeTag>(&mut v13, v12);
        let v14 = 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(v15, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::input_handle_to_argument(&v5));
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(v15, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::command_result_to_argument(&v11));
        let v16 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_move_call(arg0, arg3, 0x1::string::utf8(b"complete_transfer"), 0x1::string::utf8(b"authorize_transfer"), v13, v14);
        let v17 = 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::TypeTag>();
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::TypeTag>(&mut v17, v12);
        let v18 = 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>();
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(&mut v18, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::command_result_to_argument(&v16));
        let v19 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_move_call(arg0, arg3, 0x1::string::utf8(b"complete_transfer"), 0x1::string::utf8(b"redeem_relayer_payout"), v17, v18);
        let v20 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_pure_input(arg0, 0x2::bcs::to_bytes<address>(&v1));
        let v21 = 0x1::vector::empty<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>();
        0x1::vector::push_back<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::Argument>(&mut v21, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::command_result_to_argument(&v19));
        0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_transfer_objects(arg0, v21, 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::input_handle_to_argument(&v20));
        0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_required_object(arg0, arg5);
        0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_required_object(arg0, arg6);
        0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::add_required_type(arg0, arg4);
        let v22 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_resolved_result(0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::finalize_builder(arg0));
        0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::emit_resolver_event(&v22);
    }

    fun extract_recipient(arg0: vector<u8>) : address {
        let v0 = 0 + 1 + 4;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v0 + 1 + 66 * (*0x1::vector::borrow<u8>(&arg0, v0) as u64) + 4 + 4 + 2 + 32 + 8 + 1 + 1 + 32 + 32 + 2 + v2));
            v2 = v2 + 1;
        };
        0x2::address::from_bytes(v1)
    }

    fun extract_token_address(arg0: vector<u8>) : vector<u8> {
        let v0 = 0 + 1 + 4;
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v0 + 1 + 66 * (*0x1::vector::borrow<u8>(&arg0, v0) as u64) + 4 + 4 + 2 + 32 + 8 + 1 + 1 + 32 + v2));
            v2 = v2 + 1;
        };
        v1
    }

    fun extract_token_chain(arg0: vector<u8>) : u16 {
        let v0 = 0 + 1 + 4;
        let v1 = v0 + 1 + 66 * (*0x1::vector::borrow<u8>(&arg0, v0) as u64) + 4 + 4 + 2 + 32 + 8 + 1 + 1 + 32 + 32;
        (*0x1::vector::borrow<u8>(&arg0, v1) as u16) << 8 | (*0x1::vector::borrow<u8>(&arg0, v1 + 1) as u16)
    }

    fun parse_vaa(arg0: vector<u8>) : ParsedVAA {
        ParsedVAA{
            token_address : extract_token_address(arg0),
            token_chain   : extract_token_chain(arg0),
            recipient     : extract_recipient(arg0),
        }
    }

    public fun resolve_vaa(arg0: &0xe3cd0f4da416b8eb097e4a5edd01257657bc3a1e3045c8036754e55fb25aa568::state::State, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_ptb_builder(arg2);
        let v1 = 0xe3cd0f4da416b8eb097e4a5edd01257657bc3a1e3045c8036754e55fb25aa568::state::core_bridge_state(arg0);
        let v2 = 0xe3cd0f4da416b8eb097e4a5edd01257657bc3a1e3045c8036754e55fb25aa568::state::token_bridge_state(arg0);
        let v3 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::request_package_lookup(&mut v0, v1, 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), 0x1::string::utf8(b"core_bridge_package"));
        let v4 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::request_package_lookup(&mut v0, v2, 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), 0x1::string::utf8(b"token_bridge_package"));
        let v5 = 0x1::option::none<vector<u8>>();
        if (0x1::option::is_some<address>(&v4)) {
            let v6 = parse_vaa(arg1);
            let v7 = 0x1::string::utf8(b"0x");
            0x1::string::append(&mut v7, 0x2::address::to_string(*0x1::option::borrow<address>(&v4)));
            0x1::string::append(&mut v7, 0x1::string::utf8(b"::token_registry::CoinTypeKey"));
            v5 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::request_table_item_lookup(&mut v0, v2, 0x1::string::utf8(b"token_registry.coin_types"), 0x1::option::none<vector<u8>>(), 0x1::option::some<vector<0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::StructField>>(build_coin_type_structured_key(v6.token_address, v6.token_chain)), v7, 0x1::string::utf8(b"coin_type"));
        };
        if (0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::has_pending_lookups(&v0)) {
            let v8 = 0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::create_needs_offchain_result(0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::get_lookups_for_resolution(&v0));
            0x50ac4ec745068f27084a6e568f88fb59aef4b36c6c3178e2f253505b37ce0a83::ptb_types::emit_resolver_event(&v8);
            return
        };
        let v9 = &mut v0;
        build_redemption_ptb(v9, arg1, *0x1::option::borrow<address>(&v3), *0x1::option::borrow<address>(&v4), 0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&v5)), v1, v2);
    }

    // decompiled from Move bytecode v6
}

