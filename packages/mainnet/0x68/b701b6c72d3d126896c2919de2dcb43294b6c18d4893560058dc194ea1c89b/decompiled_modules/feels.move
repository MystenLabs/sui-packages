module 0x68b701b6c72d3d126896c2919de2dcb43294b6c18d4893560058dc194ea1c89b::feels {
    struct FEELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEELS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"04ffff9b42c0d60de9fefed8d6e5d7eb03244f27a98544ac0e7d67941ae1dacf                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FEELS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FEELS       ")))), trim_right(b"The 'Feels Guy'                 "), trim_right(b"Feels Guy ($FEELS) is an OG token on Pumpfun inspired by the legendary Wojak, the internets embodiment of raw emotion. Born from the feels-era of meme culture, $FEELS captures the highs and lows of crypto  joy, regret, hope, and despair  all in one coin. Its not just a token; its a mood.                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEELS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEELS>>(v4);
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

