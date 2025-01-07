module 0x41db839a9b62502ddd63f254e7bd23c6c739d4328521083430abd3bbf75cbf87::movernance {
    struct SpaceStore has store, key {
        id: 0x2::object::UID,
        spaces: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct TokenGovSpace<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        metadata: 0x1::string::String,
        admin: address,
        propose_threshold: u64,
        proposals: vector<0x2::object::ID>,
    }

    struct TokenGovProposal<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        space_id: 0x2::object::ID,
        title: 0x1::string::String,
        body: 0x1::string::String,
        creator: address,
        start_time: u64,
        end_time: u64,
        min_vote_threshold: u64,
        yes_votes: u64,
        no_votes: u64,
        yes_voters: 0x2::table::Table<address, u64>,
        no_voters: 0x2::table::Table<address, u64>,
        rewards: vector<0x2::object::ID>,
    }

    struct VoteEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        choice: bool,
        amount: u64,
    }

    struct Vote<phantom T0> has store, key {
        id: 0x2::object::UID,
        voter: address,
        choice: bool,
        proposal_id: 0x2::object::ID,
        token: 0x2::balance::Balance<T0>,
    }

    struct Reward<phantom T0> has store, key {
        id: 0x2::object::UID,
        proposal_id: 0x2::object::ID,
        choice: bool,
        balance: 0x2::balance::Balance<T0>,
        sponsers: 0x2::table::Table<address, u64>,
        claimed_addresses: 0x2::table::Table<address, bool>,
    }

    public entry fun add_reward<T0, T1>(arg0: &TokenGovProposal<T0, T1>, arg1: &mut Reward<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_voting_period_over<T0, T1>(arg0, arg3), 3);
        assert!(arg1.proposal_id == 0x2::object::uid_to_inner(&arg0.id), 5);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0, 9);
        let v1 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, u64>(&arg1.sponsers, v1)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg1.sponsers, v1);
            *v2 = *v2 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg1.sponsers, v1, v0);
        };
        0x2::balance::join<T1>(&mut arg1.balance, 0x2::coin::into_balance<T1>(arg2));
    }

    fun add_vote_in_map(arg0: &mut 0x2::table::Table<address, u64>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(arg0, arg1, arg2);
        };
    }

    public entry fun claim_reward<T0, T1>(arg0: &TokenGovProposal<T0, T1>, arg1: &mut Reward<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_voting_period_over<T0, T1>(arg0, arg2), 4);
        assert!(arg1.proposal_id == 0x2::object::uid_to_inner(&arg0.id), 5);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg1.claimed_addresses, v0), 8);
        let v1 = get_proposal_status<T0, T1>(arg0, arg2);
        let v2 = if (v1 == 1) {
            get_with_default(&arg1.sponsers, v0, 0)
        } else if (v1 == 2 && arg1.choice) {
            get_with_default(&arg0.yes_voters, v0, 0) * 0x2::balance::value<T1>(&arg1.balance) / arg0.yes_votes
        } else {
            assert!(v1 == 3 && !arg1.choice, 6);
            get_with_default(&arg0.no_voters, v0, 0) * 0x2::balance::value<T1>(&arg1.balance) / arg0.no_votes
        };
        assert!(v2 > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance, v2), arg3), v0);
        0x2::table::add<address, bool>(&mut arg1.claimed_addresses, v0, true);
    }

    public entry fun create_proposal<T0, T1>(arg0: &mut TokenGovSpace<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg7) < arg5, 1);
        assert!(arg4 < arg5, 12);
        assert!(0x2::coin::value<T0>(&arg1) >= arg0.propose_threshold, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg8));
        let v0 = TokenGovProposal<T0, T1>{
            id                 : 0x2::object::new(arg8),
            space_id           : 0x2::object::uid_to_inner(&arg0.id),
            title              : 0x1::string::utf8(arg2),
            body               : 0x1::string::utf8(arg3),
            creator            : 0x2::tx_context::sender(arg8),
            start_time         : arg4,
            end_time           : arg5,
            min_vote_threshold : arg6,
            yes_votes          : 0,
            no_votes           : 0,
            yes_voters         : 0x2::table::new<address, u64>(arg8),
            no_voters          : 0x2::table::new<address, u64>(arg8),
            rewards            : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.proposals, 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<TokenGovProposal<T0, T1>>(v0);
    }

    public entry fun create_reward<T0, T1>(arg0: &mut TokenGovProposal<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!is_voting_period_over<T0, T1>(arg0, arg3), 3);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 9);
        let v1 = 0x2::table::new<address, u64>(arg4);
        0x2::table::add<address, u64>(&mut v1, 0x2::tx_context::sender(arg4), v0);
        let v2 = Reward<T1>{
            id                : 0x2::object::new(arg4),
            proposal_id       : 0x2::object::uid_to_inner(&arg0.id),
            choice            : arg2,
            balance           : 0x2::coin::into_balance<T1>(arg1),
            sponsers          : v1,
            claimed_addresses : 0x2::table::new<address, bool>(arg4),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.rewards, 0x2::object::uid_to_inner(&v2.id));
        0x2::transfer::share_object<Reward<T1>>(v2);
    }

    public entry fun create_space<T0, T1>(arg0: &mut SpaceStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.spaces, v0), 11);
        let v1 = TokenGovSpace<T0, T1>{
            id                : 0x2::object::new(arg6),
            name              : v0,
            description       : 0x1::string::utf8(arg2),
            url               : 0x1::string::utf8(arg3),
            metadata          : 0x1::string::utf8(arg4),
            admin             : 0x2::tx_context::sender(arg6),
            propose_threshold : arg5,
            proposals         : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.spaces, v1.name, 0x2::object::uid_to_inner(&v1.id));
        0x2::transfer::share_object<TokenGovSpace<T0, T1>>(v1);
    }

    fun create_space_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpaceStore{
            id     : 0x2::object::new(arg0),
            spaces : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<SpaceStore>(v0);
    }

    public entry fun edit_token_gov_space_meta<T0, T1>(arg0: &mut TokenGovSpace<T0, T1>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 14);
        arg0.name = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
        arg0.url = 0x1::string::utf8(arg3);
        arg0.metadata = 0x1::string::utf8(arg4);
        arg0.propose_threshold = arg5;
    }

    public fun get_proposal_status<T0, T1>(arg0: &TokenGovProposal<T0, T1>, arg1: &0x2::clock::Clock) : u8 {
        if (0x2::clock::timestamp_ms(arg1) < arg0.start_time) {
            return 4
        };
        if (!is_voting_period_over<T0, T1>(arg0, arg1)) {
            return 0
        };
        if (arg0.yes_votes + arg0.no_votes < arg0.min_vote_threshold) {
            return 1
        };
        if (arg0.yes_votes > arg0.no_votes) {
            2
        } else {
            3
        }
    }

    public fun get_spaces(arg0: &SpaceStore) : &0x2::table::Table<0x1::string::String, 0x2::object::ID> {
        &arg0.spaces
    }

    fun get_with_default(arg0: &0x2::table::Table<address, u64>, arg1: address, arg2: u64) : u64 {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            *0x2::table::borrow<address, u64>(arg0, arg1)
        } else {
            arg2
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_space_store(arg0);
    }

    fun is_voting_period_over<T0, T1>(arg0: &TokenGovProposal<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.end_time
    }

    public entry fun vote<T0, T1>(arg0: &mut TokenGovProposal<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.start_time, 13);
        assert!(!is_voting_period_over<T0, T1>(arg0, arg3), 3);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 9);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Vote<T1>{
            id          : 0x2::object::new(arg4),
            voter       : v1,
            choice      : arg2,
            proposal_id : 0x2::object::uid_to_inner(&arg0.id),
            token       : 0x2::coin::into_balance<T1>(arg1),
        };
        if (arg2) {
            arg0.yes_votes = arg0.yes_votes + v0;
            let v3 = &mut arg0.yes_voters;
            add_vote_in_map(v3, v1, v0);
        } else {
            arg0.no_votes = arg0.no_votes + v0;
            let v4 = &mut arg0.no_voters;
            add_vote_in_map(v4, v1, v0);
        };
        0x2::transfer::transfer<Vote<T1>>(v2, v1);
        let v5 = VoteEvent{
            proposal_id : 0x2::object::uid_to_inner(&arg0.id),
            voter       : 0x2::tx_context::sender(arg4),
            choice      : true,
            amount      : v0,
        };
        0x2::event::emit<VoteEvent>(v5);
    }

    public entry fun withdraw_vote_token<T0, T1>(arg0: &TokenGovProposal<T0, T1>, arg1: Vote<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_voting_period_over<T0, T1>(arg0, arg2), 4);
        let Vote {
            id          : v0,
            voter       : v1,
            choice      : _,
            proposal_id : _,
            token       : v4,
        } = arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg3), v1);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

