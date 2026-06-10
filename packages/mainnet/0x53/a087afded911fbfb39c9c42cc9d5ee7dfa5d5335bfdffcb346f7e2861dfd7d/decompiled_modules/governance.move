module 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::governance {
    struct Proposal has key {
        id: 0x2::object::UID,
        proposer: address,
        treasury_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        label: 0x1::string::String,
        status: u8,
        votes_for: u64,
        votes_against: u64,
        voters: 0x2::vec_set::VecSet<address>,
        voting_ends_ms: u64,
        timelock_ms: u64,
        created_at_ms: u64,
    }

    struct ProposalOpened has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        treasury_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        voting_ends_ms: u64,
        timelock_ms: u64,
    }

    struct VoteCast has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        approve: bool,
        weight: u64,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        votes_for: u64,
        votes_against: u64,
    }

    struct ProposalRejected has copy, drop {
        proposal_id: 0x2::object::ID,
        votes_for: u64,
        votes_against: u64,
    }

    public fun e_already_resolved() : u64 {
        0
    }

    public fun e_already_voted() : u64 {
        2
    }

    public fun e_no_voting_power() : u64 {
        3
    }

    public fun e_quorum_not_met() : u64 {
        6
    }

    public fun e_timelock_active() : u64 {
        4
    }

    public fun e_treasury_mismatch() : u64 {
        5
    }

    public fun e_voting_closed() : u64 {
        1
    }

    public fun e_zero_amount() : u64 {
        7
    }

    public fun execute(arg0: &mut Proposal, arg1: &mut 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::Treasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 0);
        assert!(0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::Treasury>(arg1) == arg0.treasury_id, 5);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.voting_ends_ms + arg0.timelock_ms, 4);
        assert!(arg0.votes_for + arg0.votes_against >= 1, 6);
        if (arg0.votes_for > arg0.votes_against) {
            0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::pay_from_treasury(arg1, arg0.amount, arg0.recipient, arg3);
            arg0.status = 1;
            let v0 = ProposalExecuted{
                proposal_id   : 0x2::object::id<Proposal>(arg0),
                recipient     : arg0.recipient,
                amount        : arg0.amount,
                votes_for     : arg0.votes_for,
                votes_against : arg0.votes_against,
            };
            0x2::event::emit<ProposalExecuted>(v0);
        } else {
            arg0.status = 2;
            let v1 = ProposalRejected{
                proposal_id   : 0x2::object::id<Proposal>(arg0),
                votes_for     : arg0.votes_for,
                votes_against : arg0.votes_against,
            };
            0x2::event::emit<ProposalRejected>(v1);
        };
    }

    public fun open_proposal(arg0: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::Treasury, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 7);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = Proposal{
            id             : 0x2::object::new(arg7),
            proposer       : 0x2::tx_context::sender(arg7),
            treasury_id    : 0x2::object::id<0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::Treasury>(arg0),
            recipient      : arg1,
            amount         : arg2,
            label          : arg3,
            status         : 0,
            votes_for      : 0,
            votes_against  : 0,
            voters         : 0x2::vec_set::empty<address>(),
            voting_ends_ms : v0 + arg4,
            timelock_ms    : arg5,
            created_at_ms  : v0,
        };
        let v2 = ProposalOpened{
            proposal_id    : 0x2::object::id<Proposal>(&v1),
            proposer       : v1.proposer,
            treasury_id    : v1.treasury_id,
            recipient      : arg1,
            amount         : arg2,
            voting_ends_ms : v1.voting_ends_ms,
            timelock_ms    : arg5,
        };
        0x2::event::emit<ProposalOpened>(v2);
        0x2::transfer::share_object<Proposal>(v1);
    }

    public fun proposal_amount(arg0: &Proposal) : u64 {
        arg0.amount
    }

    public fun proposal_recipient(arg0: &Proposal) : address {
        arg0.recipient
    }

    public fun proposal_status(arg0: &Proposal) : u8 {
        arg0.status
    }

    public fun proposal_treasury(arg0: &Proposal) : 0x2::object::ID {
        arg0.treasury_id
    }

    public fun proposal_votes_against(arg0: &Proposal) : u64 {
        arg0.votes_against
    }

    public fun proposal_votes_for(arg0: &Proposal) : u64 {
        arg0.votes_for
    }

    public fun proposal_voting_ends_ms(arg0: &Proposal) : u64 {
        arg0.voting_ends_ms
    }

    public fun quorum() : u64 {
        1
    }

    public fun status_executed() : u8 {
        1
    }

    public fun status_rejected() : u8 {
        2
    }

    public fun status_voting() : u8 {
        0
    }

    public fun vote(arg0: &mut Proposal, arg1: &0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::BuilderBoard, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 0);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.voting_ends_ms, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_set::contains<address>(&arg0.voters, &v0), 2);
        let v1 = 0x9db741d5dfea02b1aadedaff43e73bde3972adf82beadf7cc6da26f107bfbc54::playground::builder_score(arg1, v0);
        assert!(v1 > 0, 3);
        0x2::vec_set::insert<address>(&mut arg0.voters, v0);
        if (arg2) {
            arg0.votes_for = arg0.votes_for + v1;
        } else {
            arg0.votes_against = arg0.votes_against + v1;
        };
        let v2 = VoteCast{
            proposal_id : 0x2::object::id<Proposal>(arg0),
            voter       : v0,
            approve     : arg2,
            weight      : v1,
        };
        0x2::event::emit<VoteCast>(v2);
    }

    // decompiled from Move bytecode v7
}

