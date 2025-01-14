module 0xd880088915af19bf7b5c7052f931e74645d60590e87c0bdb6610200a90f107d0::mdogai {
    struct MDOGAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MDOGAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MDOGAI>>(0x2::coin::mint<MDOGAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MDOGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0xd81cb23a4690f7fdf54e583f221d2c01882604f8.png?size=lg&key=5ffa95                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MDOGAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MDOGAI  ")))), trim_right(b"MoonDog AI                      "), trim_right(b"The platform's core feature is MoonDog, an AI Trading Co-Pilot that provides real-time market analysis, identifies high-probability trading setups, and offers personalized trading recommendations.                                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDOGAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MDOGAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MDOGAI>>(0x2::coin::mint<MDOGAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

