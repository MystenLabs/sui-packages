module 0x910fd7e88647ea9369ab269fa5629f0efd815dfa5a7b7ef2355ffee13852413b::twitter {
    struct Twitter has drop {
        dummy_field: bool,
    }

    public fun extract_screen_name_from_context(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::as_bytes(arg0);
        let v1 = b"\"screen_name\":\"";
        let v2 = find_substring(v0, &v1);
        if (v2 == 0x1::vector::length<u8>(v0)) {
            return 0x1::ascii::string(b"")
        };
        let v3 = v2 + 0x1::vector::length<u8>(&v1);
        let v4 = v3;
        while (v4 < 0x1::vector::length<u8>(v0)) {
            if (*0x1::vector::borrow<u8>(v0, v4) == 34) {
                break
            };
            v4 = v4 + 1;
        };
        if (v4 == 0x1::vector::length<u8>(v0)) {
            return 0x1::ascii::string(b"")
        };
        let v5 = 0x1::vector::empty<u8>();
        while (v3 < v4) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(v0, v3));
            v3 = v3 + 1;
        };
        0x1::ascii::string(v5)
    }

    public fun find_substring(arg0: &vector<u8>, arg1: &vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        if (v1 == 0 || v1 > v0) {
            return v0
        };
        let v2 = 0;
        while (v2 <= v0 - v1) {
            let v3 = 0;
            let v4 = true;
            while (v3 < v1) {
                if (*0x1::vector::borrow<u8>(arg0, v2 + v3) != *0x1::vector::borrow<u8>(arg1, v3)) {
                    v4 = false;
                    break
                };
                v3 = v3 + 1;
            };
            if (v4) {
                return v2
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun update_with_twitter_proof(arg0: &mut 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::IdentityManager<Twitter>, arg1: &0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::Config, arg2: 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::Proof<Twitter>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Twitter{dummy_field: false};
        0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::config::assert_version(arg1);
        let v1 = 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::context(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::proof_claim_info<Twitter>(&arg2));
        let v2 = extract_screen_name_from_context(&v1);
        let v3 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, 0x1::ascii::String>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_address_to_identifier_borrow<Twitter>(arg0, &v0), v3)) {
            let (_, _) = 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::drop_identifier_info(0x2::table::remove<0x1::ascii::String, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::IdentifierInfo>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_identifier_info_borrow_mut<Twitter>(arg0, &mut v0), 0x2::table::remove<address, 0x1::ascii::String>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_address_to_identifier_borrow_mut<Twitter>(arg0, &mut v0), v3)));
        };
        if (0x2::table::contains<0x1::ascii::String, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::IdentifierInfo>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_identifier_info_borrow<Twitter>(arg0, &v0), v2)) {
            let v6 = 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::owner(0x2::table::borrow<0x1::ascii::String, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::IdentifierInfo>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_identifier_info_borrow<Twitter>(arg0, &v0), v2));
            if (v6 != v3) {
                let (_, _) = 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::drop_identifier_info(0x2::table::remove<0x1::ascii::String, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::IdentifierInfo>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_identifier_info_borrow_mut<Twitter>(arg0, &mut v0), v2));
                0x2::table::remove<address, 0x1::ascii::String>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_address_to_identifier_borrow_mut<Twitter>(arg0, &mut v0), v6);
            };
        };
        0x2::table::add<0x1::ascii::String, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::IdentifierInfo>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_identifier_info_borrow_mut<Twitter>(arg0, &mut v0), v2, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::new_identifier_info(v3, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::proof_claimed_at<Twitter>(&arg2)));
        0x2::table::add<address, 0x1::ascii::String>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_address_to_identifier_borrow_mut<Twitter>(arg0, &mut v0), v3, v2);
        0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::burn_proof<Twitter>(arg2);
        return
        let v9 = 0x2::table::borrow_mut<0x1::ascii::String, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::IdentifierInfo>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_identifier_info_borrow_mut<Twitter>(arg0, &mut v0), v2);
        0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::update_owner(v9, v3);
        0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::update_updated_at(v9, 0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::proof_claimed_at<Twitter>(&arg2));
        0x2::table::add<address, 0x1::ascii::String>(0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::identity::module_address_to_identifier_borrow_mut<Twitter>(arg0, &mut v0), v3, v2);
        0xd666d3234eb46551273014f5616ed2575e709a861dd3812613d59104a4cb7344::reclaim::burn_proof<Twitter>(arg2);
    }

    public(friend) fun witness() : Twitter {
        Twitter{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

