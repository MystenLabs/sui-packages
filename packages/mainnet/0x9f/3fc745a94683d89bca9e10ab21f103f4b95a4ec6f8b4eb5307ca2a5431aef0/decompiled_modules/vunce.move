module 0x9f3fc745a94683d89bca9e10ab21f103f4b95a4ec6f8b4eb5307ca2a5431aef0::vunce {
    struct VUNCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VUNCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"93f79a6fe1ab76bc7f60a8709dac1d7e2f2436889075adaaf9a73c9e6924defc                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VUNCE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VUNCE       ")))), trim_right(b"JD Vunce                        "), trim_right(b"Vice President J.D. Vance has recently drawn attention in the U.S. political spotlight after a statement he made in an interview with USA Today. Vance said that he is ready to assume the presidency if God forbid, something terrible happens, while at the same time assuring the public that President Donald Trump remains "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VUNCE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VUNCE>>(v4);
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

