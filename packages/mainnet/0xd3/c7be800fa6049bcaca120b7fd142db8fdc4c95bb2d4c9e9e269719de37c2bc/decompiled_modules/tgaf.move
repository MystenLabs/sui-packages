module 0xd3c7be800fa6049bcaca120b7fd142db8fdc4c95bb2d4c9e9e269719de37c2bc::tgaf {
    struct TGAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGAF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9fePXJt2b2EbLiGLnaru8rUHfxRYVLLAD1DpEPbxhQ47.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TGAF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TGAF        ")))), trim_right(b"TrumpGivesAFuck                 "), trim_right(x"202a2a494e54524f445543494e47205452554d504749564553414655434b202854474146292a2a2020200a2a22546865204d656d6520436f696e2054686174205361797320576861742045766572796f6e6573205468696e6b696e6721222a20200a2d2d2d0a202a2a5768617420697320544741463f2a2a20200a5447414620697320746865202a2a726562656c6c696f75732c206e6f2d66696c746572206d656d6520636f696e2a2a207468617473206865726520746f207368616b65207570207468652063727970746f20776f726c642e2049747320626f6c642c206974732062726173682c20616e6420697420646f65736e7420636172652061626f757420706c6179696e67206e6963652e205769746820544741462c2077657265207475726e696e67206368616f7320696e746f20636173682c206d656d65732069"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGAF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGAF>>(v4);
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

