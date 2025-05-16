module 0x8dfd6194e1147b53ed90e43818db3ab7ed61233fedecf6e0f586ba5c8ec6e842::ass1 {
    struct ASS1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6ZonY5BLyyirrsH8Mi4zttEVKTuR3C6WFLZ3vHUtpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ASS1>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Ass1        ")))), trim_right(b"AssForceOne                     "), trim_right(x"417373466f7263654f6e6520282441535331292069732074686520756c74696d617465206c6f772d636170206d656d6520726f636b6574207072696d656420666f722074616b656f66662e0a556c747261206561726c792e204d6963726f206d61726b6574206361702e203130307820706f74656e7469616c2073746172696e6720796f7520696e2074686520666163652e0a426f726e20666f7220766972616c6974792c206261636b656420627920636f6d6d756e6974792c20616e6420656e67696e656572656420746f206d6f6f6e2e0a4a6f696e206561726c792e2041706520686172642e20526964652074686520666f7263652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS1>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASS1>>(v4);
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

