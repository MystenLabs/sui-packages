module 0x33d54f48c1b47b8c280168e0611e68266f7abde81d1c9b0c4bf12850f4f31415::ptsd {
    struct PTSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTSD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"14149f78d172f79f4d1f97964cb8dba3d41b59408b67965b34e188c3d10980d4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PTSD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PTSD        ")))), trim_right(b"Veterans Edition                "), trim_right(b"The VA rugged him. Pump.Fun didnt. Real Homeless Vet makes coin straight from the cardboard frontlines. Donation wallet for homeless vets: FxC5SLEbT392HzTvDQiQtXkwUWpPPwxz2ASrRUbp4biX                                                                                                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTSD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTSD>>(v4);
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

