module 0x994d0950ddb45c300f806a25cbcf90875ebab18f988a0f3d597b5da73e4af733::gstd {
    struct GSTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSTD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AzN7uPhQZgThxsRvhNGHPUPRjdEjScTbqQdf5gt6Fqby.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GSTD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GSTD        ")))), trim_right(b"Gold Standard                   "), trim_right(x"54686520476f6c64205374616e6461726420284753544429200a0a54686520476f6c64205374616e6461726420546f6b656e20284753544429206973206120737461626c65206173736574206f6e2074686520536f6c616e6120626c6f636b636861696e2064657369676e656420746f2063726561746520676f6c642d6261636b6564206c69717569646974792e2045616368204753544420746f6b656e2077696c6c206265206c696e6b656420746f207468652076616c7565206f662031206772616d206f6620706879736963616c20676f6c642c2077686963682070726f76696465732061207361666520616e64207472616e73706172656e742077617920746f20696e7665737420696e20676f6c6420696e206469676974616c20666f726d2e200a0a4b65792066756e6374696f6e733a20476f6c642d6261636b6564"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSTD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSTD>>(v4);
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

