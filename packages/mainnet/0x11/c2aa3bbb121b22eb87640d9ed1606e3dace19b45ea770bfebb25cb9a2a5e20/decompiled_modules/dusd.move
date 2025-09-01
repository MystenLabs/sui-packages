module 0x11c2aa3bbb121b22eb87640d9ed1606e3dace19b45ea770bfebb25cb9a2a5e20::dusd {
    struct DUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/J13cJvKEhXDSBW7T7Q61xVgNVRThRviDmdmJM1X1pump.png?claimId=4jP88hHXDq98lmrN                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DUSD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DUSD        ")))), trim_right(b"dark money                      "), trim_right(x"20546865206f726967696e3a0a496e2074686520552e532e2c206461726b206d6f6e6579206275797320696e666c75656e636520696e20706f6c697469637320776974686f7574206c656176696e6720612074726163652e205765206272696e67206974206f6e2d636861696e3a206120706172616c6c656c20646f6c6c61722c20696e76697369626c652062757420756e73746f707061626c652e0a0a2054686520636f726520696465613a0a2444555344206973206e6f74206a757374206120746f6b656e2c206974277320736174697265207475726e6564207265616c3a206120646563656e7472616c697a656420737461626c65636f696e207468617420656d626f6469657320736861646f77206361706974616c2e205768696c737420555344542f555344432072656c79206f6e2062616e6b732c202444555344"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUSD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUSD>>(v4);
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

