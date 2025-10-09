module 0x1349037cfad8429b302b0578f927cb6f8fb1dfa56a4fd1e84c38f51e32f307f7::falon {
    struct FALON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3f7aa6810caa4ff9a68d56a893497ee744fa0566d7b7e13f4a8c94b034d5def1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FALON>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FALON       ")))), trim_right(b"Fart Alon                       "), trim_right(x"2446617274636f696e2069732073697474696e67206174206120243634304d206d61726b6574206361702020616e642077652063616e20646f207468652073616d652e0a0a457665727920776f72642028616e642066617274292066726f6d20416c6f6e206c69667473206f7572206d61726b6574206361702c20616e64206576657279206275792070757368657320757320746f206e65772068696768732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALON>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FALON>>(v4);
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

