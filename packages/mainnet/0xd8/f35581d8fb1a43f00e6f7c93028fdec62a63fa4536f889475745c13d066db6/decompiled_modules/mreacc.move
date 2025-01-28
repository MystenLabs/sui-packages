module 0xd8f35581d8fb1a43f00e6f7c93028fdec62a63fa4536f889475745c13d066db6::mreacc {
    struct MREACC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MREACC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafybeia6duwh2zw6ndseg4wp54h4xdrylvogyy6mshyvsc4evdngn53a4i                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<MREACC>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MREACC  ")))), trim_right(b"MREACC Token                    "), trim_right(b"MREACC Token represents everything about effective accelerationism in all things science and technology                                                                                                                                                                                                                         "), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<MREACC>>(0x2::coin::mint<MREACC>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MREACC>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MREACC>>(v3);
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

