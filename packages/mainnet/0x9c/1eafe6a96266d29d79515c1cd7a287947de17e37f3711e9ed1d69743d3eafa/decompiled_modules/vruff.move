module 0x9c1eafe6a96266d29d79515c1cd7a287947de17e37f3711e9ed1d69743d3eafa::vruff {
    struct VRUFF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VRUFF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VRUFF>>(0x2::coin::mint<VRUFF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VRUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0x310d4351e61ef0718a42f1fd3a544d7d2a3202a9.png?size=lg&key=846e46                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VRUFF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VRUFF   ")))), trim_right(b"VRUFF by Virtuals               "), trim_right(b"Vruff | The loyal and unstoppable spirit of the $VIRTU community | Always watching, always part of the journey                                                                                                                                                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VRUFF>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VRUFF>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<VRUFF>>(0x2::coin::mint<VRUFF>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

