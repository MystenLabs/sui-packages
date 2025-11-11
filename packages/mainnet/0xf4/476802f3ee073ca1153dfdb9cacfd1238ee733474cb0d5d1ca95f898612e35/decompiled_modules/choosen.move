module 0xf4476802f3ee073ca1153dfdb9cacfd1238ee733474cb0d5d1ca95f898612e35::choosen {
    struct CHOOSEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOOSEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"393208cb8bc31f9d0ddfe6d555eb3f34a4e495890d2dad56da0334e7051912c0                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHOOSEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Choosen     ")))), trim_right(b"Choosen Systems Privacy         "), trim_right(b"The Choosen System - Blockchains have decentralized money. Choosen decentralizes informationits trust, ownership, discoverability, and monetizationso more of humanitys Choosen can flow into the world.                                                                                                                        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOOSEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOOSEN>>(v4);
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

