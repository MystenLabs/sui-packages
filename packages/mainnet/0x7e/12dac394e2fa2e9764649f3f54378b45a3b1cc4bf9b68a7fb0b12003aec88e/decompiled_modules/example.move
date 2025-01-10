module 0x7e12dac394e2fa2e9764649f3f54378b45a3b1cc4bf9b68a7fb0b12003aec88e::example {
    struct Game has store, key {
        id: 0x2::object::UID,
        board: vector<u8>,
        turn: u8,
        x: address,
        o: address,
        admin: vector<u8>,
    }

    // decompiled from Move bytecode v6
}

