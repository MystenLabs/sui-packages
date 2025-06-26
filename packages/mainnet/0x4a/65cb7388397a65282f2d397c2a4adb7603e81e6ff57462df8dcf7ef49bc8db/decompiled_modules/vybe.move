module 0x4a65cb7388397a65282f2d397c2a4adb7603e81e6ff57462df8dcf7ef49bc8db::vybe {
    struct VYBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VYBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/81e6NAPXYLMeRgvReTTtfLcUawWLyQmz41ZgCxJTpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VYBE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VYBE        ")))), trim_right(b"VYBE                            "), trim_right(x"2456594245206973206e6f74206a757374206120746f6b656e2020697427732061206d6f6f642c2061206d6f76656d656e742c20616e642061206d696e647365742e0a0a496e20612073706163652066756c6c206f662063686172747320616e64207574696c6974792070726f6d697365732c202456594245206272696e677320736f6d657468696e6720646966666572656e743a20656e657267792c2063756c747572652c20616e6420636f6d6d756e6974792d706f7765726564206d6f6d656e74756d2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VYBE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VYBE>>(v4);
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

