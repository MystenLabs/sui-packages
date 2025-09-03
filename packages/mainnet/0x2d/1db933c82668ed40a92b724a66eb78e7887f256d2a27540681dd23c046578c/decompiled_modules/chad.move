module 0x2d1db933c82668ed40a92b724a66eb78e7887f256d2a27540681dd23c046578c::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"a540737f5b17fd6031020e669fba707d79111029604994b5819534d49baaeba7                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHAD        ")))), trim_right(b"Chad Thundercock                "), trim_right(b"$Chad Thunder-cock is his name. His directive to gather the strength of all Chadom from all corners of the globe into one coin.                                                                                                                                                                                                 "), v2, arg1);
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

