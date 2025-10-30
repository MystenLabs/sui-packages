module 0xd319c3a3d1b315601d2a53e327af078f0c70b0b3eeb8ecec2d7d05df64712e8e::waymo {
    struct WAYMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAYMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"65a422bbbbae0f10ce7d77b670a73d3ba499485025c4cb2ea0211d725de63b71                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WAYMO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Waymo       ")))), trim_right(b"Kitkat Killer                   "), trim_right(b"Waymo is the KitKat Killer  On Oct 27, a Waymo driverless car ran over KitKat, the beloved 9-year-old SF bodega cat. Locals built a memorial with KitKats and signs reading: Kill a Waymo! Save a Cat! No to driverless cars.                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAYMO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAYMO>>(v4);
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

