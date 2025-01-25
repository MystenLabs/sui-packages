module 0x73530edf0f814f486002e20f5dc6c9b44c423a9c21733a518bdad81a569bf90c::cataia {
    struct CATAIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATAIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"AESWfFl-CnWRqreM                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CATAIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CATAI       ")))), trim_right(b"CAT AI                          "), trim_right(b"The AI cat revolutionizing DeSci, combining blockchain power with scientific breakthroughs. Driven by innovation and curiosity, $CATAI is here to disrupt traditional research models and accelerate decentralized discoveries. By integrating blockchain for transparency and AI for efficiency, $CATAI paves the way for a new"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATAIA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATAIA>>(v4);
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

