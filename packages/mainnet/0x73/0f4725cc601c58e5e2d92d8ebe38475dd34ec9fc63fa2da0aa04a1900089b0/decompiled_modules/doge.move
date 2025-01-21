module 0x730f4725cc601c58e5e2d92d8ebe38475dd34ec9fc63fa2da0aa04a1900089b0::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGE>>(0x2::coin::mint<DOGE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8a6WvkVRevWM1W3HFwTPfuLMinvahxNNQb5n6VYipump.png?size=lg&key=439a0a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGE    ")))), trim_right(b"OFFICIAL DOGE                   "), trim_right(b"Department of Government Efficiency coin created by the community, we follow our leader Elon Musk.                                                                                                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGE>>(0x2::coin::mint<DOGE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

