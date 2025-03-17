module 0x179d1305be6fe0043f531bf609ed2b0ccbca7565b63a2fac779bafa1b4599664::vizara {
    struct VIZARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIZARA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GpSiYWkbraZerKXHnXXEdLux4wbE21xHPvPsbrdVpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VIZARA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VIZARA      ")))), trim_right(b"VIZARA                          "), trim_right(b"Vizara simplifies data analysis with an easy-to-use interface, enabling users to create stunning visualizations and uncover actionable insights in minutes. Whether you're a beginner or an expert, Vizara has you covered.                                                                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIZARA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIZARA>>(v4);
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

