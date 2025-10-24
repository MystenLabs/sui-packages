module 0x9f99e7933d7d68ca62d07f5cae0cbb07e4a75d0ce66d6847dd7fa3243c46d8c7::baas {
    struct BAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"b8c3d2a47ba044935d45e60195e83ef37c423f3813ceb9c5a9f550c1807fae28                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BAAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BAAS        ")))), trim_right(b"Bagholding as a Service         "), trim_right(b"At BaaS, we believe bagholding isn't a weakness  it's a service layer. Our decentralized protocol leverages regret, denial, and hopium to provide institutional-grade holding solutions.                                                                                                                                        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAAS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAAS>>(v4);
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

