module 0x38672ea10106bb07492d74330019585445c4ad605adcdc3fed345c44f74c7b4a::axis {
    struct AXIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/pulsechain/0x8bdb63033b02c15f113de51ea1c3a96af9e8ecb5.png?size=lg&key=c23b47                                                                                                                                                                                                          ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AXIS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AXIS    ")))), trim_right(b"AxisAlive                       "), trim_right(b"we're passionate about educating the next generation of crypto enthusiasts. That's why we've created the AxisAlive ($AXIS) token, a unique educational tool designed to help students grasp the intricacies of technical analysis, chain analysis, and liquidity provision/analysis.                                            "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXIS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXIS>>(v4);
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

