module 0x2b562a253da7dc32d28416b2b3ef7b8e92d9a8fcac013b7d35d913cb3cb9a33b::coin_flip {
    struct Round has store, key {
        id: 0x2::object::UID,
        round: u64,
    }

    struct PlayEvent has copy, drop {
        user_input: u64,
        result: u64,
    }

    entry fun flip(arg0: &mut Round, arg1: u64, arg2: vector<u8>) : 0x1::string::String {
        assert!(arg1 >= 1 && arg1 <= 2, 0);
        0x2b562a253da7dc32d28416b2b3ef7b8e92d9a8fcac013b7d35d913cb3cb9a33b::drand_lib::verify_drand_signature(arg2, arg0.round);
        arg0.round = arg0.round + 1;
        let v0 = 0x2b562a253da7dc32d28416b2b3ef7b8e92d9a8fcac013b7d35d913cb3cb9a33b::drand_lib::derive_randomness(arg2);
        let v1 = 0x2b562a253da7dc32d28416b2b3ef7b8e92d9a8fcac013b7d35d913cb3cb9a33b::drand_lib::safe_selection(2, &v0);
        let v2 = 0x1::string::utf8(b"LOSE");
        if (arg1 == v1) {
            v2 = 0x1::string::utf8(b"WIN");
        };
        let v3 = PlayEvent{
            user_input : arg1,
            result     : v1,
        };
        0x2::event::emit<PlayEvent>(v3);
        v2
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

