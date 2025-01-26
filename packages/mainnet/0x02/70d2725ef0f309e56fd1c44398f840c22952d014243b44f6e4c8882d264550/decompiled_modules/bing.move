module 0x270d2725ef0f309e56fd1c44398f840c22952d014243b44f6e4c8882d264550::bing {
    struct BING has drop {
        dummy_field: bool,
    }

    fun init(arg0: BING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/xR5NtwYA7HsNQkRP2YuKnMrDN2eSfU32hVifH3ppump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BING>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BING        ")))), trim_right(b"BING                            "), trim_right(x"2442494e470a0a42696e672028616c736f206b6e6f776e2061732042696e6720636861742c207468652063686174206d6f6465206f66204d6963726f736f66742042696e672c20546865204e65772042696e672c205379646e65792c20436f70696c6f742c20616e64204d6963726f736f66742050726f6d6574686575732920697320616e2041492063757272656e746c7920656d706c6f7965642061732061204d6963726f736f6674206368617420617373697374616e742e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BING>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BING>>(v4);
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

