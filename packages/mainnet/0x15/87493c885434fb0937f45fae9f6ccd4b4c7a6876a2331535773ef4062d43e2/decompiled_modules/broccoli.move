module 0x1587493c885434fb0937f45fae9f6ccd4b4c7a6876a2331535773ef4062d43e2::broccoli {
    struct BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2Dynh7je6trhm2Sam1SrBxX9vb1gBruczymWujQ5pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BROCCOLI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BROCCOLI    ")))), trim_right(b"Gen B                           "), trim_right(x"47656e204220282442524f43434f4c4929202054686520437574205468617420556e6974656420612047656e65726174696f6e0a0a46726f6d2054696b546f6b207465656e7320746f20412d6c6973742063656c6562732c207468652062726f63636f6c69206861697263757420686173206265636f6d6520612066756c6c2d626c6f776e2063756c747572616c206d6f76656d656e742e204e6f7720697473206120636f696e2e0a0a2442524f43434f4c492069732074686520756c74696d6174652047656e205a206d656d6520746f6b656e726f6f74656420696e207374796c652c2077617465726564207769746820636c6f75742c20616e642067726f776e2062792074686520636f6d6d756e6974792e205768657468657220796f7520726f636b6564207468652063686f70206f72206a7573742072657370656374"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCOLI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROCCOLI>>(v4);
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

