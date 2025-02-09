module 0xd968b8f0b90d94def3b23f9dd52c53fe48baebb5796594a041748ee827d10c2a::freegazaa {
    struct FREEGAZAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEGAZAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"7YlLl6LCgUWrKfED                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FREEGAZAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FREEGAZA    ")))), trim_right(b"GAZA                            "), trim_right(b"Free Gaza Coin is a digital token designed to raise awareness and support for the people of Gaza. By creating a decentralized and transparent platform, this coin aims to mobilize global support, promote humanitarian initiatives, and highlight the urgent need for peace and justice. Every transaction contributes to a gre"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEGAZAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEGAZAA>>(v4);
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

