module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal {
    struct Proposal<T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        votes: vector<address>,
        quorum_threshold_bps: u64,
        created_timestamp_ms: u64,
        executed_timestamp_ms: 0x1::option::Option<u64>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        data: T0,
    }

    struct ProposalCreated<phantom T0> has copy, drop {
        proposal_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct VoteCast<phantom T0> has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
    }

    struct VoteRemoved<phantom T0> has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
    }

    struct ProposalDeleted<phantom T0> has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    struct ProposalExecuted<T0> has copy, drop {
        proposal_id: 0x2::object::ID,
        data: T0,
    }

    struct QuorumReached<phantom T0> has copy, drop {
        proposal_id: 0x2::object::ID,
    }

    public(friend) fun delete<T0>(arg0: Proposal<T0>) : T0 {
        let Proposal {
            id                    : v0,
            creator               : _,
            votes                 : _,
            quorum_threshold_bps  : _,
            created_timestamp_ms  : _,
            executed_timestamp_ms : _,
            metadata              : _,
            data                  : v7,
        } = arg0;
        0x2::object::delete(v0);
        v7
    }

    public(friend) fun create<T0: store>(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: T0, arg3: u64, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::member_authorized(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), arg1, arg6), 13835058875620982786);
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0);
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::has_committee(v0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(v0));
        assert!(!v1 || 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::has_member(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::current_committee(arg0), &arg1), 13837029247703515152);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, arg1);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = Proposal<T0>{
            id                    : 0x2::object::new(arg6),
            creator               : arg1,
            votes                 : v2,
            quorum_threshold_bps  : arg3,
            created_timestamp_ms  : v3,
            executed_timestamp_ms : 0x1::option::none<u64>(),
            metadata              : arg4,
            data                  : arg2,
        };
        let v5 = 0x2::object::id<Proposal<T0>>(&v4);
        let v6 = v1 && quorum_reached<T0>(&v4, arg0);
        0x2::object_bag::add<0x2::object::ID, Proposal<T0>>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::active_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::proposals_mut(arg0)), v5, v4);
        let v7 = ProposalCreated<T0>{
            proposal_id  : v5,
            timestamp_ms : v3,
        };
        0x2::event::emit<ProposalCreated<T0>>(v7);
        let v8 = VoteCast<T0>{
            proposal_id : v5,
            voter       : arg1,
        };
        0x2::event::emit<VoteCast<T0>>(v8);
        if (v6) {
            let v9 = QuorumReached<T0>{proposal_id: v5};
            0x2::event::emit<QuorumReached<T0>>(v9);
        };
        v5
    }

    entry fun delete_expired<T0: drop + store>(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : T0 {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(!0x2::object_bag::contains<0x2::object::ID>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::executed(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::proposals(arg0)), arg1), 13836747630992752654);
        let v0 = 0x2::object_bag::remove<0x2::object::ID, Proposal<T0>>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::active_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::proposals_mut(arg0)), arg1);
        assert!(is_expired<T0>(&v0, arg2), 13836184693923971082);
        let v1 = ProposalDeleted<T0>{proposal_id: arg1};
        0x2::event::emit<ProposalDeleted<T0>>(v1);
        delete<T0>(v0)
    }

    public(friend) fun execute<T0: copy + drop + store>(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : T0 {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(!0x2::object_bag::contains<0x2::object::ID>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::executed(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::proposals(arg0)), arg1), 13836747974590136334);
        let v0 = 0x2::object_bag::remove<0x2::object::ID, Proposal<T0>>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::active_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::proposals_mut(arg0)), arg1);
        assert!(!is_expired<T0>(&v0, arg2), 13836466512498196492);
        assert!(quorum_reached<T0>(&v0, arg0), 13835622091862638598);
        v0.executed_timestamp_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        let v1 = v0.data;
        let v2 = 0x2::object::uid_to_inner(&v0.id);
        0x2::object_bag::add<0x2::object::ID, Proposal<T0>>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::executed_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::proposals_mut(arg0)), v2, v0);
        let v3 = ProposalExecuted<T0>{
            proposal_id : v2,
            data        : v1,
        };
        0x2::event::emit<ProposalExecuted<T0>>(v3);
        v1
    }

    public(friend) fun is_expired<T0>(arg0: &Proposal<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.created_timestamp_ms + 604800000
    }

    public(friend) fun quorum_reached<T0>(arg0: &Proposal<T0>, arg1: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi) : bool {
        let v0 = 0;
        let v1 = arg0.votes;
        0x1::vector::reverse<address>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v1);
            v0 = v0 + 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::get_member_weight(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::current_committee(arg1), &v3);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        v0 >= 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::threshold::weight_threshold(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::total_weight(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::current_committee(arg1)), arg0.quorum_threshold_bps)
    }

    entry fun remove_vote<T0: store>(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::member_authorized(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), arg1, arg3), 13835058673757519874);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, Proposal<T0>>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::active_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::proposals_mut(arg0)), arg2);
        let v1 = &v0.votes;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<address>(v1)) {
            if (0x1::vector::borrow<address>(v1, v2) == &arg1) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 8 */
                if (0x1::option::is_some<u64>(&v3)) {
                    0x1::vector::remove<address>(&mut v0.votes, 0x1::option::destroy_some<u64>(v3));
                    let v4 = VoteRemoved<T0>{
                        proposal_id : 0x2::object::uid_to_inner(&v0.id),
                        voter       : arg1,
                    };
                    0x2::event::emit<VoteRemoved<T0>>(v4);
                    return
                } else {
                    0x1::option::destroy_none<u64>(v3);
                    abort 13835903124457848840
                };
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    entry fun vote<T0: store>(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::member_authorized(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), arg1, arg4), 13835058540613533698);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::has_committee(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0))), 13837310357608136722);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::has_member(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::current_committee(arg0), &arg1), 13837028899811164176);
        let v0 = 0x2::object_bag::borrow_mut<0x2::object::ID, Proposal<T0>>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals::active_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::proposals_mut(arg0)), arg2);
        assert!(!0x1::vector::contains<address>(&v0.votes, &arg1), 13835340067129982980);
        assert!(!is_expired<T0>(v0, arg3), 13836465971332317196);
        0x1::vector::push_back<address>(&mut v0.votes, arg1);
        let v1 = VoteCast<T0>{
            proposal_id : arg2,
            voter       : arg1,
        };
        0x2::event::emit<VoteCast<T0>>(v1);
        if (quorum_reached<T0>(v0, arg0)) {
            let v2 = QuorumReached<T0>{proposal_id: arg2};
            0x2::event::emit<QuorumReached<T0>>(v2);
        };
    }

    public(friend) fun votes<T0>(arg0: &Proposal<T0>) : &vector<address> {
        &arg0.votes
    }

    // decompiled from Move bytecode v7
}

