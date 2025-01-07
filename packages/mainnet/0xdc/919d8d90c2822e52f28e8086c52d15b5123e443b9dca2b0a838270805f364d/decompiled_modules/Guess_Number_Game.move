module 0xdc919d8d90c2822e52f28e8086c52d15b5123e443b9dca2b0a838270805f364d::Guess_Number_Game {
    struct PlayGameEvent has copy, drop {
        publisher: 0x1::string::String,
        player: address,
        actual_number: u64,
        expect_number: u64,
        result: bool,
        message: 0x1::string::String,
    }

    fun get_random(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) % 10
    }

    public entry fun play_game(arg0: u64, arg1: &mut 0x2::coin::TreasuryCap<0xe1fb6293d4461f3a443b8a484c70bde344ce239def4f6412abeae531e3f4a38e::Kecson_Faucet_Coin::KECSON_FAUCET_COIN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < 10, 1);
        let v0 = get_random(arg2);
        let v1 = arg0 == v0;
        let v2 = if (v1) {
            0x1::string::utf8(x"436f6e67726174756c6174696f6e7320f09f8e892c20796f7520677565737365642069742e")
        } else {
            0x1::string::utf8(x"556e666f7274756e6174656c7920f09f98942c20746865726520776173206e6f2072696768742067756573732e")
        };
        let v3 = 0x2::tx_context::sender(arg3);
        if (v1) {
            0xe1fb6293d4461f3a443b8a484c70bde344ce239def4f6412abeae531e3f4a38e::Kecson_Faucet_Coin::mint(arg1, 0x2::math::pow(10, 9), v3, arg3);
        };
        let v4 = PlayGameEvent{
            publisher     : 0x1::string::utf8(b"Kecson"),
            player        : v3,
            actual_number : v0,
            expect_number : arg0,
            result        : v1,
            message       : v2,
        };
        0x2::event::emit<PlayGameEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

