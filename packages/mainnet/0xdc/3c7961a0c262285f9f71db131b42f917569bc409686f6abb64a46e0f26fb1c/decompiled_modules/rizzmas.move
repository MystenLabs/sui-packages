module 0xdc3c7961a0c262285f9f71db131b42f917569bc409686f6abb64a46e0f26fb1c::rizzmas {
    struct RIZZMAS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIZZMAS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RIZZMAS>>(0x2::coin::mint<RIZZMAS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xb957c7ec83d36a39c49fc47dcf03e48cc6f59008.png?size=lg&key=4a8fb2                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIZZMAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RIZZMAS ")))), trim_right(b"Rizzmas                         "), trim_right(b"Rizzmas is a fun, viral trend combining holiday cheer and charisma, gaining traction due to TikToks meme culture. Its appeal among white users reflects how internet slang spreads across cultures, blending humor, charm, and festive vibes.                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIZZMAS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIZZMAS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIZZMAS>>(0x2::coin::mint<RIZZMAS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

