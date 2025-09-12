module 0xfea33357b937f323f6b85c1e9524a3b7c94e7daa1f003f4c9514d0392133f553::borb {
    struct BORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c4b5f4f08f743d6733f827d715d72699bd68a3792e05b336f6f5130ae33f736c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BORB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"borb        ")))), trim_right(b"borb                            "), trim_right(b"borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb borb                                                                                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORB>>(v4);
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

