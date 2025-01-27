module 0xd220b728a367db8d76a5344951d2986e8c0b8cc7a8751088cad8d063ebf77210::hodlmyass {
    struct HODLMYASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HODLMYASS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/S2SRdnAYGW1dRnBRrqm9iwHsuJbh1KsvgkB9Nzfpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HODLMYASS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HODLMYASS   ")))), trim_right(b"Cheeks Coin                     "), trim_right(x"436865656b7320436f696e202824484f444c4d79417373293a20486f6c642054686174204173732054696768740a436865656b7320436f696e20697320612063727970746f20666f722074686f73652077686f206b6e6f772077686174206974206d65616e7320746f20686f6c6420616e20617373616e64207765206d65616e2074686174206c69746572616c6c792e204c656420627920746865206f6e6520616e64206f6e6c7920436865656b732c207468652073617373696573742c206d6f73742073747562626f726e2c20616e64206d6f7374206c6f7661626c652061737320696e207468652063727970746f20776f726c642c207468697320636f696e20697320616c6c2061626f757420656d62726163696e6720746861742061737320616e64206e65766572206c657474696e6720676f2e20536f2c206c657473"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HODLMYASS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HODLMYASS>>(v4);
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

