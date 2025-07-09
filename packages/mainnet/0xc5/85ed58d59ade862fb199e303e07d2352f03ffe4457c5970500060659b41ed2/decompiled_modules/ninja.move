module 0xc585ed58d59ade862fb199e303e07d2352f03ffe4457c5970500060659b41ed2::ninja {
    struct NINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2xP43MawHfU7pwPUmvkc6AUWg4GX8xPQLTGMkSZfCEJT.png?claimId=8qaPHUzJ_TtEvZ_2                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NINJA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NINJA       ")))), trim_right(b"Shinobi                         "), trim_right(x"4e494e4a41206973206d756368206d6f7265207468616e206a757374206120746f6b656e2e2e200a0a697473206d6f7265207468616e206a7573742061207574696c69747920616e64206d6f7265207468616e206a7573742061206465762e2e200a0a4974206973206d6f7265207468616e206a757374206120544720636f6d6d756e6974792c20736f6369616c206d656469612063616d706169676e206f72206d656d652e200a0a4e494e4a412069732061206d6f76656d656e742c2061206d696e6473657420616e6420616e206574686f732e204e696e6a6120697320616e206964656120616e64206120776179206f66206c6966652e0a0a4e494e4a4120697320666f72206576657279626f647920616e6420616e79626f64792063616e2062652061204e494e4a412e0a0a4920616d204e494e4a410a0a596f752061"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINJA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINJA>>(v4);
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

