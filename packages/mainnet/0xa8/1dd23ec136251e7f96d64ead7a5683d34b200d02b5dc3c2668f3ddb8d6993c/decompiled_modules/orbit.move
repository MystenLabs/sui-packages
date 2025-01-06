module 0xa81dd23ec136251e7f96d64ead7a5683d34b200d02b5dc3c2668f3ddb8d6993c::orbit {
    struct ORBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Sx4x5d2kBcFystW5E95Hury8Kg6EeM3tRWjeZ4ppump.png?size=lg&key=e67173                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ORBIT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ORBIT   ")))), trim_right(b"Agent Orbit                     "), trim_right(b"$ORBIT is now live, redefining serverless AI on Sui! Powered by advanced GPU infrastructure with 48GB VRAM, Agent Orbit enables developers to deploy, orchestrate, and scale intelligent agents seamlessly                                                                                                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBIT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORBIT>>(v4);
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

