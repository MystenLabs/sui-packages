module 0x28443963dfcbcb38b41fe11109019988208a5044d06792d2e91fbc7636af7bf9::bunnie {
    struct BUNNIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c02b93ee8dbaafe5352e1f3a4fb47fc38a6ef9b7c04f81959db4ee1c903fbc06                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUNNIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUNNIE      ")))), trim_right(b"Bunnie                          "), trim_right(b"Bunnie is a bright, adventurous bunny who loves exploring new places and discovering hidden wonders. With endless curiosity and a heart full of dreams, he's always chasing the next great mystery waiting just beyond the horizon.                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNIE>>(v4);
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

