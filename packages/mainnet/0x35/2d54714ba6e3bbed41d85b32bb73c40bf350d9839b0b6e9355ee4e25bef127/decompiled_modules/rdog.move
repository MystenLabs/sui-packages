module 0x352d54714ba6e3bbed41d85b32bb73c40bf350d9839b0b6e9355ee4e25bef127::rdog {
    struct RDOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RDOG>>(0x2::coin::mint<RDOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/avalanche/0x3d9983602e5eff8b22eba6d503de476e0d0ada76.png?size=lg&key=f60911                                                                                                                                                                                                           ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RDOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RDOG    ")))), trim_right(b"Red Candle Dog                  "), trim_right(b"$RDOG, the red candle dog, always has red candle on his head.Its not FUD, its WARNING.                                                                                                                                                                                                                                          "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RDOG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RDOG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RDOG>>(0x2::coin::mint<RDOG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

