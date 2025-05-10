module 0xc9575808e52eecd11113584ea7916987451ae2e5c50eaf7379b06500b601307d::profit {
    struct PROFIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROFIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C7ygkgoPdscQYRsz5D79tH6biZmfVzKin7gUggkupump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PROFIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Profit      ")))), trim_right(b"Profitcoin                      "), trim_right(x"42757920616e642073656c6c20666f722070726f6669740a0a4465706c6f79656420627920486f757365636f696e204465760a0a54686520486f757365636f696e20646576206861642074776f20677265617420766973696f6e733a0a312e2042757920486f757365636f696e20746f20666c69702074686520686f7573696e67206d61726b65742e0a322e204275792050726f666974636f696e20616e642073656c6c20666f722070726f6669742e0a0a53656c6c20796f75722024486f75736520666f72202450726f6669740a0a4e6f772043544f202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROFIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PROFIT>>(v4);
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

