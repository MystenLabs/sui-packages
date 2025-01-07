module 0xf7ebf4e4790daddf301bcdf8b1c79e00f702c734415f4078abb89bcb26ebb398::gravity {
    struct GRAVITY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRAVITY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GRAVITY>>(0x2::coin::mint<GRAVITY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GRAVITY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AaExTY5dQSRRBf7N5jR27uS2UquPsbncNPRReoBBpump.png?size=lg&key=25cea9                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRAVITY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRAVITY ")))), trim_right(b"Gravity Falls                   "), trim_right(b"Welcome, curious traveler! Youve stumbled upon something weird, something strange, and probably something Stan Pines is trying to overcharge you for. But hey, in a world of conspiracies, monsters, and ominous triangles with top hats, having a little edge might just keep you ahead of the game                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRAVITY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRAVITY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRAVITY>>(0x2::coin::mint<GRAVITY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

