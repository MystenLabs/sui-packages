module 0xa0c0a3888a656b5fa517cd623c2001543fd7473f5315fbdd1b04ab07d04cfef9::mute {
    struct MUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AMp6nNmvohjGYEnfDZ635nykM1msQTRAhmquUnHBpump.png?claimId=6c54SQbXCzM4LjYZ                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MUTE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MUTE        ")))), trim_right(b"MUT8 Virus                      "), trim_right(x"244d555445206973206e6f206c6f6e676572206a75737420616e206f7574627265616b202069742773206120726573757272656374696f6e2e0a426f726e20696e2074686520736861646f7773206f6620536f6c616e612c20244d5554452077617320656e67696e65657265642062792044722e20466f6d6f3a206120726f67756520736369656e74697374206f6273657373656420776974682074617267657465642065766f6c7574696f6e20616e64206d656d6574696320776172666172652e20546f6765746865722077697468206869732070726f74672c2044722e20527567672c2074686579206275696c742074686520666972737420766972616c20746f6b656e206f6620697473206b696e642020636f646564206e6f74206f6e6c7920666f72207472616e736d697373696f6e2c2062757420646f6d696e6174"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUTE>>(v4);
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

