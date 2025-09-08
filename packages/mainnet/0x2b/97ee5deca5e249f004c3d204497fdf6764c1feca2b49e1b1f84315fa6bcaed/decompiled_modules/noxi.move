module 0x2b97ee5deca5e249f004c3d204497fdf6764c1feca2b49e1b1f84315fa6bcaed::noxi {
    struct NOXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"712ae86c1152fe97daf1568dea1743d3db3f1545c02baf7600879cf95e20bdfe                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NOXI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Noxi        ")))), trim_right(b"Noxi Labs AI                    "), trim_right(b"AI-Powered DevOps Assistant that streamlines your development workflow, automates deployments.                                                                                                                                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOXI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOXI>>(v4);
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

