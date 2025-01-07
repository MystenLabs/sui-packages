module 0x2f5137cc6c69e2af05c7577e0ca06b172ac6cee3037cbe4fce4444b4f5669abc::wally {
    struct WALLY has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WALLY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WALLY>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: WALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x4f7d2d728ce137dd01ec63ef7b225805c7b54575.png?size=lg&key=85c5b0                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<WALLY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WALLY   ")))), trim_right(b"Emotional Support Alligator     "), trim_right(b"Wally The Emotional Support Alligator. Wally, the famous Emotional Support Alligator, first captured headlines when he was rescued from an alligator-infested pond at Disney World, and later became recognized as the world's first registered Emotional Support alligator.                                                    "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALLY>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WALLY>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<WALLY>>(0x2::coin::mint<WALLY>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WALLY>>(v4, 0x2::tx_context::sender(arg1));
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

