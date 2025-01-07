module 0x444caa32838c0ab95819ded34c08dbc1935c33cf0b0c224b1a7732c0f4cb6052::zygo {
    struct ZYGO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZYGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZYGO>>(0x2::coin::mint<ZYGO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZYGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xee2b9b7e168b5b2d40c507b891c7cfb13a6aaf2b.png?size=lg&key=1321a3                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZYGO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZYGO    ")))), trim_right(b"Zygo The Frog                   "), trim_right(b"Zygo was born in the quiet, serene waters of Lily Pad Pond, alongside countless other tadpoles. This adventurous spirit and resilience form the backbone of the Zygo token and ecosystem, offering users a unique blend of digital finance and animated storytelling                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYGO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZYGO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZYGO>>(0x2::coin::mint<ZYGO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

