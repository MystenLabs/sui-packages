module 0x89cd20b9f063f8bd82ada6d847c76b19ef16572b76ac51f28e0aaf84f80fa1c8::token_bridge_resolver {
    struct ParsedVAA has copy, drop {
        token_address: vector<u8>,
        token_chain: u16,
        recipient: address,
    }

    fun build_coin_type_lookup_key(arg0: vector<u8>, arg1: u16) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u16>(&arg1));
        v0
    }

    fun build_redemption_ptb_v2(arg0: &mut 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::PTBBuilder, arg1: vector<u8>, arg2: 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::DiscoveredData) {
        let v0 = parse_vaa(arg1);
        let v1 = v0.recipient;
        let v2 = 0x1::string::utf8(b"core_bridge_package");
        let v3 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::get_discovered_value(&arg2, &v2);
        assert!(0x1::vector::length<u8>(&v3) == 32, 0);
        let v4 = 0x1::string::utf8(b"token_bridge_package");
        let v5 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::get_discovered_value(&arg2, &v4);
        assert!(0x1::vector::length<u8>(&v5) == 32, 1);
        let v6 = 0x2::address::from_bytes(v5);
        let v7 = 0x1::string::utf8(b"coin_type");
        let v8 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::get_discovered_value(&arg2, &v7);
        assert!(!0x1::vector::is_empty<u8>(&v8), 2);
        let v9 = 0x1::string::utf8(v8);
        let v10 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_pure_input(arg0, arg1);
        let v11 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_object_input(arg0, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::create_object_ref(@0x6, 0, 0x1::vector::empty<u8>()));
        let v12 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_object_input(arg0, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::create_object_ref(@0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c, 0, 0x1::vector::empty<u8>()));
        let v13 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_object_input(arg0, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::create_object_ref(@0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, 0, 0x1::vector::empty<u8>()));
        let v14 = 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>();
        let v15 = &mut v14;
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(v15, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::input_handle_to_argument(&v12));
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(v15, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::input_handle_to_argument(&v10));
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(v15, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::input_handle_to_argument(&v11));
        let v16 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_move_call(arg0, 0x2::address::from_bytes(v3), 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"parse_and_verify"), 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::TypeTag>(), v14);
        let v17 = 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>();
        let v18 = &mut v17;
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(v18, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::input_handle_to_argument(&v13));
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(v18, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::command_result_to_argument(&v16));
        let v19 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_move_call(arg0, v6, 0x1::string::utf8(b"vaa"), 0x1::string::utf8(b"verify_only_once"), 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::TypeTag>(), v17);
        let v20 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::create_type_tag(*0x1::string::as_bytes(&v9));
        let v21 = 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::TypeTag>();
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::TypeTag>(&mut v21, v20);
        let v22 = 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>();
        let v23 = &mut v22;
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(v23, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::input_handle_to_argument(&v13));
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(v23, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::command_result_to_argument(&v19));
        let v24 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_move_call(arg0, v6, 0x1::string::utf8(b"complete_transfer"), 0x1::string::utf8(b"authorize_transfer"), v21, v22);
        let v25 = 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::TypeTag>();
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::TypeTag>(&mut v25, v20);
        let v26 = 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>();
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(&mut v26, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::command_result_to_argument(&v24));
        let v27 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_move_call(arg0, v6, 0x1::string::utf8(b"complete_transfer"), 0x1::string::utf8(b"redeem_relayer_payout"), v25, v26);
        let v28 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_pure_input(arg0, 0x2::bcs::to_bytes<address>(&v1));
        let v29 = 0x1::vector::empty<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>();
        0x1::vector::push_back<0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::Argument>(&mut v29, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::command_result_to_argument(&v27));
        0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_transfer_objects(arg0, v29, 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::input_handle_to_argument(&v28));
        0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_required_object(arg0, @0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c);
        0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_required_object(arg0, @0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9);
        0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::add_required_type(arg0, v9);
        let v30 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::create_resolved_result(0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::finalize_builder(arg0));
        0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::emit_resolver_event(&v30);
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

    public fun resolve_vaa(arg0: vector<u8>, arg1: vector<u8>) {
        let v0 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::create_ptb_builder();
        let v1 = if (0x1::vector::is_empty<u8>(&arg1)) {
            0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::create_discovered_data()
        } else {
            0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::discovered_data_from_bytes(arg1)
        };
        let v2 = v1;
        let v3 = 0x1::string::utf8(b"core_bridge_package");
        if (!0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::has_discovered_key(&v2, &v3)) {
            0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::request_package_lookup(&mut v0, @0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c, 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), v3);
        };
        let v4 = 0x1::string::utf8(b"token_bridge_package");
        if (!0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::has_discovered_key(&v2, &v4)) {
            0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::request_package_lookup(&mut v0, @0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, 0x1::string::utf8(b"CurrentPackage"), 0x1::string::utf8(b"package"), v4);
        };
        let v5 = 0x1::string::utf8(b"coin_type");
        if (!0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::has_discovered_key(&v2, &v5)) {
            let v6 = parse_vaa(arg0);
            0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::request_coin_type_lookup(&mut v0, @0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, 0x1::string::utf8(b"token_registry.coin_types"), build_coin_type_lookup_key(v6.token_address, v6.token_chain), v5);
        };
        if (0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::has_pending_lookups(&v0)) {
            let v7 = 0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::create_needs_offchain_result(0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::get_lookups_for_resolution(&v0));
            0xc6650eb7fcbb3544a4c19d4b58755c1a3514683738673389e7ef4f49fd0992d4::ptb_types::emit_resolver_event(&v7);
            return
        };
        let v8 = &mut v0;
        build_redemption_ptb_v2(v8, arg0, v2);
    }

    // decompiled from Move bytecode v6
}

