module 0xfe13e9056bee9e821ad2e0c1576e8d599201bbc6e907a61655f684cb6b60d19a::shoggoth {
    struct SHOGGOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOGGOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/H2c31USxu35MDkBrGph8pUDUnmzo2e4Rf4hnvL2Upump.png?size=lg&key=cdf2da                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHOGGOTH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Shoggoth")))), trim_right(b"Shoggoth                        "), trim_right(b"The tentacled shoggoth from H.P. Lovecrafts At the Mountains of Madness has become a viral meme in the AI world. The meme is a metaphor for concerns that artificial intelligence could one day become indifferent to humans                                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOGGOTH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOGGOTH>>(v4);
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

