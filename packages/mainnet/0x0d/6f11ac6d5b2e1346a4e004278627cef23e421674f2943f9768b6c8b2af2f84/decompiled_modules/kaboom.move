module 0xd6f11ac6d5b2e1346a4e004278627cef23e421674f2943f9768b6c8b2af2f84::kaboom {
    struct KABOOM has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<KABOOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KABOOM>>(0x2::coin::mint<KABOOM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KABOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Cm1wUvp5x2GuSkU3F9q3GoJaFvVWExx1MH8jEscWpump.png?size=lg&key=a4c922                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<KABOOM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"KABOOM  ")))), trim_right(b"Kaboom                          "), trim_right(b"MR. Kaboom - Who Loves Buying Dips, Cause He Believes On 3 Words, Buy Buy And Buy.                                                                                                                                                                                                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KABOOM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KABOOM>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<KABOOM>>(0x2::coin::mint<KABOOM>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

