module 0x8c20f67038b168bc36fdec87392c272753658a59b43f266dc311848b1d7ecbb1::xxvip {
    struct XXVIP has drop {
        dummy_field: bool,
    }

    public fun add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XXVIP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<XXVIP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: XXVIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<XXVIP>(arg0, 6, b"XXVIP", b"XXVIPTOKENPOCKET", b"XXVIP Token (XXVIPTOKENPOCKET)", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<XXVIP>>(0x2::coin::mint<XXVIP>(&mut v3, 8899889000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XXVIP>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XXVIP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XXVIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<XXVIP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<XXVIP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

