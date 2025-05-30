module 0x95b4061877d9544a12d7eddb41eb6571fc3c7f19678b1ec58eb775774a141145::five_minutes {
    struct RoundMetadata has copy, drop, store {
        round: u64,
        status: u8,
        start_time_ms: u64,
        end_time_ms: u64,
        seed: vector<vector<u8>>,
        public_key: vector<u8>,
        proof: vector<vector<u8>>,
        outputs: vector<vector<u8>>,
    }

    struct Round has key {
        id: 0x2::object::UID,
        rounds: 0x2::table::Table<u64, RoundMetadata>,
    }

    struct VerifiedEvent has copy, drop {
        is_verified: vector<bool>,
    }

    struct RoundStartEvent has copy, drop {
        round_id: u64,
        status: u8,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct RoundCloseEvent has copy, drop {
        round_id: u64,
        status: u8,
        timestamp_ms: u64,
        proof: vector<vector<u8>>,
        seed: vector<vector<u8>>,
        public_key: vector<u8>,
        outputs: vector<vector<u8>>,
    }

    entry fun close(arg0: &mut Round, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::table::length<u64, RoundMetadata>(&arg0.rounds);
        assert!(0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, v0).status != 1, 1);
        assert!(0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, v0).end_time_ms < 0x2::clock::timestamp_ms(arg5), 0);
        0x2::table::borrow_mut<u64, RoundMetadata>(&mut arg0.rounds, v0).status = 1;
        0x2::table::borrow_mut<u64, RoundMetadata>(&mut arg0.rounds, v0).seed = arg1;
        0x2::table::borrow_mut<u64, RoundMetadata>(&mut arg0.rounds, v0).proof = arg2;
        0x2::table::borrow_mut<u64, RoundMetadata>(&mut arg0.rounds, v0).public_key = arg3;
        0x2::table::borrow_mut<u64, RoundMetadata>(&mut arg0.rounds, v0).outputs = arg4;
        let v1 = RoundCloseEvent{
            round_id     : 0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, v0).round,
            status       : 1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg5),
            proof        : arg2,
            seed         : arg1,
            public_key   : arg3,
            outputs      : arg4,
        };
        0x2::event::emit<RoundCloseEvent>(v1);
        0x1::debug::print<Round>(arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Round{
            id     : 0x2::object::new(arg0),
            rounds : 0x2::table::new<u64, RoundMetadata>(arg0),
        };
        0x1::debug::print<Round>(&v0);
        0x2::transfer::transfer<Round>(v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::string::utf8(b"successfully initated");
        0x1::debug::print<0x1::string::String>(&v1);
    }

    entry fun start(arg0: &mut Round, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::table::length<u64, RoundMetadata>(&arg0.rounds);
        if (v0 > 0) {
            assert!(0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, v0).status == 1, 0);
        };
        let v1 = RoundMetadata{
            round         : v0 + 1,
            status        : 0,
            start_time_ms : 0x2::clock::timestamp_ms(arg2),
            end_time_ms   : 0x2::clock::timestamp_ms(arg2) + arg1,
            seed          : 0x1::vector::empty<vector<u8>>(),
            public_key    : 0x1::vector::empty<u8>(),
            proof         : 0x1::vector::empty<vector<u8>>(),
            outputs       : 0x1::vector::empty<vector<u8>>(),
        };
        0x2::table::add<u64, RoundMetadata>(&mut arg0.rounds, v0 + 1, v1);
        let v2 = RoundStartEvent{
            round_id      : v0 + 1,
            status        : 0,
            start_time_ms : 0x2::clock::timestamp_ms(arg2),
            end_time_ms   : 0x2::clock::timestamp_ms(arg2) + arg1,
        };
        0x2::event::emit<RoundStartEvent>(v2);
        0x1::debug::print<Round>(arg0);
        0x1::debug::print_stack_trace();
    }

    entry fun verify_ecvrf_output(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>, arg2: vector<u8>, arg3: vector<vector<u8>>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<bool>();
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0)) {
            0x1::vector::push_back<bool>(&mut v1, 0x2::ecvrf::ecvrf_verify(0x1::vector::borrow<vector<u8>>(&arg0, v0), 0x1::vector::borrow<vector<u8>>(&arg1, v0), &arg2, 0x1::vector::borrow<vector<u8>>(&arg3, v0)));
            v0 = v0 + 1;
        };
        let v2 = VerifiedEvent{is_verified: v1};
        0x2::event::emit<VerifiedEvent>(v2);
        0x1::debug::print<vector<bool>>(&v1);
    }

    // decompiled from Move bytecode v6
}

