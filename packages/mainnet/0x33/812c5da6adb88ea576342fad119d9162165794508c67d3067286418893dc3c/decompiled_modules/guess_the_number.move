module 0x33812c5da6adb88ea576342fad119d9162165794508c67d3067286418893dc3c::guess_the_number {
    struct GuessResultEvent has copy, drop {
        is_correct: bool,
        guess: u8,
        syyani_give_correct_number: u8,
        message: 0x1::string::String,
    }

    fun get_random_number(arg0: &0x2::clock::Clock) : u8 {
        ((0x2::clock::timestamp_ms(arg0) % ((5 as u64) + 1)) as u8)
    }

    public fun play(arg0: u8, arg1: &0x2::clock::Clock) {
        assert!(arg0 <= 5, 1);
        let v0 = get_random_number(arg1);
        let (v1, v2) = if (arg0 == v0) {
            (0x1::string::utf8(b"Correct! You guessed the right number syyani give to you!"), true)
        } else {
            (0x1::string::utf8(b"Incorrect. Try again."), false)
        };
        let v3 = GuessResultEvent{
            is_correct                 : v2,
            guess                      : arg0,
            syyani_give_correct_number : v0,
            message                    : v1,
        };
        0x2::event::emit<GuessResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

