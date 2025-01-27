module 0x1c4b471b32a8f1065f03bd668b2fce93526a73cbc5ea6072efe6ad4065d6eb84::shy {
    struct SHY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHY>>(0x2::coin::mint<SHY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7d1vpt5eri79nETcL74Punhp3mGkeBgUkMdPWep6pump.png?size=lg&key=2fae97                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHY     ")))), trim_right(b"Shytoshi Kusama                 "), trim_right(b"Tribute to the legendary visionary SHYTOSHI KUSAMA of the SHIBA INU ecosystem who single handed took SHIB from 6000 holders to millions                                                                                                                                                                                         "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHY>>(0x2::coin::mint<SHY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

