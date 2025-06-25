module 0xa79911041dc9444e3208bff09408b95075e2f8cccc62a5e3514e1ba2cfa85a42::chefcoina {
    struct CHEFCOINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEFCOINA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BTG7K7hxPKgoD2asfEPxAvfXfNqbdgcQfBhh1deSpump.png?claimId=h9FfN24MbUD3nJuY                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHEFCOINA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ChefCoin    ")))), trim_right(b"ChefCoin                        "), trim_right(b"Meet the CTO of ChefCoin  a genius monkey chef stirring up code like it's gourmet stew. Armed with a frying pan and a vision, he's cooking up the spiciest memecoin on Solana. Zero tax, full flavor, and absolutely no rug recipes allowed.                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEFCOINA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEFCOINA>>(v4);
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

