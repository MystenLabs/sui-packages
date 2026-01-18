module 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver {
    fun build_coin_type_structured_key(arg0: vector<u8>, arg1: u16) : vector<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::StructField> {
        let v0 = 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::StructField>();
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::StructField>(&mut v0, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_struct_field(b"addr", arg0));
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::StructField>(&mut v0, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_struct_field(b"chain", 0x2::bcs::to_bytes<u16>(&arg1)));
        v0
    }

    fun build_redemption_ptb(arg0: &mut 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::PTBBuilder, arg1: vector<u8>, arg2: address, arg3: address, arg4: address, arg5: 0x1::string::String, arg6: &0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::State) {
        assert!(!0x1::string::is_empty(&arg5), 0);
        let v0 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_pure_input_raw_bytes(arg0, arg1);
        let v1 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_object_input(arg0, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_object_ref(@0x6, 0, 0x1::vector::empty<u8>()));
        let v2 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_object_input(arg0, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_object_ref(0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::wormhole_state(arg6), 0, 0x1::vector::empty<u8>()));
        let v3 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_object_input(arg0, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_object_ref(0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::token_bridge_state(arg6), 0, 0x1::vector::empty<u8>()));
        let v4 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_object_input(arg0, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_object_ref(0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::relayer_state(arg6), 0, 0x1::vector::empty<u8>()));
        let v5 = 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>();
        let v6 = &mut v5;
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v6, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::input_handle_to_argument(&v2));
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v6, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::input_handle_to_argument(&v0));
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v6, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::input_handle_to_argument(&v1));
        let v7 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_move_call(arg0, arg2, 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"parse_and_verify"), 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::TypeTag>(), v5);
        let v8 = 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>();
        let v9 = &mut v8;
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v9, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::input_handle_to_argument(&v3));
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v9, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::command_result_to_argument(&v7));
        let v10 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_move_call(arg0, arg3, 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"verify_only_once"), 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::TypeTag>(), v8);
        let v11 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_type_tag(*0x1::string::as_bytes(&arg5));
        let v12 = 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::TypeTag>();
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::TypeTag>(&mut v12, v11);
        let v13 = 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>();
        let v14 = &mut v13;
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v14, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::input_handle_to_argument(&v3));
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v14, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::command_result_to_argument(&v10));
        let v15 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_move_call(arg0, arg3, 0x1::string::utf8(b"complete_transfer_with_payload"), 0x1::string::utf8(b"authorize_transfer"), v12, v13);
        let v16 = 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::TypeTag>();
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::TypeTag>(&mut v16, v11);
        let v17 = 0x1::vector::empty<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>();
        let v18 = &mut v17;
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v18, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::input_handle_to_argument(&v4));
        0x1::vector::push_back<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::Argument>(v18, 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::command_result_to_argument(&v15));
        0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_move_call(arg0, arg4, 0x1::string::utf8(b"redeem"), 0x1::string::utf8(b"execute_vaa_v1"), v16, v17);
        0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_required_object(arg0, 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::wormhole_state(arg6));
        0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_required_object(arg0, 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::token_bridge_state(arg6));
        0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_required_object(arg0, 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::relayer_state(arg6));
        0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::add_required_type(arg0, arg5);
        let v19 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_resolved_result(0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::finalize_builder(arg0));
        0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::emit_resolver_event(&v19);
    }

    public fun resolve_vaa(arg0: &0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::State, arg1: vector<u8>, arg2: vector<u8>) {
        0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::vaa_parser::validate_transfer_with_payload(arg1);
        let v0 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_ptb_builder(arg2);
        let v1 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::request_package_lookup(&mut v0, 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::wormhole_state(arg0), 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), 0x1::string::utf8(b"wormhole_package"));
        let v2 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::request_package_lookup(&mut v0, 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::token_bridge_state(arg0), 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), 0x1::string::utf8(b"token_bridge_package"));
        let v3 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::request_object_field_lookup(&mut v0, 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::relayer_state(arg0), 0x1::string::utf8(b"package_id"), 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::lookup_value_type_address(), 0x1::string::utf8(b"relayer_package"));
        let v4 = if (0x1::option::is_some<vector<u8>>(&v3)) {
            0x1::option::some<address>(0x2::address::from_bytes(*0x1::option::borrow<vector<u8>>(&v3)))
        } else {
            0x1::option::none<address>()
        };
        let v5 = v4;
        let v6 = 0x1::option::none<vector<u8>>();
        if (0x1::option::is_some<address>(&v2)) {
            let v7 = 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::vaa_parser::parse_transfer_info(arg1);
            let v8 = 0x1::string::utf8(b"0x");
            0x1::string::append(&mut v8, 0x2::address::to_string(*0x1::option::borrow<address>(&v2)));
            0x1::string::append(&mut v8, 0x1::string::utf8(b"::token_registry::CoinTypeKey"));
            v6 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::request_table_item_lookup(&mut v0, 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::resolver_state::token_bridge_state(arg0), 0x1::string::utf8(b"token_registry.coin_types"), 0x1::option::none<vector<u8>>(), 0x1::option::some<vector<0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::StructField>>(build_coin_type_structured_key(0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::vaa_parser::token_address(&v7), 0x10d5abef0e70726cc115aa2d7f569e197f6ec622d01f308f53b4b91b2ba45e63::vaa_parser::token_chain(&v7))), v8, 0x1::string::utf8(b"coin_type"));
        };
        if (0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::has_pending_lookups(&v0)) {
            let v9 = 0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::create_needs_offchain_result(0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::get_lookups_for_resolution(&v0));
            0xdfec4ecd86a5037ad2f69fff3b09f9fa9fc04c240192984e5ab9605e2c2d271e::ptb_types::emit_resolver_event(&v9);
            return
        };
        assert!(0x1::option::is_some<address>(&v1), 1);
        assert!(0x1::option::is_some<address>(&v2), 2);
        assert!(0x1::option::is_some<address>(&v5), 4);
        assert!(0x1::option::is_some<vector<u8>>(&v6), 3);
        let v10 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v10, 0x1::string::utf8(*0x1::option::borrow<vector<u8>>(&v6)));
        let v11 = &mut v0;
        build_redemption_ptb(v11, arg1, *0x1::option::borrow<address>(&v1), *0x1::option::borrow<address>(&v2), *0x1::option::borrow<address>(&v5), v10, arg0);
    }

    // decompiled from Move bytecode v6
}

