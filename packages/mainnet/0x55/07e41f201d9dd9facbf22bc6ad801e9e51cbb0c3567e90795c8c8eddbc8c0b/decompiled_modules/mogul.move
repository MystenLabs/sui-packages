module 0x5507e41f201d9dd9facbf22bc6ad801e9e51cbb0c3567e90795c8c8eddbc8c0b::mogul {
    struct MOGUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGUL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://media.licdn.com/dms/image/v2/C510BAQEO2q28VTKmYg/company-logo_200_200/company-logo_200_200/0/1630571721060?e=1747267200&v=beta&t=OLGx15S1n42i-Pw686bhzxLvgdxzloGV9pALrBHpEyA                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOGUL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Mogul   ")))), trim_right(b"Mogul AI Property               "), trim_right(b"Singapores New Age Property Portal                                                                                                                                                                                                                                                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGUL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGUL>>(v4);
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

