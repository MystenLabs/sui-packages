module 0x5913ed90dd561ed7e7588e81a5d242566ced026e03669b9324035ca00256e24d::wtbs {
    struct WTBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTBS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/-dcENeoqtThh6DqvDniixRYXqyY1uEjXq44ZRCj16z8";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/-dcENeoqtThh6DqvDniixRYXqyY1uEjXq44ZRCj16z8"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<WTBS>(arg0, 9, trim_right(b"WTBS"), trim_right(b"WaiTaoBiSui"), trim_right(b"WaiTaoBiSui is a virtual currency similar to Bitcoin, which does not have currency attributes such as legal tender and compulsory"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTBS>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WTBS>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTBS>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

