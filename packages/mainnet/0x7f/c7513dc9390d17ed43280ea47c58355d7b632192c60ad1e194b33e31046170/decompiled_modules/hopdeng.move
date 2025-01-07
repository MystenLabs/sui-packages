module 0x7fc7513dc9390d17ed43280ea47c58355d7b632192c60ad1e194b33e31046170::hopdeng {
    struct HOPDENG has drop {
        dummy_field: bool,
    }

    public entry fun add_to_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HOPDENG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<HOPDENG>(arg0, arg1, arg2, arg3);
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HOPDENG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        add_to_denylist(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HOPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<HOPDENG>(arg0, 2, b"hopdeng", b"hopdeng", b"hopdengee FIRST DENG ON HOP FUN", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPDENG>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<HOPDENG>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDENG>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<HOPDENG>>(v1, v4);
    }

    public entry fun remove_from_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<HOPDENG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<HOPDENG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

