module 0xe65b348c6e217c05423dd56983199f3990d6789ef64487be12099859458c62ef::worti {
    struct WORTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WORTI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/E8XP6wCvQB36XSCvKKZY56Gp2X5Vsx3Cyd4uwiUU8888.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WORTI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WORTI       ")))), trim_right(b"Worti AI                        "), trim_right(x"204f74686572732061726520706169642c2077657265204652454520666f726576657221200a20437265617465207374756e6e696e672076697375616c732c20206578706c6f726520686f77204149207468696e6b732c2020706172617068726173652074657874732c2020616e616c797a6520696d616765732020616c6c207769746820576f7274692041492c20636f6d706c6574656c792066726565210a204e6f2068696464656e20666565732c206e6f206c696d69747320206a75737420756e6c696d697465642063726561746976697479210a2042652070617274206f6620746865207265766f6c7574696f6e3a204275792024574f52544920616e64206a6f696e20746865206675747572652120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WORTI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WORTI>>(v4);
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

