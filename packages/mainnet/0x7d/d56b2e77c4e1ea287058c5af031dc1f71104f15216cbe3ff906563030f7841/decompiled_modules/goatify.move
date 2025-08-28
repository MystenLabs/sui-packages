module 0x7dd56b2e77c4e1ea287058c5af031dc1f71104f15216cbe3ff906563030f7841::goatify {
    struct GOATIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/jkh9Qf2iNwa3AUCsBrbpFUpaK18CMez296WvefZgoat.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOATIFY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOATIFY     ")))), trim_right(b"From Cope to Cult               "), trim_right(x"5468657920737461727465642061732062726f6b656e20626167686f6c646572732c2073637265616d696e6720636f706520696e746f2074686520766f6964206f66207275676765642063686172747320616e64206661696c656420647265616d732e0a0a4576657279206d656d6520776173206a75737420616e6f7468657220646573706572617465207072617965722c20657665727920626c65617420612063727920666f722065786974206c69717569646974792e0a0a427574207468656e2063616d6520474f41544946592e0a0a46726f6d20436f706520746f2043756c742024474f4154494659202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATIFY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATIFY>>(v4);
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

