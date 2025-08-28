module 0xc5605cd8b7f46bc5f1fa6c230f9b0bf58d671813d3e61f9bd81cca248a86231::token_bridge_resolver {
    struct ParsedVAA has copy, drop {
        token_address: vector<u8>,
        token_chain: u16,
        action: u8,
    }

    fun address_from_bytes(arg0: vector<u8>) : address {
        0x2::address::from_bytes(arg0)
    }

    fun build_coin_type_lookup_key(arg0: vector<u8>, arg1: u16) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg1));
        v0
    }

    fun build_redemption_ptb(arg0: vector<u8>, arg1: 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::DiscoveredData) : 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::ResolverResult {
        let v0 = @0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c;
        let v1 = @0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9;
        let v2 = 0x1::string::utf8(b"core_bridge_package");
        let v3 = 0x1::string::utf8(b"token_bridge_package");
        let v4 = address_from_bytes(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::get_discovered_value(&arg1, &v3));
        let v5 = 0x1::string::utf8(b"coin_type");
        let v6 = 0x1::string::utf8(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::get_discovered_value(&arg1, &v5));
        let v7 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Input>();
        let v8 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Command>();
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Input>(&mut v7, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_object_input(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_object_ref(v0, 0, 0x1::vector::empty<u8>())));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Input>(&mut v7, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_pure_input(arg0));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Input>(&mut v7, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_object_input(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_object_ref(@0x6, 0, 0x1::vector::empty<u8>())));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Input>(&mut v7, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_object_input(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_object_ref(v1, 0, 0x1::vector::empty<u8>())));
        let v9 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(v10, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_input_arg(0));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(v10, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_input_arg(1));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(v10, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_input_arg(2));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Command>(&mut v8, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_command(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_data(address_from_bytes(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::get_discovered_value(&arg1, &v2)), 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"parse_and_verify"), 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::TypeTag>(), v9)));
        let v11 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(v12, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_input_arg(3));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(v12, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_result_arg(0));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Command>(&mut v8, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_command(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_data(v4, 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"verify_only_once"), 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::TypeTag>(), v11)));
        let v13 = 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_type_tag(0x2::bcs::to_bytes<0x1::string::String>(&v6));
        let v14 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::TypeTag>();
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::TypeTag>(&mut v14, v13);
        let v15 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>();
        let v16 = &mut v15;
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(v16, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_input_arg(3));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(v16, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_result_arg(1));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Command>(&mut v8, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_command(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_data(v4, 0x1::string::utf8(b"complete_transfer"), 0x1::string::utf8(b"authorize_transfer"), v14, v15)));
        let v17 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::TypeTag>();
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::TypeTag>(&mut v17, v13);
        let v18 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>();
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(&mut v18, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_result_arg(2));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Command>(&mut v8, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_command(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_data(v4, 0x1::string::utf8(b"complete_transfer"), 0x1::string::utf8(b"redeem_relayer_payout"), v17, v18)));
        let v19 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::TypeTag>();
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::TypeTag>(&mut v19, v13);
        let v20 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>();
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Argument>(&mut v20, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_result_arg(3));
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::Command>(&mut v8, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_command(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_move_call_data(v4, 0x1::string::utf8(b"coin_utils"), 0x1::string::utf8(b"return_nonzero"), v19, v20)));
        let v21 = 0x1::vector::empty<address>();
        let v22 = &mut v21;
        0x1::vector::push_back<address>(v22, v0);
        0x1::vector::push_back<address>(v22, v1);
        let v23 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v23, v6);
        let v24 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::InstructionGroup>();
        0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::InstructionGroup>(&mut v24, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_instruction_group(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_ptb_instruction(v7, v8), v21, v23));
        0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_resolved_result(0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_instruction_groups(v24), 0)
    }

    fun extract_token_address(arg0: vector<u8>) : vector<u8> {
        let v0 = 0 + 1 + 4;
        let v1 = v0 + 1 + 66 * (*0x1::vector::borrow<u8>(&arg0, v0) as u64) + 4 + 4 + 2 + 32 + 8 + 1 + 1 + 32;
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 32 && v1 + v3 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0, v1 + v3));
            v3 = v3 + 1;
        };
        while (0x1::vector::length<u8>(&v2) < 32) {
            0x1::vector::push_back<u8>(&mut v2, 0);
        };
        v2
    }

    fun extract_token_chain(arg0: vector<u8>) : u16 {
        let v0 = 0 + 1 + 4;
        let v1 = v0 + 1 + 66 * (*0x1::vector::borrow<u8>(&arg0, v0) as u64) + 4 + 4 + 2 + 32 + 8 + 1 + 1 + 32 + 32;
        if (v1 + 1 < 0x1::vector::length<u8>(&arg0)) {
            return (*0x1::vector::borrow<u8>(&arg0, v1) as u16) << 8 | (*0x1::vector::borrow<u8>(&arg0, v1 + 1) as u16)
        };
        1
    }

    fun parse_vaa(arg0: vector<u8>) : ParsedVAA {
        ParsedVAA{
            token_address : extract_token_address(arg0),
            token_chain   : extract_token_chain(arg0),
            action        : 1,
        }
    }

    public fun resolve_vaa(arg0: vector<u8>, arg1: vector<u8>) {
        let v0 = if (0x1::vector::is_empty<u8>(&arg1)) {
            0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_discovered_data()
        } else {
            0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::discovered_data_from_bytes(arg1)
        };
        let v1 = v0;
        let v2 = 0x1::string::utf8(b"core_bridge_package");
        let v3 = 0x1::string::utf8(b"token_bridge_package");
        let v4 = 0x1::string::utf8(b"coin_type");
        if (!0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::has_discovered_key(&v1, &v2)) {
            let v5 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::OffchainLookup>();
            0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::OffchainLookup>(&mut v5, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_dynamic_field_by_type_lookup(@0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c, 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), v2, 0));
            let v6 = 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_needs_offchain_result(v5, 0);
            0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::emit_resolver_event(&v6);
            return
        };
        if (!0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::has_discovered_key(&v1, &v3)) {
            let v7 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::OffchainLookup>();
            0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::OffchainLookup>(&mut v7, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_dynamic_field_by_type_lookup(@0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), v3, 0));
            let v8 = 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_needs_offchain_result(v7, 0);
            0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::emit_resolver_event(&v8);
            return
        };
        if (!0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::has_discovered_key(&v1, &v4)) {
            let v9 = parse_vaa(arg0);
            let v10 = 0x1::vector::empty<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::OffchainLookup>();
            0x1::vector::push_back<0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::OffchainLookup>(&mut v10, 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_table_lookup(@0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, 0x1::string::utf8(b"token_registry.coin_types"), build_coin_type_lookup_key(v9.token_address, v9.token_chain), v4, 2));
            let v11 = 0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::create_needs_offchain_result(v10, 0);
            0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::emit_resolver_event(&v11);
            return
        };
        let v12 = build_redemption_ptb(arg0, v1);
        0x67b170e780bc3eea4f3024f7a679bdfafb0777b9bbbd4217fc2b6e83b9c5ebfa::ptb_types::emit_resolver_event(&v12);
    }

    // decompiled from Move bytecode v6
}

