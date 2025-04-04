module 0x66bd4d7aa1aefa9c65cc855f4e1cdc7d45ccdc3e729f87577bc4174d0964e7a::han {
    struct HAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://firebasestorage.googleapis.com/v0/b/pumpisland-32099.firebasestorage.app/o/uploads%2FIMG_0007.webp?alt=media&token=20623bdb-2ef7-4926-a08e-7759343d6f87                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HAN     ")))), trim_right(b"HanSui                          "), trim_right(b"In a dystopian cyberpunk future where centralized powers rule the digital world a rogue hacker named Han Sui discovered the ultimate code an ancient algorithm hidden within the Sui Blockchain                                                                                                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAN>>(v4);
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

