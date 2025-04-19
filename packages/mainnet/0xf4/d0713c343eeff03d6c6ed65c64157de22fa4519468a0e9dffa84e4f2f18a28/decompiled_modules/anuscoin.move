module 0xf4d0713c343eeff03d6c6ed65c64157de22fa4519468a0e9dffa84e4f2f18a28::anuscoin {
    struct ANUSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANUSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7vpzpAEV4vjZBwBS9daCcXXYioV8iPtwMmVetvhvpump.png?claimId=Fw-5lDYPzfCgC5pn                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ANUSCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ANUSCOIN    ")))), trim_right(b"ANUSCOIN                        "), trim_right(x"4465706c6f79656420627920536869746f736869202d205468652046617274436f696e20446576202d20616e64206e6f772072616e20627920636f6d6d756e6974792c20666f722074686520636f6d6d756e6974792e0a0a24414e5553434f494e206973206d6f7265207468616e206120636f696e2020697427732061206d6f76656d656e742c20612073746174656d656e742c20616e6420612070726f7564206465636c61726174696f6e2074686174206974277320796f75722062757474686f6c6520696e206d65646963616c207465726d7320616e64206469676974616c20646f6c6c617220666f726d2e0a0a416e7573436f696e202d20536d656c6c2074686520646f6f6b69652c2074686174277320736f6d6520676f6f642073682a742e2020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANUSCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANUSCOIN>>(v4);
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

