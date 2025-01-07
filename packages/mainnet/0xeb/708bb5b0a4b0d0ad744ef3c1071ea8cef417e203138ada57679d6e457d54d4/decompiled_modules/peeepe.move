module 0xeb708bb5b0a4b0d0ad744ef3c1071ea8cef417e203138ada57679d6e457d54d4::peeepe {
    struct PEEEPE has drop {
        dummy_field: bool,
    }

    public entry fun add_to_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEEEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PEEEPE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PEEEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PEEEPE>(arg0, 2, b"PP", b"PEEEPE", b"my coin", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEEEPE>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<PEEEPE>(&mut v3, 100000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEEPE>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PEEEPE>>(v1, v4);
    }

    public entry fun remove_from_denylist(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PEEEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PEEEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

