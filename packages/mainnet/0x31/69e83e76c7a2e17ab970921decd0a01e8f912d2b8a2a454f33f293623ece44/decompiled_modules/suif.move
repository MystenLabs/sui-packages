module 0x3169e83e76c7a2e17ab970921decd0a01e8f912d2b8a2a454f33f293623ece44::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FSuif500x500_04f4da93fe.png&w=640&q=75                                                                                                                                                                                                           ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUIF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Suif    ")))), trim_right(b"Suiba Wif Hat                   "), trim_right(b"Suiba Wif Hat $SUIF is here to take on the world with smiles and cuteness! His name is Suif                                                                                                                                                                                                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIF>>(v4);
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

