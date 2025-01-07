module 0x63748c35fddb1ffafbdfc6064276e020fc7f11759ea3471c1c8cb1717148675e::brainchip {
    struct BRAINCHIP has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BRAINCHIP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BRAINCHIP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BRAINCHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BRAINCHIP>(arg0, 6, b"BRAINCHIP", b"", b"", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAINCHIP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINCHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BRAINCHIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BRAINCHIP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BRAINCHIP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

