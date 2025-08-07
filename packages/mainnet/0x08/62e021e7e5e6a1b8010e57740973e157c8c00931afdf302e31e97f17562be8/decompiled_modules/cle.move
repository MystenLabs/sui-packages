module 0x862e021e7e5e6a1b8010e57740973e157c8c00931afdf302e31e97f17562be8::cle {
    struct CLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"8774c88ffb0e4e2b4a8802100c5aa6091068a7eba5d84ca6b32bb57b5eb613ce                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CLE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CLE         ")))), trim_right(b"CLEONS                          "), trim_right(b"Empire-born. Meme-forged. $CLE is the dynasty token rewriting the rules of power, value, and virality.                                                                                                                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLE>>(v4);
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

