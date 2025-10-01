module 0x779b43f9ba514d8e9a794db3e0c7dcf998ebf04bf5d7e98d9215b2ee7ca20301::token_bridge_resolver {
    struct ParsedVAA has copy, drop {
        token_address: vector<u8>,
        token_chain: u16,
        recipient: address,
    }

    fun build_coin_type_structured_key(arg0: vector<u8>, arg1: u16) : vector<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::StructField> {
        let v0 = 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::StructField>();
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::StructField>(&mut v0, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_struct_field(b"addr", arg0));
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::StructField>(&mut v0, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_struct_field(b"chain", 0x2::bcs::to_bytes<u16>(&arg1)));
        v0
    }

    fun build_redemption_ptb(arg0: &mut 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::PTBBuilder, arg1: vector<u8>, arg2: 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::DiscoveredData, arg3: address, arg4: address) {
        let v0 = parse_vaa(arg1);
        let v1 = v0.recipient;
        let v2 = 0x1::string::utf8(b"core_bridge_package");
        let v3 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::get_discovered_value(&arg2, &v2);
        assert!(0x1::vector::length<u8>(&v3) == 32, 0);
        let v4 = 0x1::string::utf8(b"token_bridge_package");
        let v5 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::get_discovered_value(&arg2, &v4);
        assert!(0x1::vector::length<u8>(&v5) == 32, 1);
        let v6 = 0x2::address::from_bytes(v5);
        let v7 = 0x1::string::utf8(b"coin_type");
        let v8 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::get_discovered_value(&arg2, &v7);
        assert!(!0x1::vector::is_empty<u8>(&v8), 2);
        let v9 = 0x1::string::utf8(v8);
        let v10 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_pure_input(arg0, arg1);
        let v11 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_object_input(arg0, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_object_ref(@0x6, 0, 0x1::vector::empty<u8>()));
        let v12 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_object_input(arg0, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_object_ref(arg3, 0, 0x1::vector::empty<u8>()));
        let v13 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_object_input(arg0, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_object_ref(arg4, 0, 0x1::vector::empty<u8>()));
        let v14 = 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(v15, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::input_handle_to_argument(&v12));
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(v15, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::input_handle_to_argument(&v10));
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(v15, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::input_handle_to_argument(&v11));
        let v16 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_move_call(arg0, 0x2::address::from_bytes(v3), 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"parse_and_verify"), 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::TypeTag>(), v14);
        let v17 = 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>();
        let v18 = &mut v17;
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(v18, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::input_handle_to_argument(&v13));
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(v18, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::command_result_to_argument(&v16));
        let v19 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_move_call(arg0, v6, 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"verify_only_once"), 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::TypeTag>(), v17);
        let v20 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_type_tag(*0x1::string::as_bytes(&v9));
        let v21 = 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::TypeTag>();
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::TypeTag>(&mut v21, v20);
        let v22 = 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>();
        let v23 = &mut v22;
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(v23, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::input_handle_to_argument(&v13));
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(v23, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::command_result_to_argument(&v19));
        let v24 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_move_call(arg0, v6, 0x1::string::utf8(b"complete_transfer"), 0x1::string::utf8(b"authorize_transfer"), v21, v22);
        let v25 = 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::TypeTag>();
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::TypeTag>(&mut v25, v20);
        let v26 = 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>();
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(&mut v26, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::command_result_to_argument(&v24));
        let v27 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_move_call(arg0, v6, 0x1::string::utf8(b"complete_transfer"), 0x1::string::utf8(b"redeem_relayer_payout"), v25, v26);
        let v28 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_pure_input(arg0, 0x2::bcs::to_bytes<address>(&v1));
        let v29 = 0x1::vector::empty<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>();
        0x1::vector::push_back<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::Argument>(&mut v29, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::command_result_to_argument(&v27));
        0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_transfer_objects(arg0, v29, 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::input_handle_to_argument(&v28));
        0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_required_object(arg0, arg3);
        0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_required_object(arg0, arg4);
        0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::add_required_type(arg0, v9);
        let v30 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_resolved_result(0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::finalize_builder(arg0));
        0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::emit_resolver_event(&v30);
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

    public fun resolve_vaa(arg0: &0x779b43f9ba514d8e9a794db3e0c7dcf998ebf04bf5d7e98d9215b2ee7ca20301::state::State, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_ptb_builder();
        let v1 = if (0x1::vector::is_empty<u8>(&arg2)) {
            0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_discovered_data()
        } else {
            0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::discovered_data_from_bytes(arg2)
        };
        let v2 = v1;
        let v3 = 0x779b43f9ba514d8e9a794db3e0c7dcf998ebf04bf5d7e98d9215b2ee7ca20301::state::core_bridge_state(arg0);
        let v4 = 0x779b43f9ba514d8e9a794db3e0c7dcf998ebf04bf5d7e98d9215b2ee7ca20301::state::token_bridge_state(arg0);
        let v5 = 0x1::string::utf8(b"core_bridge_package");
        if (!0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::has_discovered_key(&v2, &v5)) {
            0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::request_package_lookup(&mut v0, v3, 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), v5);
        };
        let v6 = 0x1::string::utf8(b"token_bridge_package");
        if (!0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::has_discovered_key(&v2, &v6)) {
            0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::request_package_lookup(&mut v0, v4, 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), v6);
        };
        let v7 = 0x1::string::utf8(b"coin_type");
        if (!0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::has_discovered_key(&v2, &v7)) {
            let v8 = parse_vaa(arg1);
            0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::request_table_item_lookup(&mut v0, v4, 0x1::string::utf8(b"token_registry.coin_types"), 0x1::option::none<vector<u8>>(), 0x1::option::some<vector<0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::StructField>>(build_coin_type_structured_key(v8.token_address, v8.token_chain)), v7);
        };
        if (0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::has_pending_lookups(&v0)) {
            let v9 = 0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::create_needs_offchain_result(0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::get_lookups_for_resolution(&v0));
            0x9ea83844ea861582fcb3d08e2032efc5269e4621ad4e757e631927ffabffcf4f::ptb_types::emit_resolver_event(&v9);
            return
        };
        let v10 = &mut v0;
        build_redemption_ptb(v10, arg1, v2, v3, v4);
    }

    // decompiled from Move bytecode v6
}

