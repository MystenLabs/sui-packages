module 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::polls {
    struct Poll has key {
        id: 0x2::object::UID,
        creator: address,
        session_id: 0x1::option::Option<0x2::object::ID>,
        question: 0x1::string::String,
        description_blob_id: u256,
        has_description: bool,
        options: vector<0x1::string::String>,
        voting_mode: u8,
        tallies: vector<u64>,
        voters: 0x2::table::Table<address, vector<u8>>,
        total_votes: u64,
        require_nft_type: 0x1::option::Option<0x1::string::String>,
        require_token_type: 0x1::option::Option<0x1::string::String>,
        require_token_amount: u64,
        closes_at: u64,
        closed: bool,
        is_listed: bool,
        created_at: u64,
    }

    struct Vote has store, key {
        id: 0x2::object::UID,
        poll_id: 0x2::object::ID,
        voter: address,
        choices: vector<u8>,
        voted_at: u64,
    }

    struct PollCreated has copy, drop {
        poll_id: 0x2::object::ID,
        creator: address,
        session_id: 0x1::option::Option<0x2::object::ID>,
        question: 0x1::string::String,
        voting_mode: u8,
        closes_at: u64,
        is_listed: bool,
    }

    struct VoteCast has copy, drop {
        vote_id: 0x2::object::ID,
        poll_id: 0x2::object::ID,
        voter: address,
        choices: vector<u8>,
        voted_at: u64,
    }

    struct PollClosed has copy, drop {
        poll_id: 0x2::object::ID,
        closed_at: u64,
    }

    struct PollListedChanged has copy, drop {
        poll_id: 0x2::object::ID,
        is_listed: bool,
    }

    fun assert_in_session(arg0: &Poll, arg1: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.session_id), 16);
        let v0 = 0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg1);
        assert!(0x1::option::contains<0x2::object::ID>(&arg0.session_id, &v0), 15);
    }

    fun assert_nft_match(arg0: &Poll, arg1: &0x1::string::String) {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.require_nft_type), 10);
        assert!(0x1::option::borrow<0x1::string::String>(&arg0.require_nft_type) == arg1, 11);
    }

    fun assert_options_valid(arg0: &vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<0x1::string::String>(arg0);
        assert!(v0 >= 2, 7);
        assert!(v0 <= 10, 8);
    }

    fun assert_token_match<T0>(arg0: &Poll, arg1: &0x2::coin::Coin<T0>, arg2: &0x1::string::String) {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.require_token_type), 14);
        assert!(0x1::option::borrow<0x1::string::String>(&arg0.require_token_type) == arg2, 12);
        assert!(0x2::coin::value<T0>(arg1) >= arg0.require_token_amount, 13);
    }

    fun assert_voting_mode_valid(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 18);
    }

    fun build_poll(arg0: 0x1::option::Option<0x2::object::ID>, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: u8, arg4: u256, arg5: bool, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::option::Option<0x1::string::String>, arg8: u64, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : Poll {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        Poll{
            id                   : 0x2::object::new(arg12),
            creator              : 0x2::tx_context::sender(arg12),
            session_id           : arg0,
            question             : arg1,
            description_blob_id  : arg4,
            has_description      : arg5,
            options              : arg2,
            voting_mode          : arg3,
            tallies              : v0,
            voters               : 0x2::table::new<address, vector<u8>>(arg12),
            total_votes          : 0,
            require_nft_type     : arg6,
            require_token_type   : arg7,
            require_token_amount : arg8,
            closes_at            : arg9,
            closed               : false,
            is_listed            : arg10,
            created_at           : 0x2::clock::timestamp_ms(arg11),
        }
    }

    fun cast_vote(arg0: &mut Poll, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.closed, 1);
        if (arg0.closes_at > 0) {
            assert!(0x2::clock::timestamp_ms(arg2) < arg0.closes_at, 2);
        };
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, vector<u8>>(&arg0.voters, v0), 0);
        let v1 = 0x1::vector::length<u8>(&arg1);
        assert!(v1 > 0, 5);
        let v2 = 0x1::vector::length<0x1::string::String>(&arg0.options);
        if (arg0.voting_mode == 0) {
            assert!(v1 == 1, 6);
        } else {
            assert!(v1 <= v2, 6);
        };
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x1::vector::borrow<u8>(&arg1, v3);
            assert!((v4 as u64) < v2, 4);
            let v5 = v3 + 1;
            while (v5 < v1) {
                assert!(*0x1::vector::borrow<u8>(&arg1, v5) != v4, 4);
                v5 = v5 + 1;
            };
            let v6 = 0x1::vector::borrow_mut<u64>(&mut arg0.tallies, (v4 as u64));
            *v6 = *v6 + 1;
            v3 = v3 + 1;
        };
        arg0.total_votes = arg0.total_votes + 1;
        let v7 = 0x2::clock::timestamp_ms(arg2);
        let v8 = 0x2::object::id<Poll>(arg0);
        let v9 = Vote{
            id       : 0x2::object::new(arg3),
            poll_id  : v8,
            voter    : v0,
            choices  : arg1,
            voted_at : v7,
        };
        let v10 = VoteCast{
            vote_id  : 0x2::object::id<Vote>(&v9),
            poll_id  : v8,
            voter    : v0,
            choices  : arg1,
            voted_at : v7,
        };
        0x2::event::emit<VoteCast>(v10);
        0x2::table::add<address, vector<u8>>(&mut arg0.voters, v0, arg1);
        0x2::transfer::share_object<Vote>(v9);
    }

    public fun close_poll(arg0: &mut Poll, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 3);
        arg0.closed = true;
        let v0 = PollClosed{
            poll_id   : 0x2::object::id<Poll>(arg0),
            closed_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PollClosed>(v0);
    }

    public fun closes_at(arg0: &Poll) : u64 {
        arg0.closes_at
    }

    public fun create_poll(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: u8, arg3: u256, arg4: bool, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_options_valid(&arg1);
        assert_voting_mode_valid(arg2);
        share_and_emit(build_poll(0x1::option::none<0x2::object::ID>(), arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>(), 0, arg5, arg6, arg7, arg8));
    }

    public fun create_poll_in_session(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: u8, arg4: u256, arg5: bool, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::assert_can_admin(arg0, 0x2::tx_context::sender(arg9));
        assert!(!0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::is_archived(arg0), 17);
        assert_options_valid(&arg2);
        assert_voting_mode_valid(arg3);
        let v0 = build_poll(0x1::option::some<0x2::object::ID>(0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg0)), arg1, arg2, arg3, arg4, arg5, 0x1::option::none<0x1::string::String>(), 0x1::option::none<0x1::string::String>(), 0, arg6, arg7, arg8, arg9);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::attach_poll(arg0, 0x2::object::id<Poll>(&v0));
        share_and_emit(v0);
    }

    public fun create_poll_with_nft<T0: key>(arg0: &T0, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: u8, arg5: u256, arg6: bool, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_options_valid(&arg3);
        assert_voting_mode_valid(arg4);
        share_and_emit(build_poll(0x1::option::none<0x2::object::ID>(), arg2, arg3, arg4, arg5, arg6, 0x1::option::some<0x1::string::String>(arg1), 0x1::option::none<0x1::string::String>(), 0, arg7, arg8, arg9, arg10));
    }

    public fun create_poll_with_nft_in_session<T0: key>(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg1: &T0, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: u8, arg6: u256, arg7: bool, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::assert_can_admin(arg0, 0x2::tx_context::sender(arg11));
        assert!(!0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::is_archived(arg0), 17);
        assert_options_valid(&arg4);
        assert_voting_mode_valid(arg5);
        let v0 = build_poll(0x1::option::some<0x2::object::ID>(0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg0)), arg3, arg4, arg5, arg6, arg7, 0x1::option::some<0x1::string::String>(arg2), 0x1::option::none<0x1::string::String>(), 0, arg8, arg9, arg10, arg11);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::attach_poll(arg0, 0x2::object::id<Poll>(&v0));
        share_and_emit(v0);
    }

    public fun create_poll_with_token<T0>(arg0: &0x2::coin::Coin<T0>, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: u8, arg6: u256, arg7: bool, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_options_valid(&arg4);
        assert_voting_mode_valid(arg5);
        assert!(0x2::coin::value<T0>(arg0) >= arg2, 13);
        share_and_emit(build_poll(0x1::option::none<0x2::object::ID>(), arg3, arg4, arg5, arg6, arg7, 0x1::option::none<0x1::string::String>(), 0x1::option::some<0x1::string::String>(arg1), arg2, arg8, arg9, arg10, arg11));
    }

    public fun create_poll_with_token_in_session<T0>(arg0: &mut 0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg1: &0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: u8, arg7: u256, arg8: bool, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::assert_can_admin(arg0, 0x2::tx_context::sender(arg12));
        assert!(!0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::is_archived(arg0), 17);
        assert_options_valid(&arg5);
        assert_voting_mode_valid(arg6);
        assert!(0x2::coin::value<T0>(arg1) >= arg3, 13);
        let v0 = build_poll(0x1::option::some<0x2::object::ID>(0x2::object::id<0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session>(arg0)), arg4, arg5, arg6, arg7, arg8, 0x1::option::none<0x1::string::String>(), 0x1::option::some<0x1::string::String>(arg2), arg3, arg9, arg10, arg11, arg12);
        0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::attach_poll(arg0, 0x2::object::id<Poll>(&v0));
        share_and_emit(v0);
    }

    public fun created_at(arg0: &Poll) : u64 {
        arg0.created_at
    }

    public fun creator(arg0: &Poll) : address {
        arg0.creator
    }

    public fun description_blob_id(arg0: &Poll) : u256 {
        arg0.description_blob_id
    }

    public fun has_description(arg0: &Poll) : bool {
        arg0.has_description
    }

    public fun has_voted(arg0: &Poll, arg1: address) : bool {
        0x2::table::contains<address, vector<u8>>(&arg0.voters, arg1)
    }

    public fun is_closed(arg0: &Poll) : bool {
        arg0.closed
    }

    public fun is_listed(arg0: &Poll) : bool {
        arg0.is_listed
    }

    public fun mode_multi() : u8 {
        1
    }

    public fun mode_single() : u8 {
        0
    }

    public fun options(arg0: &Poll) : &vector<0x1::string::String> {
        &arg0.options
    }

    public fun question(arg0: &Poll) : &0x1::string::String {
        &arg0.question
    }

    public fun require_nft_type(arg0: &Poll) : &0x1::option::Option<0x1::string::String> {
        &arg0.require_nft_type
    }

    public fun require_token_amount(arg0: &Poll) : u64 {
        arg0.require_token_amount
    }

    public fun require_token_type(arg0: &Poll) : &0x1::option::Option<0x1::string::String> {
        &arg0.require_token_type
    }

    public fun session_id(arg0: &Poll) : &0x1::option::Option<0x2::object::ID> {
        &arg0.session_id
    }

    public fun set_listed(arg0: &mut Poll, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 3);
        arg0.is_listed = arg1;
        let v0 = PollListedChanged{
            poll_id   : 0x2::object::id<Poll>(arg0),
            is_listed : arg1,
        };
        0x2::event::emit<PollListedChanged>(v0);
    }

    fun share_and_emit(arg0: Poll) {
        let v0 = PollCreated{
            poll_id     : 0x2::object::id<Poll>(&arg0),
            creator     : arg0.creator,
            session_id  : arg0.session_id,
            question    : arg0.question,
            voting_mode : arg0.voting_mode,
            closes_at   : arg0.closes_at,
            is_listed   : arg0.is_listed,
        };
        0x2::event::emit<PollCreated>(v0);
        0x2::transfer::share_object<Poll>(arg0);
    }

    public fun tallies(arg0: &Poll) : &vector<u64> {
        &arg0.tallies
    }

    public fun total_votes(arg0: &Poll) : u64 {
        arg0.total_votes
    }

    public fun vote(arg0: &mut Poll, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.require_nft_type), 9);
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.require_token_type), 9);
        cast_vote(arg0, arg1, arg2, arg3);
    }

    public fun vote_choices(arg0: &Vote) : &vector<u8> {
        &arg0.choices
    }

    public fun vote_in_session(arg0: &mut Poll, arg1: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.require_nft_type), 9);
        assert!(0x1::option::is_none<0x1::string::String>(&arg0.require_token_type), 9);
        assert_in_session(arg0, arg1);
        cast_vote(arg0, arg2, arg3, arg4);
    }

    public fun vote_poll_id(arg0: &Vote) : 0x2::object::ID {
        arg0.poll_id
    }

    public fun vote_voted_at(arg0: &Vote) : u64 {
        arg0.voted_at
    }

    public fun vote_voter(arg0: &Vote) : address {
        arg0.voter
    }

    public fun vote_with_nft<T0: key>(arg0: &mut Poll, arg1: &T0, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_nft_match(arg0, &arg2);
        cast_vote(arg0, arg3, arg4, arg5);
    }

    public fun vote_with_nft_in_session<T0: key>(arg0: &mut Poll, arg1: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg2: &T0, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_nft_match(arg0, &arg3);
        assert_in_session(arg0, arg1);
        cast_vote(arg0, arg4, arg5, arg6);
    }

    public fun vote_with_token<T0>(arg0: &mut Poll, arg1: &0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_token_match<T0>(arg0, arg1, &arg2);
        cast_vote(arg0, arg3, arg4, arg5);
    }

    public fun vote_with_token_in_session<T0>(arg0: &mut Poll, arg1: &0x93b8647450e1c4c878cc091df7e285c0ff366cd7a88ed469dac389a87d922582::sessions::Session, arg2: &0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_token_match<T0>(arg0, arg2, &arg3);
        assert_in_session(arg0, arg1);
        cast_vote(arg0, arg4, arg5, arg6);
    }

    public fun voting_mode(arg0: &Poll) : u8 {
        arg0.voting_mode
    }

    // decompiled from Move bytecode v6
}

