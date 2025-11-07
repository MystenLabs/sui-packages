module 0xe91d5d3968eae0021d157799a4d194b70d86f9eb8754e1c28d1c6be9bf721d7a::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"92bd682edb6a5ac12ceee26927ef2b9abf5ca84d454a30ce620c939476d2325b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Chad        ")))), trim_right(b"Yes Chad                        "), trim_right(b"The term became a viral meme in the 2010s after appearing on the online messaging board 4chan under the name \"Chad Thundercock\". Chad is described as a heterosexual, White male, usually blond-haired, who is gainfully employed, athletic, sexually active, and well-endowed. One of the most iconic memes of all time        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v4);
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

