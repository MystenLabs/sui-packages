module 0xa0a424fde4f00de4ffbf7368c31dab2e428511798e540428285e9ffa8f696e46::mindsol {
    struct MINDSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINDSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"24Mcsjg8HdMBTIis                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MINDSOL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Mindsol     ")))), trim_right(b"Mindfulness Coin                "), trim_right(b"Welcome to MindSol, a community driven coin promoting mindfulness in crypto space and in real life. MindSol is here to teach the memes the art of mindfulness and to support mental health and wellness initiatives. By utilising a decentralised platform,Mindfulness Coin seeks to create a global community focused on improv"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINDSOL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINDSOL>>(v4);
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

