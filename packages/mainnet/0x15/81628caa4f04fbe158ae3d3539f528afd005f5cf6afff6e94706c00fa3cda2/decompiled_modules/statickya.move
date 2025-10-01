module 0x1581628caa4f04fbe158ae3d3539f528afd005f5cf6afff6e94706c00fa3cda2::statickya {
    struct STATICKYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STATICKYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5bf93a47ff5771e980a39bfeead774c8b1c9f1d3ab0f85bba78a00765be8fe4f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STATICKYA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"StatiCKy    ")))), trim_right(b"StatiCKy                        "), trim_right(x"2050726f6a656374204f626a6563746976653a0a0a373025206f6620666565732020737570706f727420262070726f6d6f74652024676962200a4067696274686566726f6763746f0a0a323025206f6620666565732020737472656e677468656e20245374617469434b7920286d6f726520766f6c756d652c206d6f7265206665657320666f722024676962290a0a313025206f6620666565732020636f6e74656e74206372656174696f6e2c207765622064657620262072656c6174656420657870656e7365730a0a5472616e73706172656e63792c20636f6d6d756e69747920262067726f77746820746f6765746865722020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STATICKYA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STATICKYA>>(v4);
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

