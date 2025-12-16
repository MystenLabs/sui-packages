module 0xd7dfad9ba3b0ff08744ffbe3dd64df0373a37655eb9e2c920d957c15c0fb55b7::bootcampdao {
    struct Proposal has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
        votes_for: u64,
        votes_against: u64,
        voters: vector<address>,
        is_active: bool,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: 0x2::object::ID,
        title: 0x1::string::String,
        creator: address,
    }

    struct VoteCast has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        voted_for: bool,
    }

    struct ProposalClosed has copy, drop {
        proposal_id: 0x2::object::ID,
        votes_for: u64,
        votes_against: u64,
        passed: bool,
    }

    public entry fun close_proposal(arg0: &mut Proposal, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 2);
        arg0.is_active = false;
        let v0 = ProposalClosed{
            proposal_id   : 0x2::object::id<Proposal>(arg0),
            votes_for     : arg0.votes_for,
            votes_against : arg0.votes_against,
            passed        : arg0.votes_for > arg0.votes_against,
        };
        0x2::event::emit<ProposalClosed>(v0);
    }

    public entry fun create_proposal(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = Proposal{
            id            : v0,
            title         : arg0,
            description   : arg1,
            creator       : v1,
            votes_for     : 0,
            votes_against : 0,
            voters        : 0x1::vector::empty<address>(),
            is_active     : true,
        };
        let v3 = ProposalCreated{
            proposal_id : 0x2::object::uid_to_inner(&v0),
            title       : v2.title,
            creator     : v1,
        };
        0x2::event::emit<ProposalCreated>(v3);
        0x2::transfer::share_object<Proposal>(v2);
    }

    public fun get_voter_count(arg0: &Proposal) : u64 {
        0x1::vector::length<address>(&arg0.voters)
    }

    public fun get_votes(arg0: &Proposal) : (u64, u64) {
        (arg0.votes_for, arg0.votes_against)
    }

    public fun is_active(arg0: &Proposal) : bool {
        arg0.is_active
    }

    public entry fun vote(arg0: &mut Proposal, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.is_active, 0);
        assert!(!0x1::vector::contains<address>(&arg0.voters, &v0), 1);
        if (arg1) {
            arg0.votes_for = arg0.votes_for + 1;
        } else {
            arg0.votes_against = arg0.votes_against + 1;
        };
        0x1::vector::push_back<address>(&mut arg0.voters, v0);
        let v1 = VoteCast{
            proposal_id : 0x2::object::id<Proposal>(arg0),
            voter       : v0,
            voted_for   : arg1,
        };
        0x2::event::emit<VoteCast>(v1);
    }

    // decompiled from Move bytecode v6
}

