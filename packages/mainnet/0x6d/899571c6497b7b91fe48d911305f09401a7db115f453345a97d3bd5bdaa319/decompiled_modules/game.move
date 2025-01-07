module 0x6d899571c6497b7b91fe48d911305f09401a7db115f453345a97d3bd5bdaa319::game {
    struct GameOutPut has copy, drop {
        you_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public fun get_random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = ((0x2::clock::timestamp_ms(arg0) % 7) as u64);
        0x1::debug::print<u64>(&v0);
        v0
    }

    public fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 < 3, 1);
        let v0 = get_random(arg1);
        let v1 = if (v0 == 0) {
            0
        } else if (v0 < 4) {
            1
        } else {
            2
        };
        let v2 = if (v0 == 0 && arg0 == 0) {
            0x1::string::utf8(b"BINGOOOO! Big Win")
        } else if (arg0 == v1) {
            0x1::string::utf8(b"you win")
        } else {
            0x1::string::utf8(b"you lose")
        };
        let v3 = GameOutPut{
            you_number  : arg0,
            game_number : v0,
            output      : v2,
        };
        0x2::event::emit<GameOutPut>(v3);
    }

    // decompiled from Move bytecode v6
}

