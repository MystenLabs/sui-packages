module 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::committee {
    struct BridgeCommittee has store {
        members: 0x2::vec_map::VecMap<vector<u8>, CommitteeMember>,
        thresholds: 0x2::vec_map::VecMap<u8, u64>,
    }

    struct CommitteeMember has drop, store {
        sui_address: address,
        bridge_pubkey_bytes: vector<u8>,
        voting_power: u64,
        http_rest_url: vector<u8>,
        blocklisted: bool,
    }

    public(friend) fun create(arg0: &0x2::tx_context::TxContext) : BridgeCommittee {
        let v0 = 0x2::vec_map::empty<vector<u8>, CommitteeMember>();
        let v1 = 0x2::hex::decode(b"02321ede33d2c2d7a8a152f275a1484edef2098f034121a602cb7d767d38680aa4");
        let v2 = CommitteeMember{
            sui_address         : 0x2::address::from_u256(1),
            bridge_pubkey_bytes : v1,
            voting_power        : 2500,
            http_rest_url       : b"http://127.0.0.1:9191",
            blocklisted         : false,
        };
        0x2::vec_map::insert<vector<u8>, CommitteeMember>(&mut v0, v1, v2);
        let v3 = 0x2::hex::decode(b"027f1178ff417fc9f5b8290bd8876f0a157a505a6c52db100a8492203ddd1d4279");
        let v4 = CommitteeMember{
            sui_address         : 0x2::address::from_u256(2),
            bridge_pubkey_bytes : v3,
            voting_power        : 2500,
            http_rest_url       : b"http://127.0.0.1:9192",
            blocklisted         : false,
        };
        0x2::vec_map::insert<vector<u8>, CommitteeMember>(&mut v0, v3, v4);
        let v5 = 0x2::hex::decode(b"026f311bcd1c2664c14277c7a80e4857c690626597064f89edc33b8f67b99c6bc0");
        let v6 = CommitteeMember{
            sui_address         : 0x2::address::from_u256(3),
            bridge_pubkey_bytes : v5,
            voting_power        : 2500,
            http_rest_url       : b"http://127.0.0.1:9193",
            blocklisted         : false,
        };
        0x2::vec_map::insert<vector<u8>, CommitteeMember>(&mut v0, v5, v6);
        let v7 = 0x2::hex::decode(b"03a57b85771aedeb6d31c808be9a6e73194e4b70e679608f2bca68bcc684773736");
        let v8 = CommitteeMember{
            sui_address         : 0x2::address::from_u256(4),
            bridge_pubkey_bytes : v7,
            voting_power        : 2500,
            http_rest_url       : b"http://127.0.0.1:9194",
            blocklisted         : false,
        };
        0x2::vec_map::insert<vector<u8>, CommitteeMember>(&mut v0, v7, v8);
        let v9 = 0x2::vec_map::empty<u8, u64>();
        0x2::vec_map::insert<u8, u64>(&mut v9, 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message_types::token(), 3334);
        BridgeCommittee{
            members    : v0,
            thresholds : v9,
        }
    }

    public fun verify_signatures(arg0: &BridgeCommittee, arg1: 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::BridgeMessage, arg2: vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x2::vec_set::empty<vector<u8>>();
        let v2 = 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::message_type(&arg1);
        let v3 = b"SUI_BRIDGE_MESSAGE";
        0x1::vector::append<u8>(&mut v3, 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::message::serialize_message(arg1));
        let v4 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v5 = 0x2::ecdsa_k1::secp256k1_ecrecover(0x1::vector::borrow<vector<u8>>(&arg2, v0), &v3, 0);
            assert!(!0x2::vec_set::contains<vector<u8>>(&v1, &v5), 1);
            assert!(0x2::vec_map::contains<vector<u8>, CommitteeMember>(&arg0.members, &v5), 2);
            let v6 = 0x2::vec_map::get<vector<u8>, CommitteeMember>(&arg0.members, &v5);
            if (!v6.blocklisted) {
                v4 = v4 + v6.voting_power;
            };
            v0 = v0 + 1;
            0x2::vec_set::insert<vector<u8>>(&mut v1, v5);
        };
        assert!(v4 >= *0x2::vec_map::get<u8, u64>(&arg0.thresholds, &v2), 0);
    }

    // decompiled from Move bytecode v7
}

