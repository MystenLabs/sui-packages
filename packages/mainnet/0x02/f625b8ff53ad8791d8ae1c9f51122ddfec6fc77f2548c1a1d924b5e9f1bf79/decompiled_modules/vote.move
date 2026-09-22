module 0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::vote {
    struct Proposal<phantom T0> has key {
        id: 0x2::object::UID,
        author: address,
        title: 0x1::string::String,
        body: 0x1::string::String,
        created_ms: u64,
        ends_ms: u64,
        tally: vector<u128>,
        votes: 0x2::table::Table<address, Ballot>,
        voters: u64,
    }

    struct Ballot has drop, store {
        choice: u8,
        weight: u64,
    }

    struct ProposalOpened<phantom T0> has copy, drop {
        proposal_id: 0x2::object::ID,
        author: address,
        title: 0x1::string::String,
        created_ms: u64,
        ends_ms: u64,
        author_locked: u64,
    }

    struct Voted<phantom T0> has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        choice: u8,
        weight: u64,
        tally: vector<u128>,
        voters: u64,
    }

    public fun author<T0>(arg0: &Proposal<T0>) : address {
        arg0.author
    }

    public fun cast<T0>(arg0: &0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config::Config, arg1: &mut Proposal<T0>, arg2: &0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::lock::PopLock<T0>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config::assert_version(arg0);
        assert!(0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::lock::owner<T0>(arg2) == 0x2::tx_context::sender(arg5), 400);
        assert!(arg3 < 3, 406);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.ends_ms, 403);
        let v0 = 0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::lock::locked_amount<T0>(arg2);
        assert!(v0 > 0, 402);
        let v1 = 0x2::tx_context::sender(arg5);
        if (0x2::table::contains<address, Ballot>(&arg1.votes, v1)) {
            let v2 = 0x2::table::borrow<address, Ballot>(&arg1.votes, v1);
            let v3 = v2.weight;
            let v4 = 0x1::vector::borrow_mut<u128>(&mut arg1.tally, (v2.choice as u64));
            *v4 = *v4 - (v3 as u128);
            0x2::table::remove<address, Ballot>(&mut arg1.votes, v1);
        } else {
            arg1.voters = arg1.voters + 1;
        };
        let v5 = Ballot{
            choice : arg3,
            weight : v0,
        };
        0x2::table::add<address, Ballot>(&mut arg1.votes, v1, v5);
        let v6 = 0x1::vector::borrow_mut<u128>(&mut arg1.tally, (arg3 as u64));
        *v6 = *v6 + (v0 as u128);
        let v7 = Voted<T0>{
            proposal_id : 0x2::object::id<Proposal<T0>>(arg1),
            voter       : v1,
            choice      : arg3,
            weight      : v0,
            tally       : arg1.tally,
            voters      : arg1.voters,
        };
        0x2::event::emit<Voted<T0>>(v7);
    }

    public fun clear_votes<T0>(arg0: &0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config::Config, arg1: &mut Proposal<T0>, arg2: vector<address>, arg3: &0x2::clock::Clock) {
        0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config::assert_version(arg0);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.ends_ms, 407);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::table::contains<address, Ballot>(&arg1.votes, v1)) {
                0x2::table::remove<address, Ballot>(&mut arg1.votes, v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun ends_ms<T0>(arg0: &Proposal<T0>) : u64 {
        arg0.ends_ms
    }

    public fun has_voted<T0>(arg0: &Proposal<T0>, arg1: address) : bool {
        0x2::table::contains<address, Ballot>(&arg0.votes, arg1)
    }

    public fun max_body() : u64 {
        4000
    }

    public fun max_title() : u64 {
        120
    }

    public fun open<T0>(arg0: &0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config::Config, arg1: &0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::lock::PopLock<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config::assert_version(arg0);
        assert!(0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::lock::owner<T0>(arg1) == 0x2::tx_context::sender(arg5), 400);
        assert!(0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::lock::locked_amount<T0>(arg1) >= 0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config::min_lock_to_propose(arg0), 401);
        assert!(0x1::string::length(&arg2) > 0 && 0x1::string::length(&arg2) <= 120, 404);
        assert!(0x1::string::length(&arg3) <= 4000, 405);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Proposal<T0>{
            id         : 0x2::object::new(arg5),
            author     : 0x2::tx_context::sender(arg5),
            title      : arg2,
            body       : arg3,
            created_ms : v0,
            ends_ms    : v0 + 0x2f625b8ff53ad8791d8ae1c9f51122ddfec6fc77f2548c1a1d924b5e9f1bf79::config::voting_ms(arg0),
            tally      : vector[0, 0, 0],
            votes      : 0x2::table::new<address, Ballot>(arg5),
            voters     : 0,
        };
        let v2 = ProposalOpened<T0>{
            proposal_id   : 0x2::object::id<Proposal<T0>>(&v1),
            author        : v1.author,
            title         : v1.title,
            created_ms    : v0,
            ends_ms       : v1.ends_ms,
            author_locked : 0xde725106b28fa01baaa64680971b530632c785395b1db0cf3f3e4b0adcb86bb7::lock::locked_amount<T0>(arg1),
        };
        0x2::event::emit<ProposalOpened<T0>>(v2);
        0x2::transfer::share_object<Proposal<T0>>(v1);
    }

    public fun tally<T0>(arg0: &Proposal<T0>) : vector<u128> {
        arg0.tally
    }

    public fun vote_of<T0>(arg0: &Proposal<T0>, arg1: address) : (u8, u64) {
        let v0 = 0x2::table::borrow<address, Ballot>(&arg0.votes, arg1);
        (v0.choice, v0.weight)
    }

    public fun voters<T0>(arg0: &Proposal<T0>) : u64 {
        arg0.voters
    }

    // decompiled from Move bytecode v7
}

