module 0x12c488536643f54c31ba735a0ca26ba984743a97a25e5e2fa0f755ccf878ddf1::macrohard {
    struct MACROHARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACROHARD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5876574c9988e2bb0ccfeee6d6ec48ba801a9145325d936140f90e6e79b72f2b                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MACROHARD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MACROHARD   ")))), trim_right(b"Macrohard                       "), trim_right(b"Macrohard, a division of xAI.                                                                                                                                                                                                                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACROHARD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACROHARD>>(v4);
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

