module 0x91825fb9518f7053f0160524f28956efc2709ea25d938e1028992af475f34bbc::titperks {
    struct TITPERKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITPERKS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HWS2BCMtPmMVsyrouWd7BeB6HsASNQkf3WMR9G1Bnett.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TITPERKS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"titperks    ")))), trim_right(b"titperks                        "), trim_right(x"5449545045524b5320205748455245204348414453204341534820494e2121210a31302520746178200a3125206275726e730a3325206275696c64730a362520666c6f6f647320796f75722077616c6c6574207769746820546974636f696e0a204e6f2073696d70732c206e6f2070617065722068616e6473206a75737420616c70686120686f646c65727320737461636b696e67206761696e73202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITPERKS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITPERKS>>(v4);
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

