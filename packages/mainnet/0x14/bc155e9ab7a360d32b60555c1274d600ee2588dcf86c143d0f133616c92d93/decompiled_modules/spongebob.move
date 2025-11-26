module 0x14bc155e9ab7a360d32b60555c1274d600ee2588dcf86c143d0f133616c92d93::spongebob {
    struct SPONGEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6a65fdde4550aa7d5251f3740edc5de0db59ca7535ee8ff8564dbd964cde98b6                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SPONGEBOB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SPONGEBOB   ")))), trim_right(b"SpongeBob SquarePants           "), trim_right(b"SpongeBob SquarePants Fans                                                                                                                                                                                                                                                                                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGEBOB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGEBOB>>(v4);
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

