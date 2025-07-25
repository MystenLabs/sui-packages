module 0xdd81fc4debd8859ba262dce845de3e86aebb9f64b847cf33b37a9076b0135fdd::gtg {
    struct GTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c666cf4857747e3f0fd4e017cdd73c8bffac6995e807275041f8319fceb27584                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GTG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GTG         ")))), trim_right(b"Get The Girl                    "), trim_right(b"Get The Girl AI is  a dating simulation game on Solana / Meteora. The more your play the more it will burn. Top 50 holders earn 90% of the fees forever. Can you get the girl? Let's go all the way!                                                                                                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GTG>>(v4);
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

