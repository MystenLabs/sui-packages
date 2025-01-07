module 0x2d0b48c7726356dac5ab9acaad2a1112fbf1d857b08069f5f48ef9a37b7148a5::my_game {
    struct Outcome has copy, drop {
        player_gesture: u64,
        machine_gesture: u64,
        outcome: 0x1::string::String,
    }

    fun is_wine(arg0: u64, arg1: u64) : bool {
        (arg0 + 1) % 3 == arg1
    }

    public fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 == 0 || arg0 == 1 || arg0 == 2, 0);
        let v0 = random_gesture(arg1);
        let v1 = if (arg0 == v0) {
            0x1::string::utf8(x"e5b9b3")
        } else if (is_wine(arg0, v0)) {
            0x1::string::utf8(x"e8839c")
        } else {
            0x1::string::utf8(x"e8be93")
        };
        let v2 = v1;
        0x1::string::append(&mut v2, 0x1::string::utf8(x"efbc8830efbc9ae79fb3e5a4b4efbc8c31efbc9ae589aae58880efbc8c32efbc9ae5b883efbc89"));
        let v3 = Outcome{
            player_gesture  : arg0,
            machine_gesture : v0,
            outcome         : v2,
        };
        0x2::event::emit<Outcome>(v3);
    }

    fun random_gesture(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0) % 3;
        0x1::debug::print<u64>(&v0);
        v0
    }

    // decompiled from Move bytecode v6
}

