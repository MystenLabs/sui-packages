module 0x774720906328adbc9ae493f0833aacf15547126a95c77223ce4e74e2f5c84172::bonkfrens {
    struct BONKFRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Hioxt98BBFmKF74AWC7n6SY8aYHNMdkPzvex2MsKpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BONKFRENS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BonkFrens   ")))), trim_right(b"BonkFrens                       "), trim_right(x"57656c636f6d6520746f20426f6e6b4672656e732e204672656e73202b2073746162696c697479203d204672656e73206f6e204d6f6f6e2e0a0a4465763a204d61646520636f696e2c20626f75676874207e3537206d696c6c696f6e20636f696e732e20566573746564207468656d20616c6c20746f202431206d696c6c696f6e204d61726b6574204361702e20436f6e74726163742072656c656173657320636f696e73207765656b6c79206f6e6365206d61726b65742068697473202431206d696c6c696f6e2c203235252072656c656173656420666f722034207765656b73206261636b20746f206465762e20496e206120736974756174696f6e20776865726520776520646f6e742072656163682031206d696c6c696f6e20696e2032206d6f6e74687320636f696e732073746172742072656c656173696e672061"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKFRENS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKFRENS>>(v4);
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

