module 0x403c8acc9c5db61faf42f3329c0549a3aa44c294a61dfdc5bdef3ad3087c9580::smileman {
    struct SMILEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6ttH9AbqPqxCPk5G7BN6JBrQbuyrGiorNkSupd4tpump.png?size=lg&key=a55719                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SMILEMAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SMILEMAN")))), trim_right(b"SMILEMAN                        "), trim_right(b"Yo, its SMILEMAN in the building  the OG of good vibes, slick moves, and now tokens? Yup, you heard me right. Ive been rocking hoodies, spreading smiles, and flexing this swag for a minute, but this this is my next-level flex.                                                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILEMAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMILEMAN>>(v4);
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

