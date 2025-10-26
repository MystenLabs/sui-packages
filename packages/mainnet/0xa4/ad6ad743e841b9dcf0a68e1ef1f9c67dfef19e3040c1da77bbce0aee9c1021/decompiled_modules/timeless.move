module 0xa4ad6ad743e841b9dcf0a68e1ef1f9c67dfef19e3040c1da77bbce0aee9c1021::timeless {
    struct TIMELESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMELESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e45249bf86642ade682da100959128ae2fa62fea37b624c561ef85636db8e2be                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TIMELESS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Timeless    ")))), trim_right(b"Timeless                        "), trim_right(b"No roadmap, no expiry date, just a community that refuses to age out of the moment.                                                                                                                                                                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMELESS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIMELESS>>(v4);
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

