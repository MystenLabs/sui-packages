module 0xc50d8a6a66706a71cc05fb1ce88adb5fff503ba5c541dd099b91957a45d3ad2c::mauiwowie {
    struct MAUIWOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUIWOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f37d88f27cf03707cae151a718708c31da0495d85f952de12d980227a94772d6                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAUIWOWIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MauiWowie   ")))), trim_right(b"maui wowie                      "), trim_right(b"Videos Using Kid Kudi's \"Maui Wowie\" are extremely viral right now, with over 800k videos posted using the audio. Big influencers like marlon hopped on the trend and even Kid Cudi himself posted a video doing this trend.                                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAUIWOWIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAUIWOWIE>>(v4);
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

