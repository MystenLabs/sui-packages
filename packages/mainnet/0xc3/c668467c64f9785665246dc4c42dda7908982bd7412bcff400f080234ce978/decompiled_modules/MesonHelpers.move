module 0x371a30d40fcc357a37d412c4750a57303d58c9482e5f51886e46f7bf774028f3::MesonHelpers {
    public(friend) fun amount_from(arg0: vector<u8>) : u64 {
        let v0 = (*0x1::vector::borrow<u8>(&arg0, 1) as u64);
        let v1 = 2;
        while (v1 < 6) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(&arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun assert_amount_within_max(arg0: u64) {
        assert!(arg0 <= 100000000000, 40);
    }

    public(friend) fun check_release_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        is_eth_addr(arg3);
        let v0 = if (in_chain_from(arg0) == x"00c3") {
            let v1 = if (sign_non_typed(arg0)) {
                x"1954524f4e205369676e6564204d6573736167653a0a35330a"
            } else {
                x"1954524f4e205369676e6564204d6573736167653a0a33320a"
            };
            let v0 = v1;
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
            v0
        } else if (sign_non_typed(arg0)) {
            let v0 = x"19457468657265756d205369676e6564204d6573736167653a0a3532";
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
            v0
        } else {
            0x1::vector::append<u8>(&mut arg0, arg1);
            let v0 = if (out_chain_from(arg0) == x"00c3") {
                let v2 = b"bytes32 Sign to release a swap on Mesonaddress Recipient (tron address in hex format)";
                0x2::hash::keccak256(&v2)
            } else {
                let v3 = b"bytes32 Sign to release a swap on Mesonaddress Recipient";
                0x2::hash::keccak256(&v3)
            };
            0x1::vector::append<u8>(&mut v0, 0x2::hash::keccak256(&arg0));
            v0
        };
        assert!(recover_eth_address(v0, arg2) == arg3, 10);
    }

    public(friend) fun check_request_signature(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        is_eth_addr(arg2);
        let v0 = if (in_chain_from(arg0) == x"00c3") {
            let v1 = if (sign_non_typed(arg0)) {
                x"1954524f4e205369676e6564204d6573736167653a0a33330a"
            } else {
                x"1954524f4e205369676e6564204d6573736167653a0a33320a"
            };
            let v0 = v1;
            0x1::vector::append<u8>(&mut v0, arg0);
            v0
        } else if (sign_non_typed(arg0)) {
            let v0 = x"19457468657265756d205369676e6564204d6573736167653a0a3332";
            0x1::vector::append<u8>(&mut v0, arg0);
            v0
        } else {
            let v2 = b"bytes32 Sign to request a swap on Meson";
            let v0 = 0x2::hash::keccak256(&v2);
            0x1::vector::append<u8>(&mut v0, 0x2::hash::keccak256(&arg0));
            v0
        };
        assert!(recover_eth_address(v0, arg1) == arg2, 10);
    }

    public fun eth_address_from_pubkey(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 64, 9);
        let v0 = 0x2::hash::keccak256(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 12;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun eth_address_from_sui_address(arg0: address) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 20) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun expire_ts_from(arg0: vector<u8>) : u64 {
        let v0 = (*0x1::vector::borrow<u8>(&arg0, 21) as u64);
        let v1 = 22;
        while (v1 < 26) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(&arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun fee_for_lp(arg0: vector<u8>) : u64 {
        let v0 = (*0x1::vector::borrow<u8>(&arg0, 16) as u64);
        let v1 = 17;
        while (v1 < 21) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(&arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun fee_waived(arg0: vector<u8>) : bool {
        *0x1::vector::borrow<u8>(&arg0, 6) & 64 == 64
    }

    public(friend) fun for_initial_chain(arg0: vector<u8>) {
        assert!(in_chain_from(arg0) == x"0310", 36);
    }

    public(friend) fun for_target_chain(arg0: vector<u8>) {
        assert!(out_chain_from(arg0) == x"0310", 37);
    }

    public fun get_LOCK_TIME_PERIOD() : u64 {
        1200
    }

    public fun get_MAX_BOND_TIME_PERIOD() : u64 {
        7200
    }

    public fun get_MIN_BOND_TIME_PERIOD() : u64 {
        3600
    }

    public(friend) fun get_swap_id(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, arg1);
        0x2::hash::keccak256(&arg0)
    }

    public(friend) fun in_chain_from(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 29));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 30));
        v0
    }

    public(friend) fun in_coin_index_from(arg0: vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(&arg0, 31)
    }

    public(friend) fun is_encoded_valid(arg0: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 32);
        match_protocol_version(arg0);
    }

    public(friend) fun is_eth_addr(arg0: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) == 20, 8);
    }

    public(friend) fun match_protocol_version(arg0: vector<u8>) {
        assert!(version_from(arg0) == 1, 33);
    }

    public(friend) fun out_chain_from(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 26));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 27));
        v0
    }

    public(friend) fun out_coin_index_from(arg0: vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(&arg0, 28)
    }

    public fun recover_eth_address(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg1, 32);
        *v0 = *v0 & 127;
        0x1::vector::push_back<u8>(&mut arg1, *v0 >> 7);
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &arg0, 0);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        0x1::vector::remove<u8>(&mut v2, 0);
        eth_address_from_pubkey(v2)
    }

    public(friend) fun salt_data_from(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 8));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 9));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 10));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 11));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 12));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 13));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 14));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 15));
        v0
    }

    public(friend) fun salt_from(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 6));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 7));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 8));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 9));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 10));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 11));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 12));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 13));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 14));
        0x1::vector::push_back<u8>(v1, *0x1::vector::borrow<u8>(&arg0, 15));
        v0
    }

    public(friend) fun service_fee(arg0: vector<u8>) : u64 {
        let v0 = amount_from(arg0) * 5 / 10000;
        if (v0 > 500000) {
            v0
        } else {
            500000
        }
    }

    public(friend) fun sign_non_typed(arg0: vector<u8>) : bool {
        *0x1::vector::borrow<u8>(&arg0, 6) & 8 == 8
    }

    public(friend) fun version_from(arg0: vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(&arg0, 0)
    }

    public(friend) fun will_transfer_to_contract(arg0: vector<u8>) : bool {
        *0x1::vector::borrow<u8>(&arg0, 6) & 128 == 0
    }

    // decompiled from Move bytecode v6
}

