module 0xe18b5761ac1d4e55802125ba42320cda857c6e25a23b568c6b60389c7f4c0bd4::game {
    struct GameOutcome has copy, drop {
        player_gesture: u64,
        machine_gesture: u64,
        outcome: 0x1::string::String,
    }

    fun determine_outcome(arg0: u64, arg1: u64) : 0x1::string::String {
        if (arg0 == arg1) {
            0x1::string::utf8(b"Oh, it's a tie. (0: Rock, 1: Scissors, 2: Paper)")
        } else if (is_player_winner(arg0, arg1)) {
            0x1::string::utf8(b"Congratulations, you won! (0: Rock, 1: Scissors, 2: Paper)")
        } else {
            0x1::string::utf8(b"Sorry, you lost. (0: Rock, 1: Scissors, 2: Paper)")
        }
    }

    fun generate_random_gesture(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0) % 3;
        0x1::debug::print<u64>(&v0);
        v0
    }

    fun is_player_winner(arg0: u64, arg1: u64) : bool {
        (arg0 + 1) % 3 == arg1
    }

    fun is_valid_gesture(arg0: u64) : bool {
        arg0 == 0 || arg0 == 1 || arg0 == 2
    }

    public fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(is_valid_gesture(arg0), 0);
        let v0 = generate_random_gesture(arg1);
        let v1 = GameOutcome{
            player_gesture  : arg0,
            machine_gesture : v0,
            outcome         : determine_outcome(arg0, v0),
        };
        0x2::event::emit<GameOutcome>(v1);
    }

    // decompiled from Move bytecode v6
}

