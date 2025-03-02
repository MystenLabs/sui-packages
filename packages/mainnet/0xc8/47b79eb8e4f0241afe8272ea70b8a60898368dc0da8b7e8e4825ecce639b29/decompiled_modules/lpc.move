module 0xc847b79eb8e4f0241afe8272ea70b8a60898368dc0da8b7e8e4825ecce639b29::lpc {
    struct LPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4eu6jfeZm6J4bi2CfehTF2uCEBdLZA1we2Lpxkoopump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LPC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LPC         ")))), trim_right(b"LEPRECOIN                       "), trim_right(b"Leprecoin ($LPC)  The Luckiest Memecoin on the Blockchain!  Deep in the crypto rainbow lies Leprecoin ($LPC), the mischievous and magical memecoin bringing luck, laughter, and legendary gains to degens worldwide! Inspired by the elusive leprechauns pot of gold, Leprecoin is here to turn every trade into a lucky charm. "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LPC>>(v4);
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

