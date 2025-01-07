module 0xd1a8c53a043fc1d0d41a5cebeb2fd880023774ecd471d3ea656f365d56fc8a6c::Moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (b"https://storage.googleapis.com/moonday/tokens/2e79986a-e75e-4165-bee6-2098eab7dbb6/cartoon-snake-climbing-ladder-like-board-game-snakes-ladders-hand-drawn-cartoon-snake-climbing-ladder-like-retro-326007749.webp" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/moonday/tokens/2e79986a-e75e-4165-bee6-2098eab7dbb6/cartoon-snake-climbing-ladder-like-board-game-snakes-ladders-hand-drawn-cartoon-snake-climbing-ladder-like-retro-326007749.webp"))
        };
        let v1 = b"aSNLDR";
        let v2 = b"bSnake&Ladder";
        let v3 = b"cSnake and ladder tokens";
        0x1::vector::remove<u8>(&mut v1, 0);
        0x1::vector::remove<u8>(&mut v2, 0);
        0x1::vector::remove<u8>(&mut v3, 0);
        let v4 = 100000000;
        let v5 = 188391439;
        if (188391439 == 0) {
            v4 = 1;
            v5 = 1;
        };
        0xe908c8463495d2a3b0d05d3ac596a72688c31892f015b4935d98ee8c0d01abe4::factory::new<MOONDAY>(arg0, 1000000000, v1, v2, v3, v0, false, 0x1::fixed_point32::create_from_rational(v4, v5), arg1);
    }

    // decompiled from Move bytecode v6
}

