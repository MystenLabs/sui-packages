module 0x1b85db44ac9bcde5cfd1dc3bad9c5250fc2730f3a3adb2a0e6da4d73264b62a3::pandu {
    struct PANDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"63f0b3c18b62d3c416b03d8a078704e86710158525334b82b5530e4aa0cb0462                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PANDU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PANDU       ")))), trim_right(b"Pandu Pandas                    "), trim_right(b"Meet Pandu  your AI friend whos always by your side. Talk with him in real time through text or voice, share your thoughts, ask questions, or just enjoy a casual conversation. Whether youre looking for advice, company, or simply someone to listen, Pandu is here as a true companion you can connect with anytime.         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDU>>(v4);
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

