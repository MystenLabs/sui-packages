module 0xd65b99dc9ec7f1c8351cd696ab06099bb18c475f3048e356949020561511d031::unity {
    struct UNITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3eQbqrPpqQVYnFTHKxmnDe9ZsS2mjftN6azKTwaxpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UNITY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"UNITY       ")))), trim_right(b"UNITY on SoL                    "), trim_right(x"57656c636f6d6520746f20612070726f6a656374206275696c7420666f7220746865206772656174657220676f6f64206f662065766572796f6e6520696e20746865207472656e63686573206f66207468652063727970746f2073706163652e205768657468657220796f757665206265656e207363616d6d65642c207275676765642c206661726d65642c206f722074616b656e20616476616e74616765206f66746869732069732074686520706c61636520746f206c6561766520616c6c206f66207468617420626568696e642e0a0a57652062656c6965766520612070726f6a656374206973206f6e6c79206173207374726f6e67206173207468652061726d7920626568696e642069742e20546f6765746865722c2077657265206865726520746f206d6f766520666f72776172642c20756e697465642c20737472"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNITY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNITY>>(v4);
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

