module 0x5d944a61583bbf8d251e1087603c1f508e03a11548acb03d0e5044b226e52d55::kony {
    struct KONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"EaDfZF4BmqZK4Xod                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KONY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KONY        ")))), trim_right(b"KONY 2025                       "), trim_right(b"In 2025, the imperative to capture Joseph Kony remains as urgent as ever, given his long-standing role as the leader of the Lord's Resistance Army (LRA), a group notorious for committing heinous war crimes and crimes against humanity across multiple countries in Central Africa. Kony's forces have been responsible for t"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KONY>>(v4);
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

