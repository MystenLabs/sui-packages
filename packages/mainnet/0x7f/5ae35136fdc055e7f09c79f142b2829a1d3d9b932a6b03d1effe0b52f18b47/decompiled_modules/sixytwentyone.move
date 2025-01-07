module 0x7f5ae35136fdc055e7f09c79f142b2829a1d3d9b932a6b03d1effe0b52f18b47::sixytwentyone {
    struct RoundMetadata has copy, drop, store {
        round: u64,
        draw_time_ms: u64,
        draw_numbers: vector<u8>,
    }

    struct Round has key {
        id: 0x2::object::UID,
        rounds: 0x2::table::Table<u64, RoundMetadata>,
    }

    struct RoundDrawEvent has copy, drop {
        round_id: u64,
        draw_time_ms: u64,
        draw_numbers: vector<u8>,
    }

    entry fun getRound(arg0: &Round, arg1: u64) : (u64, vector<u8>, u64) {
        (0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, arg1).round, 0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, arg1).draw_numbers, 0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, arg1).draw_time_ms)
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

    entry fun latestRound(arg0: &Round) : (u64, vector<u8>, u64) {
        let v0 = 0x2::table::length<u64, RoundMetadata>(&arg0.rounds);
        (0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, v0).round, 0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, v0).draw_numbers, 0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, v0).draw_time_ms)
    }

    entry fun run(arg0: &mut Round, arg1: u8, arg2: u8, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::length<u64, RoundMetadata>(&arg0.rounds);
        let v1 = RoundMetadata{
            round        : v0 + 1,
            draw_time_ms : 0x2::clock::timestamp_ms(arg4),
            draw_numbers : 0x1::vector::empty<u8>(),
        };
        0x2::table::add<u64, RoundMetadata>(&mut arg0.rounds, v0 + 1, v1);
        let v2 = 0x2::random::new_generator(arg3, arg5);
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < arg1 - 1) {
            let v5 = 0x2::random::generate_u8_in_range(&mut v2, 1, arg2);
            while (0x1::vector::contains<u8>(&v3, &v5)) {
                v5 = 0x2::random::generate_u8_in_range(&mut v2, 1, arg2);
            };
            0x1::vector::push_back<u8>(&mut v3, v5);
            v4 = v4 + 1;
        };
        0x2::table::borrow_mut<u64, RoundMetadata>(&mut arg0.rounds, v0).draw_numbers = v3;
        0x2::table::borrow_mut<u64, RoundMetadata>(&mut arg0.rounds, v0).draw_time_ms = 0x2::clock::timestamp_ms(arg4);
        let v6 = RoundDrawEvent{
            round_id     : 0x2::table::borrow<u64, RoundMetadata>(&arg0.rounds, v0).round,
            draw_time_ms : 0x2::clock::timestamp_ms(arg4),
            draw_numbers : v3,
        };
        0x2::event::emit<RoundDrawEvent>(v6);
        0x1::debug::print<Round>(arg0);
    }

    // decompiled from Move bytecode v6
}

