module 0xb036c1e7b006d16f8204f2bf25ee794e463a511bd969625b63ea57bb2f3f0f32::snakt {
    struct SNAKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9_BUiYbRrahfnwQp                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SNAKT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SNAKT       ")))), trim_right(b"Sna-King Trump                  "), trim_right(b"Just when everyone was excited about Trump becoming president of the United States to make crypto great again somthing out of this world happened! When no one was looking at the inauguration in 2025 a snake bit President Trump. After a little he turned in somthing no one could have inmagined. He became the ruler of sna"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKT>>(v4);
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

