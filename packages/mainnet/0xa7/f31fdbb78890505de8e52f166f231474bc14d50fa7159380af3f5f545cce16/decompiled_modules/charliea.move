module 0xa7f31fdbb78890505de8e52f166f231474bc14d50fa7159380af3f5f545cce16::charliea {
    struct CHARLIEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARLIEA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9297fa3945a14f0050b835fc876e1087d23981b3d053e143e5a4be08e9962bc8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHARLIEA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Charlie     ")))), trim_right(b"Charlie $inger                  "), trim_right(b"Charlie $inger (Charlie$) Introducing \"Charlie $inger (Charlie$) aka the TOP D\"  a meme coin inspired by Charlie, the adorable Yorkie puppy with \"100 faces\" living his everyday life in Europe. More than just a cute face, THE TOP D is a movement dedicated to empowering the voiceless. Our core mission is to shine a light"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARLIEA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARLIEA>>(v4);
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

