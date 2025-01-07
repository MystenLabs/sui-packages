module 0xdcd4d8a396952d3bb16ed1cf7564f8a2d573b6937536e9deec4a8f689ba4b8af::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"11111111    ");
        let v1 = trim_right(b"https://gateway.irys.xyz/0MdZ2O8j2pFPvYeYab6kdXXZjZQ-sDhoBz56EZeHHJ8                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<USDC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"USDC    ")))), trim_right(b"USD Coin                        "), trim_right(b"USD Coin (USDC) is a fully collateralized stablecoin backed by the US dollar, which provides detailed financial and operational transparency, operates within the framework of US currency circulation laws, and cooperates with multiple banking institutions and audit teams.                                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v4);
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

