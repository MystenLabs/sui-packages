module 0xd1d82ce6a1f4636a20246f4c7b698b3879d5cc1fba296b6181bf057824664c25::voting_system {
    struct Poll has key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        options: vector<0x1::string::String>,
        votes: vector<VoteEntry>,
        voters: vector<address>,
        is_active: bool,
    }

    struct VotingTicket has store, key {
        id: 0x2::object::UID,
    }

    struct VoteEvent has copy, drop {
        poll_id: 0x2::object::ID,
        voter: address,
        option_index: u8,
    }

    struct VoteEntry has copy, drop, store {
        option_index: u8,
        count: u64,
    }

    public fun close_poll(arg0: &mut Poll) {
        arg0.is_active = false;
    }

    fun contains_voter(arg0: &vector<address>, arg1: &address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun create_options_vector(arg0: vector<vector<u8>>) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_poll(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Poll{
            id        : 0x2::object::new(arg2),
            question  : 0x1::string::utf8(arg0),
            options   : create_options_vector(arg1),
            votes     : 0x1::vector::empty<VoteEntry>(),
            voters    : 0x1::vector::empty<address>(),
            is_active : true,
        };
        0x2::transfer::share_object<Poll>(v0);
    }

    public fun get_vote_count(arg0: &Poll, arg1: u8) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<VoteEntry>(&arg0.votes)) {
            let v1 = *0x1::vector::borrow<VoteEntry>(&arg0.votes, v0);
            if (v1.option_index == arg1) {
                return v1.count
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun has_voted(arg0: &Poll, arg1: address) : bool {
        contains_voter(&arg0.voters, &arg1)
    }

    public fun issue_voting_ticket(arg0: &mut Poll, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        let v0 = VotingTicket{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<VotingTicket>(v0, arg1);
    }

    public fun vote(arg0: &mut Poll, arg1: VotingTicket, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.is_active, 0);
        assert!(!contains_voter(&arg0.voters, &v0), 1);
        assert!(arg2 < (0x1::vector::length<0x1::string::String>(&arg0.options) as u8), 2);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<VoteEntry>(&arg0.votes)) {
            let v3 = 0x1::vector::borrow_mut<VoteEntry>(&mut arg0.votes, v2);
            if (v3.option_index == arg2) {
                v3.count = v3.count + 1;
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (!v1) {
            let v4 = VoteEntry{
                option_index : arg2,
                count        : 1,
            };
            0x1::vector::push_back<VoteEntry>(&mut arg0.votes, v4);
        };
        0x1::vector::push_back<address>(&mut arg0.voters, v0);
        let v5 = VoteEvent{
            poll_id      : 0x2::object::id<Poll>(arg0),
            voter        : v0,
            option_index : arg2,
        };
        0x2::event::emit<VoteEvent>(v5);
        let VotingTicket { id: v6 } = arg1;
        0x2::object::delete(v6);
    }

    // decompiled from Move bytecode v6
}

