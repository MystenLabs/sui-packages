module 0xeab436f907ff2ae7c4e0c62d46ce4df503992e0d72beabc1d0b2d9b67334a175::xushizhao_game {
    struct GamingResultEvent has copy, drop {
        is_win: bool,
        result: 0x1::string::String,
        you_number: u8,
        game_number: u8,
    }

    public entry fun get_random_choice(arg0: &0x2::clock::Clock) : u8 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        0x1::debug::print<u64>(&v0);
        ((0x2::clock::timestamp_ms(arg0) % 3) as u8)
    }

    public entry fun play(arg0: u8, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::TreasuryCap<0x9863ad57403bc1a1f412ca637964e5824bcacdb89228a500b5a09f444604b81f::xushizhao_faucet_coin::XUSHIZHAO_FAUCET_COIN>, arg3: address, arg4: 0x2::coin::Coin<0x9863ad57403bc1a1f412ca637964e5824bcacdb89228a500b5a09f444604b81f::xushizhao_faucet_coin::XUSHIZHAO_FAUCET_COIN>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = get_random_choice(arg1);
        0x1::debug::print<u8>(&v0);
        let (v1, v2) = if (arg0 > v0) {
            0x9863ad57403bc1a1f412ca637964e5824bcacdb89228a500b5a09f444604b81f::xushizhao_faucet_coin::mint(arg2, 100, arg3, arg6);
            (0x1::string::utf8(b"Win"), true)
        } else if (arg0 == v0) {
            (0x1::string::utf8(b"Draw"), false)
        } else {
            (0x1::string::utf8(b"Lose"), false)
        };
        let v3 = GamingResultEvent{
            is_win      : v2,
            result      : v1,
            you_number  : arg0,
            game_number : v0,
        };
        0x2::event::emit<GamingResultEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9863ad57403bc1a1f412ca637964e5824bcacdb89228a500b5a09f444604b81f::xushizhao_faucet_coin::XUSHIZHAO_FAUCET_COIN>>(arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

