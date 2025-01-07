module 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig {
    struct MultiSignatureSetting has store, key {
        id: 0x2::object::UID,
        participants_remove: vector<address>,
        participants_by_weight: 0x2::vec_map::VecMap<address, u64>,
        threshold: u64,
    }

    struct ProposalCreatedEvent has copy, drop {
        id: u256,
        for: 0x2::object::ID,
        type: u64,
        description: vector<u8>,
        creator: address,
    }

    struct ProposalVotedEvent has copy, drop {
        id: u256,
        for: 0x2::object::ID,
        type: u64,
        voter: address,
    }

    struct ProposalExecutedEvent has copy, drop {
        id: u256,
        for: 0x2::object::ID,
        type: u64,
        executor: address,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        pid: u256,
        for: 0x2::object::ID,
        description: vector<u8>,
        type: u64,
        value: 0x2::object_bag::ObjectBag,
        approved_weight: u64,
        reject_weight: u64,
        participants_voted: 0x2::vec_map::VecMap<address, bool>,
        creator: address,
    }

    struct MultiSignature has store, key {
        id: 0x2::object::UID,
        participants_by_weight: 0x2::vec_map::VecMap<address, u64>,
        threshold: u64,
        proposal_index: u256,
        pending_proposals: 0x2::vec_map::VecMap<u256, Proposal>,
        pending_proposal_ids: vector<u256>,
    }

    public fun borrow_proposal_request<T0: store + key>(arg0: &MultiSignature, arg1: &u256, arg2: &0x2::tx_context::TxContext) : &T0 {
        onlyParticipant(arg0, arg2);
        onlyPendingProposal(arg0, *arg1);
        onlyValidProposalFor(arg0, *arg1);
        onlyVoted(arg0, *arg1);
        borrow_request<T0>(0x2::vec_map::get<u256, Proposal>(&arg0.pending_proposals, arg1))
    }

    fun borrow_request<T0: store + key>(arg0: &Proposal) : &T0 {
        0x2::object_bag::borrow<u256, T0>(&arg0.value, 0)
    }

    public fun create_multisig(arg0: &mut 0x2::tx_context::TxContext) : MultiSignature {
        let v0 = 0x2::vec_map::empty<address, u64>();
        0x2::vec_map::insert<address, u64>(&mut v0, 0x2::tx_context::sender(arg0), 1);
        MultiSignature{
            id                     : 0x2::object::new(arg0),
            participants_by_weight : v0,
            threshold              : 1,
            proposal_index         : 0,
            pending_proposals      : 0x2::vec_map::empty<u256, Proposal>(),
            pending_proposal_ids   : 0x1::vector::empty<u256>(),
        }
    }

    public entry fun create_multisig_setting_proposal(arg0: &mut MultiSignature, arg1: vector<address>, arg2: vector<u64>, arg3: vector<address>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        onlyParticipant(arg0, arg5);
        let v0 = 0x1::vector::length<address>(&mut arg1);
        assert!(v0 == 0x1::vector::length<u64>(&mut arg2), 3);
        assert!(v0 > 0, 3);
        let v1 = &arg0.participants_by_weight;
        let v2 = 0x2::vec_map::empty<address, u64>();
        let v3 = &mut v2;
        let v4 = 0x2::vec_map::keys<address, u64>(v1);
        let v5 = &mut v4;
        while (0x1::vector::length<address>(v5) > 0) {
            let v6 = 0x1::vector::pop_back<address>(v5);
            0x2::vec_map::insert<address, u64>(v3, v6, *0x2::vec_map::get<address, u64>(v1, &v6));
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&arg3)) {
            let v8 = 0x1::vector::borrow<address>(&arg3, v7);
            assert!(0x2::vec_map::contains<address, u64>(v3, v8), 3);
            let (_, _) = 0x2::vec_map::remove<address, u64>(v3, v8);
            v7 = v7 + 1;
        };
        let v11 = 0;
        let v12 = 0x2::vec_map::empty<address, u64>();
        while (v11 < 0x1::vector::length<address>(&arg1)) {
            let v13 = 0x1::vector::borrow<address>(&arg1, v11);
            let v14 = 0x1::vector::borrow<u64>(&arg2, v11);
            assert!(*v14 > 0, 3);
            if (0x2::vec_map::contains<address, u64>(v3, v13)) {
                let (_, _) = 0x2::vec_map::remove<address, u64>(v3, v13);
            };
            0x2::vec_map::insert<address, u64>(v3, *v13, *v14);
            0x2::vec_map::insert<address, u64>(&mut v12, *v13, *v14);
            v11 = v11 + 1;
        };
        let v17 = 0;
        let v18 = 0;
        let v19 = 0x2::vec_map::keys<address, u64>(v3);
        let v20 = &mut v19;
        while (0x1::vector::length<address>(v20) > 0) {
            let v21 = 0x1::vector::pop_back<address>(v20);
            let v22 = 0x2::vec_map::get<address, u64>(v3, &v21);
            if (v18 == 0) {
                v18 = *v22;
            };
            if (*v22 < v18) {
                v18 = *v22;
            };
            v17 = v17 + *v22;
        };
        assert!(v17 > 0, 3);
        assert!(arg4 >= v18, 1);
        assert!(arg4 <= v17, 1);
        let v23 = MultiSignatureSetting{
            id                     : 0x2::object::new(arg5),
            participants_remove    : arg3,
            participants_by_weight : v12,
            threshold              : arg4,
        };
        let v24 = 0x2::address::to_string(0x2::object::id_address<MultiSignatureSetting>(&v23));
        create_proposal<MultiSignatureSetting>(arg0, *0x1::string::bytes(&v24), 0, v23, arg5);
    }

    public fun create_proposal<T0: store + key>(arg0: &mut MultiSignature, arg1: vector<u8>, arg2: u64, arg3: T0, arg4: &mut 0x2::tx_context::TxContext) {
        onlyParticipant(arg0, arg4);
        let v0 = &arg0.pending_proposals;
        let v1 = 0x2::vec_map::keys<u256, Proposal>(v0);
        let v2 = &mut v1;
        while (0x1::vector::length<u256>(v2) > 0) {
            let v3 = 0x1::vector::pop_back<u256>(v2);
            assert!(0x2::vec_map::get<u256, Proposal>(v0, &v3).type != arg2, 3);
        };
        let v4 = 0x2::object_bag::new(arg4);
        0x2::object_bag::add<u256, T0>(&mut v4, 0, arg3);
        let v5 = arg0.proposal_index;
        let v6 = 0x2::object::uid_as_inner(&arg0.id);
        let v7 = Proposal{
            id                 : 0x2::object::new(arg4),
            pid                : v5,
            for                : *v6,
            description        : arg1,
            type               : arg2,
            value              : v4,
            approved_weight    : 0,
            reject_weight      : 0,
            participants_voted : 0x2::vec_map::empty<address, bool>(),
            creator            : 0x2::tx_context::sender(arg4),
        };
        0x2::vec_map::insert<u256, Proposal>(&mut arg0.pending_proposals, v5, v7);
        0x1::vector::push_back<u256>(&mut arg0.pending_proposal_ids, v5);
        arg0.proposal_index = v5 + 1;
        let v8 = ProposalCreatedEvent{
            id          : v5,
            for         : *v6,
            type        : arg2,
            description : arg1,
            creator     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ProposalCreatedEvent>(v8);
    }

    public fun extract_proposal_request<T0: store + key>(arg0: &mut MultiSignature, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        onlyParticipant(arg0, arg2);
        onlyPendingProposal(arg0, arg1);
        onlyValidProposalFor(arg0, arg1);
        onlyVoted(arg0, arg1);
        let v0 = 0x2::vec_map::get_mut<u256, Proposal>(&mut arg0.pending_proposals, &arg1);
        extract_request<T0>(v0)
    }

    fun extract_request<T0: store + key>(arg0: &mut Proposal) : T0 {
        assert!(!0x2::object_bag::is_empty(&mut arg0.value), 3);
        0x2::object_bag::remove<u256, T0>(&mut arg0.value, 0)
    }

    public fun get_participants(arg0: &MultiSignature) : vector<address> {
        0x2::vec_map::keys<address, u64>(&arg0.participants_by_weight)
    }

    public fun get_participants_by_weight(arg0: &MultiSignature) : &0x2::vec_map::VecMap<address, u64> {
        &arg0.participants_by_weight
    }

    fun inner_mark_proposal_complete(arg0: &mut MultiSignature, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0x2::vec_map::remove<u256, Proposal>(&mut arg0.pending_proposals, &arg1);
        let v2 = v1;
        let v3 = &mut arg0.pending_proposal_ids;
        let (v4, v5) = 0x1::vector::index_of<u256>(v3, &arg1);
        if (v4) {
            0x1::vector::remove<u256>(v3, v5);
        };
        0x2::transfer::freeze_object<Proposal>(v2);
        let v6 = ProposalExecutedEvent{
            id       : arg1,
            for      : *0x2::object::uid_as_inner(&arg0.id),
            type     : v2.type,
            executor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProposalExecutedEvent>(v6);
    }

    public fun is_participant(arg0: &MultiSignature, arg1: address) : bool {
        0x2::vec_map::contains<address, u64>(&arg0.participants_by_weight, &arg1)
    }

    public fun is_proposal_approved(arg0: &MultiSignature, arg1: u256) : (bool, u64) {
        onlyPendingProposal(arg0, arg1);
        onlyValidProposalFor(arg0, arg1);
        let v0 = 0x2::vec_map::get<u256, Proposal>(&arg0.pending_proposals, &arg1);
        (v0.approved_weight >= arg0.threshold, v0.approved_weight)
    }

    public fun is_proposal_rejected(arg0: &MultiSignature, arg1: u256) : (bool, u64) {
        onlyPendingProposal(arg0, arg1);
        onlyValidProposalFor(arg0, arg1);
        let v0 = 0x2::vec_map::get<u256, Proposal>(&arg0.pending_proposals, &arg1);
        (v0.reject_weight >= arg0.threshold, v0.reject_weight)
    }

    public entry fun mark_proposal_complete(arg0: &mut MultiSignature, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        onlyParticipant(arg0, arg2);
        onlyPendingProposal(arg0, arg1);
        onlyValidProposalFor(arg0, arg1);
        onlyVoted(arg0, arg1);
        inner_mark_proposal_complete(arg0, arg1, arg2);
    }

    public entry fun multisig_setting_execute(arg0: &mut MultiSignature, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        onlyParticipant(arg0, arg2);
        onlyPendingProposal(arg0, arg1);
        onlyValidProposalFor(arg0, arg1);
        onlyVoted(arg0, arg1);
        let v0 = 0x2::vec_map::get<u256, Proposal>(&arg0.pending_proposals, &arg1);
        let v1 = borrow_request<MultiSignatureSetting>(v0);
        let v2 = v0.approved_weight;
        let v3 = v0.reject_weight;
        assert!(v2 >= arg0.threshold || v3 >= arg0.threshold, 2);
        if (v2 >= arg0.threshold && v2 > v3) {
            let v4 = 0;
            let v5 = &mut arg0.participants_by_weight;
            let v6 = &v1.participants_by_weight;
            while (v4 < 0x1::vector::length<address>(&v1.participants_remove) && 0x1::vector::length<address>(&v1.participants_remove) > 0) {
                let (_, _) = 0x2::vec_map::remove<address, u64>(v5, 0x1::vector::borrow<address>(&v1.participants_remove, v4));
                v4 = v4 + 1;
            };
            let v9 = 0x2::vec_map::keys<address, u64>(v6);
            let v10 = &mut v9;
            while (0x1::vector::length<address>(v10) > 0) {
                let v11 = 0x1::vector::pop_back<address>(v10);
                let v12 = 0x2::vec_map::get<address, u64>(v6, &v11);
                assert!(*v12 > 0, 3);
                if (0x2::vec_map::contains<address, u64>(v5, &v11)) {
                    let (_, _) = 0x2::vec_map::remove<address, u64>(v5, &v11);
                };
                0x2::vec_map::insert<address, u64>(v5, v11, *v12);
            };
            v9 = 0x2::vec_map::keys<address, u64>(v5);
            let v15 = &mut v9;
            let v16 = 0;
            let v17 = 0;
            while (0x1::vector::length<address>(v15) > 0) {
                let v18 = 0x1::vector::pop_back<address>(v15);
                let v19 = 0x2::vec_map::get<address, u64>(v5, &v18);
                if (v17 == 0) {
                    v17 = *v19;
                };
                if (*v19 <= v17) {
                    v17 = *v19;
                };
                assert!(*v19 > 0, 3);
                v16 = v16 + *v19;
            };
            assert!(v1.threshold <= v16, 3);
            assert!(v1.threshold >= v17, 3);
            arg0.threshold = v1.threshold;
        };
        inner_mark_proposal_complete(arg0, arg1, arg2);
    }

    fun onlyNotVoted(arg0: &MultiSignature, arg1: u256, arg2: address) {
        assert!(!0x2::vec_map::contains<address, bool>(&0x2::vec_map::get<u256, Proposal>(&arg0.pending_proposals, &arg1).participants_voted, &arg2), 5);
    }

    fun onlyParticipant(arg0: &MultiSignature, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_map::contains<address, u64>(&arg0.participants_by_weight, &v0), 4);
        let v1 = 0x2::tx_context::sender(arg1);
        assert!(*0x2::vec_map::get<address, u64>(&arg0.participants_by_weight, &v1) > 0, 4);
    }

    fun onlyPendingProposal(arg0: &MultiSignature, arg1: u256) {
        assert!(0x2::vec_map::contains<u256, Proposal>(&arg0.pending_proposals, &arg1), 3);
    }

    fun onlyValidProposalFor(arg0: &MultiSignature, arg1: u256) {
        assert!(0x2::vec_map::get<u256, Proposal>(&arg0.pending_proposals, &arg1).for == 0x2::object::uid_to_inner(&arg0.id), 3);
    }

    fun onlyVoted(arg0: &MultiSignature, arg1: u256) {
        let (v0, _) = is_proposal_approved(arg0, arg1);
        let (v2, _) = is_proposal_rejected(arg0, arg1);
        assert!(v0 || v2, 6);
    }

    public fun pending_proposal_description(arg0: &MultiSignature, arg1: u256) : vector<u8> {
        0x2::vec_map::get<u256, Proposal>(&arg0.pending_proposals, &arg1).description
    }

    public fun pending_proposal_type(arg0: &MultiSignature, arg1: u256) : u64 {
        0x2::vec_map::get<u256, Proposal>(&arg0.pending_proposals, &arg1).type
    }

    public fun pending_proposals(arg0: &MultiSignature, arg1: &0x2::tx_context::TxContext) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        let v2 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_map::contains<address, u64>(&arg0.participants_by_weight, &v2)) {
            return v0
        };
        let v3 = &arg0.pending_proposals;
        let v4 = &arg0.pending_proposal_ids;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u256>(v4)) {
            0x1::vector::push_back<u256>(v1, 0x2::vec_map::get<u256, Proposal>(v3, 0x1::vector::borrow<u256>(v4, v5)).pid);
            v5 = v5 + 1;
        };
        v0
    }

    public entry fun vote(arg0: &mut MultiSignature, arg1: u256, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        onlyParticipant(arg0, arg3);
        onlyPendingProposal(arg0, arg1);
        onlyValidProposalFor(arg0, arg1);
        onlyNotVoted(arg0, arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x2::vec_map::get_mut<u256, Proposal>(&mut arg0.pending_proposals, &arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        if (arg2) {
            v0.approved_weight = v0.approved_weight + *0x2::vec_map::get<address, u64>(&arg0.participants_by_weight, &v1);
        } else {
            v0.reject_weight = v0.reject_weight + *0x2::vec_map::get<address, u64>(&arg0.participants_by_weight, &v1);
        };
        0x2::vec_map::insert<address, bool>(&mut v0.participants_voted, v1, true);
        let v2 = ProposalVotedEvent{
            id    : arg1,
            for   : *0x2::object::uid_as_inner(&arg0.id),
            type  : v0.type,
            voter : v1,
        };
        0x2::event::emit<ProposalVotedEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

