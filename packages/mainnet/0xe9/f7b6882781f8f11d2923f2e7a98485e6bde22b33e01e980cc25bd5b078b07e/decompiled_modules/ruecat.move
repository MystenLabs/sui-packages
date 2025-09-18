module 0xe9f7b6882781f8f11d2923f2e7a98485e6bde22b33e01e980cc25bd5b078b07e::ruecat {
    struct RUECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AMKKkovbUqr5cxmsg22KxTgaRXq6z4f8umrze4JKpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RUECAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RUECAT      ")))), trim_right(b"Rue Cat                         "), trim_right(x"52756520436174206973207468652063757465206b697474656e20696e207374616e64696e6720636f6d62696e656420776974682074686520706f776572206f662041492e0a52554543415420697320616c7265616479206f6e20746865206d61696e20736f6369616c206e6574776f726b732040727565636174736f6c616e613a200a547769747465722c20496e7374616772616d2c2054696b546f6b2c20596f7574756265210a536f2062757920616e64207361766520796f7572202452554543415420746f6b656e7320616e64206c657427732074616b6520746869732063757465206b697474656e20746f20746865206d6f6f6e212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUECAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUECAT>>(v4);
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

