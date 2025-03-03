module 0x4211a4ba3bf0d26762dedd71d9a7536ae4082afdb5823729e4800bf4f1a25841::dogee {
    struct DOGEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://firebasestorage.googleapis.com/v0/b/pumpisland-32099.firebasestorage.app/o/uploads%2F888-1740973382426.webp?alt=media&token=97d20510-abd0-465c-b97a-2cba0c1098a7                                                                                                                                                        ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGEE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGEE   ")))), trim_right(b"dogee                           "), trim_right(b"88888888888888888888888888                                                                                                                                                                                                                                                                                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEE>>(v4);
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

