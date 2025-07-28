module 0xbd1e43f5298d68a546a5e8dd2445ead244218355b9f842a2c8e31276dc249b27::shiburai {
    struct SHIBURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9oRotoLST2BTttG3AybA6W9jocZ83pUYJFtoRYtmbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHIBURAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHIBURAI    ")))), trim_right(b"SHIBURAI                        "), trim_right(b"$Shiburai is a fearless samurai Shiba Inu who left the comfort of the dog world to embrace the warriors path. Clad in ancient armor and guided by honor, he roams the crypto realm slashing down jeets and scam devs, protecting the innocent and restoring balance to Web3. A symbol of loyalty, strength, and relentless spiri"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBURAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBURAI>>(v4);
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

