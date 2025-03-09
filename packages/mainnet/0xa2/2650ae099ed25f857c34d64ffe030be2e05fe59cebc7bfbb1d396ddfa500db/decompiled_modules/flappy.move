module 0xa22650ae099ed25f857c34d64ffe030be2e05fe59cebc7bfbb1d396ddfa500db::flappy {
    struct FLAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FGh7Tu5sEhxPHk21i2dXWcwKFcxJiQVmzAoXy14YGame.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FLAPPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FLAPPY      ")))), trim_right(b"FLAPPYBIRD                      "), trim_right(x"24464c41505059204249524420746865206d6f737420706f70756c6172204f47206d6f62696c652067616d65206973206e6f77206261636b204f4e2d434841494e2e20506c61792d746f2d6561726e20726577617264732c20616e6420626c6f636b636861696e2d706f7765726564206c6561646572626f617264732e20466c61702c206561726e2c205354414b452024464c4150505920616e6420636f6c6c65637420746f64617921200a0a546865206d6f7374206164646963746976652067616d652c2077686572652070656f706c65206861766520636f6d6d697474656420732a69636964652066726f6d20706c6179696e6720464c4150505920424952442e2052656d6f7665642066726f6d204d6f62696c6520616e642050432e202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAPPY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAPPY>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

