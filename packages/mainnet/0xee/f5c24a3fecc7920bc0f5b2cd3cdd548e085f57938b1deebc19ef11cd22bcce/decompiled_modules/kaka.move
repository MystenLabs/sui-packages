module 0xeef5c24a3fecc7920bc0f5b2cd3cdd548e085f57938b1deebc19ef11cd22bcce::kaka {
    struct KAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FH6jc68WzeAUXKp6uDg9QPciTeU75o32xFDzKLzmbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KAKA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KAKA        ")))), trim_right(b"KAKA                            "), trim_right(b"I was born in a dumpster behind a 7-Eleven, baptized in a porta-potty, and raised on expired trail mix and spy pigeon lore. My hobbies include screaming at leaves and casual arson. Im banned from the local park (long story involving a green frog and a flare gun), but thats never stopped me from trespassing. The forest "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAKA>>(v4);
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

