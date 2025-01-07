module 0xd8547e89c8989674fef02c042c3df1803f70215317c986f622b8ad51b24e51e::skipnut {
    struct SKIPNUT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SKIPNUT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SKIPNUT>>(0x2::coin::mint<SKIPNUT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SKIPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FG37QgnBBTSYroGpJTvfDuuq8e8CZSCQhMLTom3Ypump.png?size=lg&key=d14314                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SKIPNUT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SKIPNUT ")))), trim_right(b"Skimask Pnut                    "), trim_right(b"Nut up or shut up! Are you ready for the wildest Takeover base has ever seen! Stack those Nuts to the Sky! Masked up and ready for the Big ONE, Pnut Style! Get your furry friend lovers and lets stash these nuts til Coinbase starts packing!                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKIPNUT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SKIPNUT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<SKIPNUT>>(0x2::coin::mint<SKIPNUT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

