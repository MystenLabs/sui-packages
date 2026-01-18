module 0x535d9b43590dbf960cd169658e241b45cb9cc34497a7a16ff46f64cb48717f84::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MUMU>, arg1: 0x2::coin::Coin<MUMU>) {
        0x2::coin::burn<MUMU>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<MUMU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MUMU>(arg0, arg1, arg2, arg3);
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MUMU>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MUMU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/71b3e333e9f71f3c6a4b722a3fb7111aed1d9dccff93b31e2f7de28457e1e234?width=64&height=64&fit=crop&quality=95&format=auto                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<MUMU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MUMU      ")))), trim_right(b"mumu                            "), trim_right(b"                                                                                                                                                                                                                                                                                                                                "), v2, false, arg1);
        let v6 = v3;
        let v7 = &mut v6;
        let v8 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v7, 1000000000000000000, v8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUMU>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MUMU>>(v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MUMU>>(v4, 0x2::tx_context::sender(arg1));
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

