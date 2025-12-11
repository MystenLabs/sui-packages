module 0xb::committee {
    struct BlocklistValidatorEvent has copy, drop {
        blocklisted: bool,
        public_keys: vector<vector<u8>>,
    }

    struct BridgeCommittee has store {
        members: 0x2::vec_map::VecMap<vector<u8>, CommitteeMember>,
        member_registrations: 0x2::vec_map::VecMap<address, CommitteeMemberRegistration>,
        last_committee_update_epoch: u64,
    }

    struct CommitteeUpdateEvent has copy, drop {
        members: 0x2::vec_map::VecMap<vector<u8>, CommitteeMember>,
        stake_participation_percentage: u64,
    }

    struct CommitteeMemberUrlUpdateEvent has copy, drop {
        member: vector<u8>,
        new_url: vector<u8>,
    }

    struct CommitteeMember has copy, drop, store {
        sui_address: address,
        bridge_pubkey_bytes: vector<u8>,
        voting_power: u64,
        http_rest_url: vector<u8>,
        blocklisted: bool,
    }

    struct CommitteeMemberRegistration has copy, drop, store {
        sui_address: address,
        bridge_pubkey_bytes: vector<u8>,
        http_rest_url: vector<u8>,
    }

    fun check_uniqueness_bridge_keys(arg0: &BridgeCommittee, arg1: vector<u8>) {
        let v0 = 0x2::vec_map::length<address, CommitteeMemberRegistration>(&arg0.member_registrations);
        let v1 = false;
        while (v0 > 0) {
            v0 = v0 - 1;
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, CommitteeMemberRegistration>(&arg0.member_registrations, v0);
            if (v3.bridge_pubkey_bytes == arg1) {
                assert!(!v1, 8);
                v1 = true;
            };
        };
    }

    public(friend) fun committee_members(arg0: &BridgeCommittee) : &0x2::vec_map::VecMap<vector<u8>, CommitteeMember> {
        &arg0.members
    }

    public(friend) fun create(arg0: &0x2::tx_context::TxContext) : BridgeCommittee {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 3);
        BridgeCommittee{
            members                     : 0x2::vec_map::empty<vector<u8>, CommitteeMember>(),
            member_registrations        : 0x2::vec_map::empty<address, CommitteeMemberRegistration>(),
            last_committee_update_epoch : 0,
        }
    }

    public(friend) fun execute_blocklist(arg0: &mut BridgeCommittee, arg1: 0xb::message::Blocklist) {
        let v0 = 0xb::message::blocklist_type(&arg1) != 1;
        let v1 = 0xb::message::blocklist_validator_addresses(&arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = vector[];
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            let v5 = 0x1::vector::borrow<vector<u8>>(v1, v2);
            let v6 = false;
            while (v3 < 0x2::vec_map::length<vector<u8>, CommitteeMember>(&arg0.members)) {
                let (v7, v8) = 0x2::vec_map::get_entry_by_idx_mut<vector<u8>, CommitteeMember>(&mut arg0.members, v3);
                if (*v5 == 0xb::crypto::ecdsa_pub_key_to_eth_address(v7)) {
                    v8.blocklisted = v0;
                    0x1::vector::push_back<vector<u8>>(&mut v4, *v7);
                    v6 = true;
                    v3 = 0;
                    break
                };
                v3 = v3 + 1;
            };
            assert!(v6, 4);
            v2 = v2 + 1;
        };
        let v9 = BlocklistValidatorEvent{
            blocklisted : v0,
            public_keys : v4,
        };
        0x2::event::emit<BlocklistValidatorEvent>(v9);
    }

    public(friend) fun register(arg0: &mut BridgeCommittee, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::is_empty<vector<u8>, CommitteeMember>(&arg0.members), 7);
        assert!(0x1::vector::length<u8>(&arg2) == 33, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x3::sui_system::active_validator_addresses(arg1);
        assert!(0x1::vector::contains<address>(&v1, &v0), 5);
        let v2 = if (0x2::vec_map::contains<address, CommitteeMemberRegistration>(&arg0.member_registrations, &v0)) {
            let v3 = 0x2::vec_map::get_mut<address, CommitteeMemberRegistration>(&mut arg0.member_registrations, &v0);
            v3.http_rest_url = arg3;
            v3.bridge_pubkey_bytes = arg2;
            *v3
        } else {
            let v4 = CommitteeMemberRegistration{
                sui_address         : v0,
                bridge_pubkey_bytes : arg2,
                http_rest_url       : arg3,
            };
            0x2::vec_map::insert<address, CommitteeMemberRegistration>(&mut arg0.member_registrations, v0, v4);
            v4
        };
        check_uniqueness_bridge_keys(arg0, arg2);
        0x2::event::emit<CommitteeMemberRegistration>(v2);
    }

    public(friend) fun try_create_next_committee(arg0: &mut BridgeCommittee, arg1: 0x2::vec_map::VecMap<address, u64>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<vector<u8>, CommitteeMember>();
        let v2 = 0;
        while (v0 < 0x2::vec_map::length<address, CommitteeMemberRegistration>(&arg0.member_registrations)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx<address, CommitteeMemberRegistration>(&arg0.member_registrations, v0);
            let v5 = 0x2::vec_map::try_get<address, u64>(&arg1, &v4.sui_address);
            if (0x1::option::is_some<u64>(&v5)) {
                let v6 = 0x1::option::destroy_some<u64>(v5);
                v2 = v2 + v6;
                let v7 = CommitteeMember{
                    sui_address         : v4.sui_address,
                    bridge_pubkey_bytes : v4.bridge_pubkey_bytes,
                    voting_power        : (v6 as u64),
                    http_rest_url       : v4.http_rest_url,
                    blocklisted         : false,
                };
                0x2::vec_map::insert<vector<u8>, CommitteeMember>(&mut v1, v4.bridge_pubkey_bytes, v7);
            };
            v0 = v0 + 1;
        };
        if (v2 >= arg2) {
            arg0.member_registrations = 0x2::vec_map::empty<address, CommitteeMemberRegistration>();
            arg0.members = v1;
            arg0.last_committee_update_epoch = 0x2::tx_context::epoch(arg3);
            let v8 = CommitteeUpdateEvent{
                members                        : v1,
                stake_participation_percentage : v2,
            };
            0x2::event::emit<CommitteeUpdateEvent>(v8);
        };
    }

    public(friend) fun update_node_url(arg0: &mut BridgeCommittee, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<vector<u8>, CommitteeMember>(&arg0.members)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<vector<u8>, CommitteeMember>(&mut arg0.members, v0);
            if (v2.sui_address == 0x2::tx_context::sender(arg2)) {
                v2.http_rest_url = arg1;
                let v3 = CommitteeMemberUrlUpdateEvent{
                    member  : v2.bridge_pubkey_bytes,
                    new_url : arg1,
                };
                0x2::event::emit<CommitteeMemberUrlUpdateEvent>(v3);
                return
            };
            v0 = v0 + 1;
        };
        abort 9
    }

    public fun verify_signatures(arg0: &BridgeCommittee, arg1: 0xb::message::BridgeMessage, arg2: vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x2::vec_set::empty<vector<u8>>();
        let v2 = b"SUI_BRIDGE_MESSAGE";
        0x1::vector::append<u8>(&mut v2, 0xb::message::serialize_message(arg1));
        let v3 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v4 = 0x2::ecdsa_k1::secp256k1_ecrecover(0x1::vector::borrow<vector<u8>>(&arg2, v0), &v2, 0);
            assert!(!0x2::vec_set::contains<vector<u8>>(&v1, &v4), 1);
            assert!(0x2::vec_map::contains<vector<u8>, CommitteeMember>(&arg0.members, &v4), 2);
            let v5 = 0x2::vec_map::get<vector<u8>, CommitteeMember>(&arg0.members, &v4);
            if (!v5.blocklisted) {
                v3 = v3 + v5.voting_power;
            };
            0x2::vec_set::insert<vector<u8>>(&mut v1, v4);
            v0 = v0 + 1;
        };
        assert!(v3 >= 0xb::message::required_voting_power(&arg1), 0);
    }

    // decompiled from Move bytecode v6
}

