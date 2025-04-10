module 0xa6c5c22a02a2cf80ec5a37800108a97c9c4b68e4160332676319ed8506be2e0e::guess_number {
    struct GuessGameResult has copy, drop {
        you_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    public fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 >= 0 && arg0 < 10, 1);
        let v0 = random(arg1);
        let v1 = if (v0 == arg0) {
            0x1::string::utf8(b"You Win!")
        } else {
            0x1::string::utf8(b"You Lose!")
        };
        let v2 = GuessGameResult{
            you_number  : arg0,
            game_number : v0,
            output      : v1,
        };
        0x2::event::emit<GuessGameResult>(v2);
    }

    public fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::hash::sha3_256(b"windyund");
        let v1 = ((0x2::clock::timestamp_ms(arg0) * (0x1::vector::pop_back<u8>(&mut v0) as u64) % 10) as u64);
        0x1::debug::print<u64>(&v1);
        v1
    }

    // decompiled from Move bytecode v6
}

