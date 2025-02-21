module 0x346671d93a4f4b2ccf3abc84ef235ce98a33e768b3c8b2f60ddf9b8ae2031914::pickle {
    struct PICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafkreiengtndwp5znngu7d5fgnn33xtz2hinkyrnlcrw5egf5wp2zf5iq4                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<PICKLE>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PIckle  ")))), trim_right(b"Pickle Power Token              "), trim_right(b"The ultimate degen token that fuels Degen Pickle Ricks wild trades toxic engagement and insane 100x calls where holders get access to exclusive shitcoin insights degen alpha and pump and dump signals before the exit liquidity arrives No weak hands only giga gains                                                         "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<PICKLE>>(0x2::coin::mint<PICKLE>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PICKLE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PICKLE>>(v3);
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

