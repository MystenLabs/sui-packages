module 0x3b9bbd2c2312ac1b47deb505f7fcb8ca97dc7a268d909ac49a7bb79ca97a17fe::xxi {
    struct XXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/pW3Klx1m7thYfjw9oAmJY6X0B-f8HD0ucTir_6uvkWE";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/pW3Klx1m7thYfjw9oAmJY6X0B-f8HD0ucTir_6uvkWE"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XXI>(arg0, 9, trim_right(b"XXI"), trim_right(b"XXI  "), trim_right(b"31854"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXI>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XXI>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXI>>(v4);
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

