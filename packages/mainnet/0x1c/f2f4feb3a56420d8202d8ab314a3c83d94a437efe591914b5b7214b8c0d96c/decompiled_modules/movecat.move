module 0x1cf2f4feb3a56420d8202d8ab314a3c83d94a437efe591914b5b7214b8c0d96c::movecat {
    struct MOVECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d4f3923012e113f5beb027c9d509baf094369afa427805f0cfadfd55857662f0                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOVECAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MoveCat     ")))), trim_right(b"Move Cat                        "), trim_right(b"$MOVECAT is blowing up like crazy on TikTok, Instagram, and CapCut. Its got over 10K uses on CapCut and over 7k videos on TikTok in just 24 hours. $MoveCat is a vibe where you can use it for a bunch of different scenerios and the audio is super catchy.                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECAT>>(v4);
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

