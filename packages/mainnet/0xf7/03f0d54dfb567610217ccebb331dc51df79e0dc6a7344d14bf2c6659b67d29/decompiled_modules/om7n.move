module 0xf703f0d54dfb567610217ccebb331dc51df79e0dc6a7344d14bf2c6659b67d29::om7n {
    struct OM7N has drop {
        dummy_field: bool,
    }

    fun init(arg0: OM7N, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CB48KiK1oi1tWtjmPWxVR2NPeEr9ewzmZQ8ERk79Ue4b.png?size=lg&key=e3d4b7                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OM7N>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OM7n    ")))), trim_right(b"OM7n                            "), trim_right(b"Starting the emoji-fi meta on SUI                                                                                                                                                                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OM7N>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OM7N>>(v4);
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

