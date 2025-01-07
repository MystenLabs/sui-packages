module 0x1d39403f54c7cd83bd02dd4c9101940fc4c7cd139beacfd5fd0bfe50b82cfa3d::guess_the_number {
    struct GuessResultEvent has copy, drop {
        is_correct: bool,
        guess: u8,
        correct_number: u8,
        message: 0x1::string::String,
    }

    fun get_random_number(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % ((5 as u64) + 1)) as u8)
    }

    public fun play(arg0: u8, arg1: &0x2::clock::Clock) {
        assert!(arg0 <= 5, 1);
        let v0 = get_random_number(arg1);
        let (v1, v2) = if (arg0 == v0) {
            (0x1::string::utf8(b"Correct! You guessed the right number zsyzqm give to you!"), true)
        } else {
            (0x1::string::utf8(b"Incorrect. Try again."), false)
        };
        let v3 = GuessResultEvent{
            is_correct     : v2,
            guess          : arg0,
            correct_number : v0,
            message        : v1,
        };
        0x2::event::emit<GuessResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

