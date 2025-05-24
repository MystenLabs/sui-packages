module 0x2110b5c7eac2a11c01e8ad1be8933554671419d09814456d0dfec423df0b6122::dao {
    struct Proposal has store {
        id: u64,
        title: 0x1::string::String,
        description: 0x1::string::String,
        options: vector<0x1::string::String>,
        created_by: address,
        created_at: u64,
        start_time: u64,
        end_time: u64,
        status: u8,
        winning_option: 0x1::option::Option<0x1::string::String>,
        votes: 0x2::vec_map::VecMap<address, u64>,
        vote_points: vector<u64>,
        total_votes: u64,
        total_points: u64,
        token_type: 0x1::string::String,
    }

    struct DAO has key {
        id: 0x2::object::UID,
        proposals: 0x2::table::Table<u64, Proposal>,
        next_proposal_id: u64,
        min_voting_power: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        title: 0x1::string::String,
        created_by: address,
    }

    struct VoteSubmitted has copy, drop {
        proposal_id: u64,
        voter: address,
        option_index: u64,
        voting_power: u64,
    }

    struct ProposalClosed has copy, drop {
        proposal_id: u64,
        winning_option: 0x1::option::Option<0x1::string::String>,
        total_votes: u64,
        total_points: u64,
    }

    public entry fun close_proposal(arg0: &mut DAO, arg1: u64, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposals, arg1);
        assert!(v0.status == 0, 2);
        assert!(0x2::clock::timestamp_ms(arg4) >= v0.end_time, 5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&v0.options)) {
            *0x1::vector::borrow_mut<u64>(&mut v0.vote_points, v1) = 0;
            v1 = v1 + 1;
        };
        v0.total_points = 0;
        let v2 = 0x1::vector::length<address>(&arg2);
        assert!(v2 == 0x1::vector::length<u64>(&arg3), 4);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = 0x1::vector::borrow<address>(&arg2, v3);
            if (0x2::vec_map::contains<address, u64>(&v0.votes, v4)) {
                let v5 = *0x2::vec_map::get<address, u64>(&v0.votes, v4);
                let v6 = *0x1::vector::borrow<u64>(&arg3, v3);
                *0x1::vector::borrow_mut<u64>(&mut v0.vote_points, v5) = *0x1::vector::borrow<u64>(&v0.vote_points, v5) + v6;
                v0.total_points = v0.total_points + v6;
            };
            v3 = v3 + 1;
        };
        let v7 = 0;
        let v8 = v7;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v0.vote_points)) {
            let v10 = *0x1::vector::borrow<u64>(&v0.vote_points, v9);
            if (v10 > v7) {
                v8 = v10;
            };
            v9 = v9 + 1;
        };
        if (v8 > 0) {
            v0.winning_option = 0x1::option::some<0x1::string::String>(*0x1::vector::borrow<0x1::string::String>(&v0.options, 0));
        };
        v0.status = 1;
        let v11 = ProposalClosed{
            proposal_id    : arg1,
            winning_option : v0.winning_option,
            total_votes    : v0.total_votes,
            total_points   : v0.total_points,
        };
        0x2::event::emit<ProposalClosed>(v11);
    }

    public entry fun create_proposal(arg0: &mut DAO, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.next_proposal_id;
        arg0.next_proposal_id = v0 + 1;
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg5 <= v1, 4);
        assert!(arg7 > v1, 4);
        assert!(arg6 < arg7, 4);
        let v2 = Proposal{
            id             : v0,
            title          : 0x1::string::utf8(arg1),
            description    : 0x1::string::utf8(arg2),
            options        : 0x1::vector::empty<0x1::string::String>(),
            created_by     : 0x2::tx_context::sender(arg9),
            created_at     : arg5,
            start_time     : arg6,
            end_time       : arg7,
            status         : 0,
            winning_option : 0x1::option::none<0x1::string::String>(),
            votes          : 0x2::vec_map::empty<address, u64>(),
            vote_points    : 0x1::vector::empty<u64>(),
            total_votes    : 0,
            total_points   : 0,
            token_type     : 0x1::string::utf8(arg4),
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg3)) {
            0x1::vector::push_back<0x1::string::String>(&mut v2.options, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg3, v3)));
            0x1::vector::push_back<u64>(&mut v2.vote_points, 0);
            v3 = v3 + 1;
        };
        0x2::table::add<u64, Proposal>(&mut arg0.proposals, v0, v2);
        let v4 = ProposalCreated{
            proposal_id : v0,
            title       : 0x1::string::utf8(arg1),
            created_by  : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<ProposalCreated>(v4);
    }

    public fun get_proposal(arg0: &DAO, arg1: u64) : &Proposal {
        0x2::table::borrow<u64, Proposal>(&arg0.proposals, arg1)
    }

    public fun get_proposal_count(arg0: &DAO) : u64 {
        arg0.next_proposal_id
    }

    public fun get_voting_power(arg0: &Proposal, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&arg0.vote_points, arg1)
    }

    public fun has_voted(arg0: &Proposal, arg1: address) : bool {
        0x2::vec_map::contains<address, u64>(&arg0.votes, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DAO{
            id               : 0x2::object::new(arg0),
            proposals        : 0x2::table::new<u64, Proposal>(arg0),
            next_proposal_id : 0,
            min_voting_power : 1000000,
        };
        0x2::transfer::share_object<DAO>(v0);
    }

    public entry fun vote(arg0: &mut DAO, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg3 >= arg0.min_voting_power, 0);
        let v1 = 0x2::table::borrow_mut<u64, Proposal>(&mut arg0.proposals, arg1);
        assert!(v1.status == 0, 2);
        assert!(!0x2::vec_map::contains<address, u64>(&v1.votes, &v0), 3);
        assert!(arg2 < 0x1::vector::length<0x1::string::String>(&v1.options), 4);
        0x2::vec_map::insert<address, u64>(&mut v1.votes, v0, arg2);
        *0x1::vector::borrow_mut<u64>(&mut v1.vote_points, arg2) = *0x1::vector::borrow<u64>(&v1.vote_points, arg2) + arg3;
        v1.total_votes = v1.total_votes + 1;
        v1.total_points = v1.total_points + arg3;
        let v2 = VoteSubmitted{
            proposal_id  : arg1,
            voter        : v0,
            option_index : arg2,
            voting_power : arg3,
        };
        0x2::event::emit<VoteSubmitted>(v2);
    }

    // decompiled from Move bytecode v6
}

