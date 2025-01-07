module 0x75fe2a4694c014297553990f59b56b29928391f52aeca4fa19fc95e517977072::game {
    struct GameResultEvent has copy, drop {
        user_guess: u8,
        random_number: u8,
        result: 0x1::string::String,
    }

    entry fun play(arg0: u8, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 10, 0);
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 10);
        let v2 = if (v1 == arg0) {
            0x1::string::utf8(b"you win")
        } else {
            0x1::string::utf8(b"you loss")
        };
        let v3 = GameResultEvent{
            user_guess    : arg0,
            random_number : v1,
            result        : v2,
        };
        0x2::event::emit<GameResultEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

