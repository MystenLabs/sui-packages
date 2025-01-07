module 0x419a986818ff05ac17108082788c22954e99ba19ae4c8d726d51c9a82d0dff3f::dchef {
    struct DCHEF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DCHEF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DCHEF>>(0x2::coin::mint<DCHEF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DCHEF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Eoo3LNvzyMm5K1jfwY7PkSdxBSBgXYJJ7DERTdFBpump.png?size=lg&key=702c8a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DCHEF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DChef   ")))), trim_right(b"DChefSui                        "), trim_right(b"Chef is a community-driven project that celebrates food as a global connectorblending cultures, memes, and the degen spirit. At its core is a relentless Sphynx cat chef, hustling to become the worlds most Degen Celebrity Chef with his own five-star restaurant.                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCHEF>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DCHEF>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DCHEF>>(0x2::coin::mint<DCHEF>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

