module 0x64bdcaefb049e0fd44fac636b7110ab323e753b34fe0621084b9e0d43388a03d::recession {
    struct RECESSION has drop {
        dummy_field: bool,
    }

    fun init(arg0: RECESSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/58WAscyseSRr23SR3kE8paAfmazScJsRn1TexJtgpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RECESSION>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RECESSION   ")))), trim_right(b"Recession Coin                  "), trim_right(x"4120526563657373696f6e20697320706f74656e7469616c6c792075706f6e2075732c20612077617920746f206d616b65207375726520796f75207375727669766520696e206120726563657373696f6e20697320746f2062757920726563657373696f6e20636f696e20616e64206d616b65206974206b6e6f776e20697473206865726520746f207361766520796f750a0a594f555220484544474520414741494e53542054484520524543455353494f4e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RECESSION>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RECESSION>>(v4);
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

