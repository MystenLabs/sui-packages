module 0xfbee03e1b23a1aeac2db56848787d5e0b539b63932607c74df98d0d9b82f6ba7::clock_game {
    struct ClockGame has store, key {
        id: 0x2::object::UID,
        end_time: u64,
    }

    struct ClockEvent has copy, drop {
        result: u64,
    }

    public fun create_clock_game(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ClockGame{
            id       : 0x2::object::new(arg1),
            end_time : arg0,
        };
        0x2::transfer::share_object<ClockGame>(v0);
    }

    entry fun roll_and_increment(arg0: &mut ClockGame, arg1: &0x2::clock::Clock, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.end_time, 9223372225833336831);
        arg0.end_time = arg0.end_time + 20000;
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = ClockEvent{result: 0x2::random::generate_u64_in_range(&mut v0, 1, 1000)};
        0x2::event::emit<ClockEvent>(v1);
    }

    public fun set_clock_time(arg0: &mut ClockGame, arg1: u64) {
        arg0.end_time = arg1;
    }

    // decompiled from Move bytecode v6
}

