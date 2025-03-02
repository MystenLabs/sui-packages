module 0xb8cae13a6056c3ead41ac32fdea5862ab277859cb46a3041a06328ff4ff780d5::geisha {
    struct GEISHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEISHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Aj5zJip93c4pCLB7yway8NpT6yy9XMf5rYKc3gwApump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GEISHA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GEISHA      ")))), trim_right(b"Geisha                          "), trim_right(b"A geisha is a traditional Japanese female entertainer who performs various arts such as classical music, dance, and poetry for guests, often at tea houses or during special events. The term \"geisha\" translates to \"artist\" or \"performing artist\" in Japanese, derived from \"gei\" (art) and \"sha\" (person)                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEISHA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEISHA>>(v4);
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

