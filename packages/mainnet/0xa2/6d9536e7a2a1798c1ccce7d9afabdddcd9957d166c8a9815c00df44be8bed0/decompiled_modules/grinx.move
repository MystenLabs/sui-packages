module 0xa26d9536e7a2a1798c1ccce7d9afabdddcd9957d166c8a9815c00df44be8bed0::grinx {
    struct GRINX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRINX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GRINX>>(0x2::coin::mint<GRINX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GRINX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/ao2YzbtCCh9a4JFShK87P3cMkdGbePX9faMKhGhpump.png?size=lg&key=ca4b63                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRINX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRINX   ")))), trim_right(b"Grinx the Guy                   "), trim_right(b"Grinx, just another boys' club member. Once a regular dude, turned green from degen gains, glued to bullish charts. Now searching for a new thrill                                                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRINX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRINX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRINX>>(0x2::coin::mint<GRINX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

