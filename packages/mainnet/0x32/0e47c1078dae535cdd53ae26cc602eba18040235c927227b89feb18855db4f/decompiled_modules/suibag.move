module 0x320e47c1078dae535cdd53ae26cc602eba18040235c927227b89feb18855db4f::suibag {
    struct SUIBAG has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBAG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIBAG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIBAG>(arg0, 9, b"SUIBAG", b"SUIBAG", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIBAG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBAG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIBAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBAG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIBAG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

