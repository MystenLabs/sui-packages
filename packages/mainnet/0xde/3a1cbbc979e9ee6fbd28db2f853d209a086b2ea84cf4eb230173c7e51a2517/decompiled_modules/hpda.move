module 0xde3a1cbbc979e9ee6fbd28db2f853d209a086b2ea84cf4eb230173c7e51a2517::hpda {
    struct HPDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"04437d4f665317f7910b9f13ccef3662922b2d9e61fd2edff8caa759158e9499                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HPDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HPDA        ")))), trim_right(b"Heropanda                       "), trim_right(b"HeroPanda is done watching the endless stream of derivative Inu coins. Its time for the internets most iconic meme to reclaim the throne. $HEROPANDA is here to make memecoins great again: stealth-launched, no presale, zero taxes, LP burnt, and contract renounced. Fueled by pure meme power, $HEROPANDA is a coin for the "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPDA>>(v4);
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

