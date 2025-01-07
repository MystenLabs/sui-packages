module 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig {
    struct ModifyMultisigRequest has store {
        is_add: bool,
        threshold: u64,
        addresses: vector<address>,
    }

    struct ProposalKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        approved: 0x2::vec_set::VecSet<address>,
        epoch: u64,
    }

    struct Multisig has key {
        id: 0x2::object::UID,
        threshold: u64,
        members: 0x2::vec_set::VecSet<address>,
        proposals: 0x2::vec_map::VecMap<0x1::string::String, Proposal>,
    }

    public fun approve_proposal(arg0: &mut Multisig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_member(arg0, arg2);
        0x2::vec_set::insert<address>(&mut 0x2::vec_map::get_mut<0x1::string::String, Proposal>(&mut arg0.proposals, &arg1).approved, 0x2::tx_context::sender(arg2));
    }

    fun assert_is_member(arg0: &Multisig, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.members, &v0), 0);
    }

    public fun clean_proposals(arg0: &mut Multisig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::size<0x1::string::String, Proposal>(&arg0.proposals);
        while (v0 > 0) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<0x1::string::String, Proposal>(&arg0.proposals, v0 - 1);
            if (0x2::tx_context::epoch(arg1) - v2.epoch >= 7) {
                let v3 = *v1;
                let (_, v5) = 0x2::vec_map::remove<0x1::string::String, Proposal>(&mut arg0.proposals, &v3);
                let Proposal {
                    id       : v6,
                    approved : _,
                    epoch    : _,
                } = v5;
                0x2::object::delete(v6);
            };
            v0 = v0 - 1;
        };
    }

    public fun complete_modify(arg0: &mut Multisig, arg1: ModifyMultisigRequest) {
        let ModifyMultisigRequest {
            is_add    : v0,
            threshold : v1,
            addresses : v2,
        } = arg1;
        let v3 = v2;
        arg0.threshold = v1;
        let v4 = 0x1::vector::length<address>(&v3);
        let v5 = 0;
        if (v4 == 0) {
            return
        };
        if (v0) {
            while (v5 < v4) {
                0x2::vec_set::insert<address>(&mut arg0.members, 0x1::vector::pop_back<address>(&mut v3));
                v5 = v5 + 1;
            };
        } else {
            while (v5 < v4) {
                let v6 = 0x1::vector::pop_back<address>(&mut v3);
                0x2::vec_set::remove<address>(&mut arg0.members, &v6);
                v5 = v5 + 1;
            };
        };
    }

    public fun create_proposal<T0: store>(arg0: &mut Multisig, arg1: 0x1::string::String, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_member(arg0, arg3);
        let v0 = Proposal{
            id       : 0x2::object::new(arg3),
            approved : 0x2::vec_set::empty<address>(),
            epoch    : 0x2::tx_context::epoch(arg3),
        };
        let v1 = ProposalKey{dummy_field: false};
        0x2::dynamic_field::add<ProposalKey, T0>(&mut v0.id, v1, arg2);
        0x2::vec_map::insert<0x1::string::String, Proposal>(&mut arg0.proposals, arg1, v0);
    }

    public fun delete_proposal(arg0: &mut Multisig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_member(arg0, arg2);
        let (_, v1) = 0x2::vec_map::remove<0x1::string::String, Proposal>(&mut arg0.proposals, &arg1);
        let v2 = v1;
        assert!(0x2::vec_set::size<address>(&v2.approved) == 0, 3);
        let Proposal {
            id       : v3,
            approved : _,
            epoch    : _,
        } = v2;
        0x2::object::delete(v3);
    }

    public fun execute_proposal(arg0: &mut Multisig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Proposal {
        assert_is_member(arg0, arg2);
        let (_, v1) = 0x2::vec_map::remove<0x1::string::String, Proposal>(&mut arg0.proposals, &arg1);
        let v2 = v1;
        assert!(0x2::vec_set::size<address>(&v2.approved) >= arg0.threshold, 2);
        v2
    }

    public fun get_request<T0: store>(arg0: Proposal) : T0 {
        let Proposal {
            id       : v0,
            approved : _,
            epoch    : _,
        } = arg0;
        let v3 = v0;
        let v4 = ProposalKey{dummy_field: false};
        0x2::object::delete(v3);
        0x2::dynamic_field::remove<ProposalKey, T0>(&mut v3, v4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Multisig{
            id        : 0x2::object::new(arg0),
            threshold : 1,
            members   : v0,
            proposals : 0x2::vec_map::empty<0x1::string::String, Proposal>(),
        };
        0x2::transfer::share_object<Multisig>(v1);
    }

    public fun propose_modify(arg0: &mut Multisig, arg1: 0x1::string::String, arg2: bool, arg3: u64, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg4)) {
            if (arg2) {
                assert!(!0x2::vec_set::contains<address>(&arg0.members, 0x1::vector::borrow<address>(&arg4, v0)), 5);
            } else {
                assert!(0x2::vec_set::contains<address>(&arg0.members, 0x1::vector::borrow<address>(&arg4, v0)), 4);
            };
            v0 = v0 + 1;
        };
        let v1 = if (arg2) {
            0x1::vector::length<address>(&arg4) + 0x2::vec_set::size<address>(&arg0.members)
        } else {
            0x2::vec_set::size<address>(&arg0.members) - 0x1::vector::length<address>(&arg4)
        };
        assert!(v1 >= arg3, 1);
        let v2 = ModifyMultisigRequest{
            is_add    : arg2,
            threshold : arg3,
            addresses : arg4,
        };
        create_proposal<ModifyMultisigRequest>(arg0, arg1, v2, arg5);
    }

    public fun remove_approval(arg0: &mut Multisig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_member(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::vec_set::remove<address>(&mut 0x2::vec_map::get_mut<0x1::string::String, Proposal>(&mut arg0.proposals, &arg1).approved, &v0);
    }

    public fun start_modify(arg0: Proposal) : ModifyMultisigRequest {
        get_request<ModifyMultisigRequest>(arg0)
    }

    // decompiled from Move bytecode v6
}

