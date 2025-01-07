module 0xc87f323279b821ee5ab702d8d55f9a2c44355318666577e63130608cb951d91e::aaaaaaaaa {
    struct AAAAAAAAA has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAAAAAAAA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AAAAAAAAA>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: AAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"RDECIM      ");
        let v1 = trim_right(b"RICONU                                                                                                                                                                                                                                                                                                                          ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<AAAAAAAAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RSYMBL  ")))), trim_right(b"RNAMEE                          "), trim_right(b"RDESCR                                                                                                                                                                                                                                                                                                                          "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAAAAAAA>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AAAAAAAAA>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<AAAAAAAAA>>(0x2::coin::mint<AAAAAAAAA>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AAAAAAAAA>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAAAAAAAA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AAAAAAAAA>(arg0, arg1, arg2, arg3);
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

