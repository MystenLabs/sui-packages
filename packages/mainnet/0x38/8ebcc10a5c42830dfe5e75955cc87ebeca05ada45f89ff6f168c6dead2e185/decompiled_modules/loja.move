module 0x388ebcc10a5c42830dfe5e75955cc87ebeca05ada45f89ff6f168c6dead2e185::loja {
    struct LOJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOJA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://gateway.irys.xyz/1Ms5W17CgDiv1o_0zKs_cqdCPBY2TgyvtqzEyYUSUyE                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LOJA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LOJA    ")))), trim_right(b"LOJA COIN                       "), trim_right(b"Loja Coin is a cryptocurrency on the SUI blockchain that provides innovative marketing tools for merchants. Customers earn freely tradable tokens based on purchases. This project fosters a shared token reward ecosystem across merchants, helping physical retailers boost sales growth.                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOJA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOJA>>(v4);
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

