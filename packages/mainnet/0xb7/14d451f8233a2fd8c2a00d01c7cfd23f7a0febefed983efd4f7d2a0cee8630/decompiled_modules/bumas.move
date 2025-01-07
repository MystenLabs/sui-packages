module 0xb714d451f8233a2fd8c2a00d01c7cfd23f7a0febefed983efd4f7d2a0cee8630::bumas {
    struct BUMAS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BUMAS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BUMAS>>(0x2::coin::mint<BUMAS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BUMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9yvpQZfqM91VJG8T1DQFctrAgDkoKUsEMtzRWwRpump.png?size=lg&key=db1ea1                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUMAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUMAS   ")))), trim_right(b"Bumas the Spirit                "), trim_right(b"BUMAS is the bullish Christmas Spirit on Sui! Part of spirit, part of bull, you'll see him popping up all over the place on his Xmas mission!                                                                                                                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUMAS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUMAS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BUMAS>>(0x2::coin::mint<BUMAS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

