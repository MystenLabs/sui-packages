module 0x40ddb88cb179a9c2390d19a94b4427ac463e8fa9756539d07b7f56e8f9bcd875::governance {
    struct Proposal has store, key {
        id: 0x2::object::UID,
        topic: 0x1::string::String,
        choices: vector<0x1::string::String>,
        start_time: u64,
        end_time: u64,
        snapshot_timestamp: u64,
        to_pass: 0x1::string::String,
        quorum: 0x1::string::String,
        first_vote_counts: bool,
        votes: 0x2::table::Table<address, u8>,
    }

    struct ProposalCreatedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        topic: 0x1::string::String,
        choices: vector<0x1::string::String>,
        start_time: u64,
        end_time: u64,
        snapshot_timestamp: u64,
        first_vote_counts: bool,
    }

    struct VoteCastEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        previous_vote_choice: 0x1::option::Option<u8>,
        vote_choice: u8,
    }

    fun check_eligibility_to_create_proposal(arg0: &0x2::tx_context::TxContext) {
        let v0 = vector[@0x1a1cfbf5f6f22510818808268237413d458bbe3ade5281c585d78d12583bea43];
        let v1 = 0x2::tx_context::sender(arg0);
        assert!(0x1::vector::contains<address>(&v0, &v1), 4);
    }

    public fun create_proposal(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_eligibility_to_create_proposal(arg7);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg2, 5);
        assert!(arg2 < arg3, 6);
        assert!(0x1::vector::length<0x1::string::String>(&arg1) > 1, 7);
        let v0 = Proposal{
            id                 : 0x2::object::new(arg7),
            topic              : arg0,
            choices            : arg1,
            start_time         : arg2,
            end_time           : arg3,
            snapshot_timestamp : arg4,
            to_pass            : 0x1::string::utf8(b"majority"),
            quorum             : 0x1::string::utf8(b"50%"),
            first_vote_counts  : arg5,
            votes              : 0x2::table::new<address, u8>(arg7),
        };
        let v1 = ProposalCreatedEvent{
            proposal_id        : 0x2::object::uid_to_inner(&v0.id),
            topic              : arg0,
            choices            : arg1,
            start_time         : arg2,
            end_time           : arg3,
            snapshot_timestamp : arg4,
            first_vote_counts  : arg5,
        };
        0x2::event::emit<ProposalCreatedEvent>(v1);
        0x2::transfer::public_share_object<Proposal>(v0);
    }

    public(friend) fun get_vote(arg0: &Proposal, arg1: address) : u8 {
        assert!(0x2::table::contains<address, u8>(&arg0.votes, arg1), 0);
        *0x2::table::borrow<address, u8>(&arg0.votes, arg1)
    }

    public entry fun vote(arg0: &mut Proposal, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!((arg1 as u64) < 0x1::vector::length<0x1::string::String>(&arg0.choices), 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time, 2);
        assert!(v1 <= arg0.end_time, 3);
        let v2 = if (arg0.first_vote_counts) {
            assert!(!0x2::table::contains<address, u8>(&arg0.votes, v0), 8);
            0x2::table::add<address, u8>(&mut arg0.votes, v0, arg1);
            0x1::option::none<u8>()
        } else if (0x2::table::contains<address, u8>(&arg0.votes, v0)) {
            let v3 = 0x2::table::borrow_mut<address, u8>(&mut arg0.votes, v0);
            *v3 = arg1;
            0x1::option::some<u8>(*v3)
        } else {
            0x2::table::add<address, u8>(&mut arg0.votes, v0, arg1);
            0x1::option::none<u8>()
        };
        let v4 = VoteCastEvent{
            proposal_id          : 0x2::object::uid_to_inner(&arg0.id),
            voter                : v0,
            previous_vote_choice : v2,
            vote_choice          : arg1,
        };
        0x2::event::emit<VoteCastEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

