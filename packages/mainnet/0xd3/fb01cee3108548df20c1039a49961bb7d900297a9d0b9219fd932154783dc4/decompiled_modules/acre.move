module 0xd3fb01cee3108548df20c1039a49961bb7d900297a9d0b9219fd932154783dc4::acre {
    struct ACRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACRE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EnkX6srABWk71UteivKpLYeLqcXYifgzfHTd6UbCbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ACRE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ACRE        ")))), trim_right(b"The Acre                        "), trim_right(b"The ACRE is an AI-powered real estate protocol that brings global property ownership on-chain. Using big data and machine learning, it delivers real-time land valuations and enables trustless, borderless property transactions. The platform transforms land into a programmable, accessible asset class  unlocking new possi"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACRE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACRE>>(v4);
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

