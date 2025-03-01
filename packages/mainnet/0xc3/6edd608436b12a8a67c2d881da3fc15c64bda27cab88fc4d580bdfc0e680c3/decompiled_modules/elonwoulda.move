module 0xc36edd608436b12a8a67c2d881da3fc15c64bda27cab88fc4d580bdfc0e680c3::elonwoulda {
    struct ELONWOULDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONWOULDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9oANHb8BKiyhmyvLH1gsj73RUB9PkTLQHs5NmJK8pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ELONWOULDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ELONWOULD   ")))), trim_right(b"Elon Would                      "), trim_right(x"427579206120736f6369616c206d6564696120706c6174666f726d20746f20666967687420666f722066726565207370656563683f0a437265617465206120676f7665726e6d656e74206f7267616e69736174696f6e20746f2064657374726f79207769646573707265616420636f7272757074696f6e3f20496e746572706c616e65746172792074726176656c3f0a2048617665206d6f72652062616269657320666f72207468652073616b65206f66207468652068756d616e20726163653f200a4379626572747275636b3f200a0a456c6f6e20776f756c642c20776f756c6420796f753f2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONWOULDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONWOULDA>>(v4);
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

