module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::uopl_multisig {
    struct Multisig has key {
        id: 0x2::object::UID,
        approvers: 0x2::vec_set::VecSet<address>,
        threshold: u64,
        nonce: u64,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        multisig_id: address,
        destination: address,
        proposer: address,
        nonce: u64,
        approvals: u64,
        approved_by: 0x2::vec_set::VecSet<address>,
        executed: bool,
    }

    struct MultisigCreated has copy, drop {
        multisig: address,
        threshold: u64,
        approvers_len: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal: address,
        multisig: address,
        destination: address,
        nonce: u64,
    }

    struct ProposalApproved has copy, drop {
        proposal: address,
        approver: address,
        approvals: u64,
    }

    struct ProposalExecuted has copy, drop {
        proposal: address,
        multisig: address,
        destination: address,
        nonce: u64,
    }

    public fun approve(arg0: &Multisig, arg1: &mut Proposal, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.approvers, &v0), 4);
        assert!(!0x2::vec_set::contains<address>(&arg1.approved_by, &v0), 5);
        0x2::vec_set::insert<address>(&mut arg1.approved_by, v0);
        arg1.approvals = arg1.approvals + 1;
        let v1 = ProposalApproved{
            proposal  : 0x2::object::uid_to_address(&arg1.id),
            approver  : v0,
            approvals : arg1.approvals,
        };
        0x2::event::emit<ProposalApproved>(v1);
    }

    public fun approvers_len(arg0: &Multisig) : u64 {
        0x2::vec_set::length<address>(&arg0.approvers)
    }

    public fun execute<T0: store + key>(arg0: &Multisig, arg1: Proposal, arg2: T0) {
        assert!(!arg1.executed, 7);
        assert!(arg1.approvals >= arg0.threshold, 6);
        let Proposal {
            id          : v0,
            multisig_id : _,
            destination : v2,
            proposer    : _,
            nonce       : v4,
            approvals   : _,
            approved_by : _,
            executed    : _,
        } = arg1;
        0x2::transfer::public_transfer<T0>(arg2, v2);
        0x2::object::delete(v0);
        let v8 = ProposalExecuted{
            proposal    : 0x2::object::uid_to_address(&arg1.id),
            multisig    : 0x2::object::uid_to_address(&arg0.id),
            destination : v2,
            nonce       : v4,
        };
        0x2::event::emit<ProposalExecuted>(v8);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_approver(arg0: &Multisig, arg1: &address) : bool {
        0x2::vec_set::contains<address>(&arg0.approvers, arg1)
    }

    public fun new_multisig(arg0: vector<address>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<address>(&arg0), 1);
        assert!(arg1 > 0, 3);
        assert!(arg1 <= (0x1::vector::length<address>(&arg0) as u64), 2);
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            0x2::vec_set::insert<address>(&mut v0, *0x1::vector::borrow<address>(&arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = Multisig{
            id        : 0x2::object::new(arg2),
            approvers : v0,
            threshold : arg1,
            nonce     : 0,
        };
        let v3 = MultisigCreated{
            multisig      : 0x2::object::uid_to_address(&v2.id),
            threshold     : arg1,
            approvers_len : 0x1::vector::length<address>(&arg0),
        };
        0x2::event::emit<MultisigCreated>(v3);
        0x2::transfer::share_object<Multisig>(v2);
    }

    public fun nonce(arg0: &Multisig) : u64 {
        arg0.nonce
    }

    public fun proposal_approvals(arg0: &Proposal) : u64 {
        arg0.approvals
    }

    public fun proposal_destination(arg0: &Proposal) : address {
        arg0.destination
    }

    public fun proposal_executed(arg0: &Proposal) : bool {
        arg0.executed
    }

    public fun propose(arg0: &mut Multisig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Proposal {
        assert!(arg1 != @0x0, 8);
        let v0 = arg0.nonce;
        arg0.nonce = v0 + 1;
        let v1 = Proposal{
            id          : 0x2::object::new(arg2),
            multisig_id : 0x2::object::uid_to_address(&arg0.id),
            destination : arg1,
            proposer    : 0x2::tx_context::sender(arg2),
            nonce       : v0,
            approvals   : 0,
            approved_by : 0x2::vec_set::empty<address>(),
            executed    : false,
        };
        let v2 = ProposalCreated{
            proposal    : 0x2::object::uid_to_address(&v1.id),
            multisig    : 0x2::object::uid_to_address(&arg0.id),
            destination : arg1,
            nonce       : v0,
        };
        0x2::event::emit<ProposalCreated>(v2);
        v1
    }

    public fun threshold(arg0: &Multisig) : u64 {
        arg0.threshold
    }

    // decompiled from Move bytecode v7
}

