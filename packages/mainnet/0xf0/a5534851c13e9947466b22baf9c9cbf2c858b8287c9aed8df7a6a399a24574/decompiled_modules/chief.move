module 0xf0a5534851c13e9947466b22baf9c9cbf2c858b8287c9aed8df7a6a399a24574::chief {
    struct CHIEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIEF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Ga46f1w1tg6kdZQLj4JyABMZ6FxQkGpcvpBVMuHeMFL2.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHIEF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHIEF       ")))), trim_right(b"MASTER CHIEF                    "), trim_right(b"The name Master Chief echoes through generationsa symbol of strength, resilience, and unstoppable will. Now, his legacy is reborn on the blockchain. $CHIEF isnt just a coin. Its a mission. A tribute to the greatest hero in gaming history.                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIEF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIEF>>(v4);
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

