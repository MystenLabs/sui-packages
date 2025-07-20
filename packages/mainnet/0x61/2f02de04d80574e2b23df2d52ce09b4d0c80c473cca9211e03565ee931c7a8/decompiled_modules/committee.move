module 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::committee {
    struct BlocklistCommitteeEvent has copy, drop {
        blocklisted: bool,
        public_keys: vector<vector<u8>>,
    }

    struct BridgeCommittee has store {
        members: 0x2::vec_map::VecMap<vector<u8>, CommitteeMember>,
        member_registrations: vector<vector<u8>>,
        last_committee_update_epoch: u64,
    }

    struct CommitteeUpdateEvent has copy, drop {
        members: 0x2::vec_map::VecMap<vector<u8>, CommitteeMember>,
        stake_participation_percentage: u64,
    }

    struct CommitteeMember has copy, drop, store {
        bridge_pubkey_bytes: vector<u8>,
        voting_power: u64,
        blocklisted: bool,
    }

    struct CommitteeMemberRegistrationUpdateEvent has copy, drop {
        registrations: 0x2::vec_map::VecMap<vector<u8>, bool>,
    }

    public(friend) fun committee_members(arg0: &BridgeCommittee) : &0x2::vec_map::VecMap<vector<u8>, CommitteeMember> {
        &arg0.members
    }

    public(friend) fun create() : BridgeCommittee {
        BridgeCommittee{
            members                     : 0x2::vec_map::empty<vector<u8>, CommitteeMember>(),
            member_registrations        : 0x1::vector::empty<vector<u8>>(),
            last_committee_update_epoch : 0,
        }
    }

    public(friend) fun execute_blocklist(arg0: &mut BridgeCommittee, arg1: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::Blocklist) {
        let v0 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::blocklist_type(&arg1) != 1;
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::blocklist_committee_addresses(&arg1);
        let v2 = 0;
        let v3 = 0;
        let v4 = vector[];
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            let v5 = 0x1::vector::borrow<vector<u8>>(v1, v2);
            let v6 = false;
            while (v3 < 0x2::vec_map::size<vector<u8>, CommitteeMember>(&arg0.members)) {
                let (v7, v8) = 0x2::vec_map::get_entry_by_idx_mut<vector<u8>, CommitteeMember>(&mut arg0.members, v3);
                if (*v5 == 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::crypto::ecdsa_pub_key_to_eth_address(v7)) {
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
        let v9 = BlocklistCommitteeEvent{
            blocklisted : v0,
            public_keys : v4,
        };
        0x2::event::emit<BlocklistCommitteeEvent>(v9);
    }

    public fun pubkey_to_address(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x2::ecdsa_k1::decompress_pubkey(&arg0);
        let v1 = b"";
        let v2 = 1;
        while (v2 < 65) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        let v3 = 0x2::hash::keccak256(&v1);
        let v4 = b"";
        let v5 = 12;
        while (v5 < 32) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v3, v5));
            v5 = v5 + 1;
        };
        v4
    }

    public fun recover_signer(arg0: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessage, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg1, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        let v1 = 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::serialize_message(arg0);
        pubkey_to_address(0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &v1, 0))
    }

    public(friend) fun register(arg0: &mut BridgeCommittee, arg1: vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<vector<u8>, bool>();
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = 0x1::vector::borrow<vector<u8>>(&arg1, v0);
            assert!(0x1::vector::length<u8>(v2) == 20, 6);
            if (!0x1::vector::contains<vector<u8>>(&arg0.member_registrations, v2)) {
                0x2::vec_map::insert<vector<u8>, bool>(&mut v1, *v2, true);
                0x1::vector::push_back<vector<u8>>(&mut arg0.member_registrations, *v2);
            };
            v0 = v0 + 1;
        };
        let v3 = CommitteeMemberRegistrationUpdateEvent{registrations: v1};
        0x2::event::emit<CommitteeMemberRegistrationUpdateEvent>(v3);
    }

    public(friend) fun try_create_next_committee(arg0: &mut BridgeCommittee, arg1: 0x2::vec_map::VecMap<vector<u8>, u64>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<vector<u8>, CommitteeMember>();
        let v2 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0.member_registrations)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg0.member_registrations, v0);
            let v4 = 0x2::vec_map::try_get<vector<u8>, u64>(&arg1, v3);
            if (0x1::option::is_some<u64>(&v4)) {
                let v5 = 0x1::option::destroy_some<u64>(v4);
                v2 = v2 + v5;
                let v6 = CommitteeMember{
                    bridge_pubkey_bytes : *v3,
                    voting_power        : (v5 as u64),
                    blocklisted         : false,
                };
                0x2::vec_map::insert<vector<u8>, CommitteeMember>(&mut v1, *v3, v6);
            };
            v0 = v0 + 1;
        };
        if (v2 >= arg2) {
            arg0.member_registrations = 0x1::vector::empty<vector<u8>>();
            arg0.members = v1;
            arg0.last_committee_update_epoch = 0x2::tx_context::epoch(arg3);
            let v7 = CommitteeUpdateEvent{
                members                        : v1,
                stake_participation_percentage : v2,
            };
            0x2::event::emit<CommitteeUpdateEvent>(v7);
        };
    }

    public fun verify_signatures(arg0: &BridgeCommittee, arg1: 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::BridgeMessage, arg2: vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x2::vec_set::empty<vector<u8>>();
        let v2 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v3 = recover_signer(arg1, *0x1::vector::borrow<vector<u8>>(&arg2, v0));
            assert!(!0x2::vec_set::contains<vector<u8>>(&v1, &v3), 1);
            assert!(0x2::vec_map::contains<vector<u8>, CommitteeMember>(&arg0.members, &v3), 2);
            let v4 = 0x2::vec_map::get<vector<u8>, CommitteeMember>(&arg0.members, &v3);
            assert!(!v4.blocklisted, 3);
            v2 = v2 + v4.voting_power;
            0x2::vec_set::insert<vector<u8>>(&mut v1, v3);
            v0 = v0 + 1;
        };
        assert!(v2 >= 0x612f02de04d80574e2b23df2d52ce09b4d0c80c473cca9211e03565ee931c7a8::message::required_voting_power(&arg1), 0);
    }

    // decompiled from Move bytecode v6
}

