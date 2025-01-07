module 0x6d5bc088b7462575472565873c8236f8ec4e1ada2938c4e39b6d77bc81d67873::my_game {
    struct EGameOutcome has copy, drop {
        guess: u64,
        result: u64,
        outcome: 0x1::string::String,
    }

    public fun play(arg0: u64, arg1: &0x2::clock::Clock) {
        assert!(arg0 == 0 || arg0 == 1, 1);
        let v0 = random(arg1);
        let v1 = if (arg0 == v0) {
            0x1::string::utf8(b"WIN!!!")
        } else {
            0x1::string::utf8(b"LOSE...")
        };
        let v2 = EGameOutcome{
            guess   : arg0,
            result  : v0,
            outcome : v1,
        };
        0x2::event::emit<EGameOutcome>(v2);
    }

    fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0) % 2;
        0x1::debug::print<u64>(&v0);
        v0
    }

    // decompiled from Move bytecode v6
}

