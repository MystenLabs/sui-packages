module 0x5d20579940a0c071a8849bece0361c24a0c5296c1051c1648ec64a4f0b3975b8::coin_flip {
    struct Round has store, key {
        id: 0x2::object::UID,
        round: u64,
    }

    struct PlayEvent has copy, drop {
        user_input: u64,
        result: u64,
    }

    entry fun flip(arg0: &mut Round, arg1: u64, arg2: vector<u8>) : PlayEvent {
        assert!(arg1 >= 0 && arg1 <= 1, 0);
        arg0.round = arg0.round + 1;
        let v0 = 0x5d20579940a0c071a8849bece0361c24a0c5296c1051c1648ec64a4f0b3975b8::drand_lib::derive_randomness(arg2);
        let v1 = PlayEvent{
            user_input : arg1,
            result     : 0x5d20579940a0c071a8849bece0361c24a0c5296c1051c1648ec64a4f0b3975b8::drand_lib::safe_selection(2, &v0),
        };
        0x2::event::emit<PlayEvent>(v1);
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Round{
            id    : 0x2::object::new(arg0),
            round : 1,
        };
        0x2::transfer::share_object<Round>(v0);
    }

    // decompiled from Move bytecode v6
}

