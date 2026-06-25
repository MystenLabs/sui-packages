module 0x63791d044d7eb76c0777a7c64a8ff8c522ed79abd57a4dd3ef3381e9da7390a1::regulated_coin {
    struct REGULATED_COIN has drop {
        dummy_field: bool,
    }

    public entry fun deny(arg0: &mut 0x2::coin::DenyCapV2<REGULATED_COIN>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<REGULATED_COIN>(arg1, arg0, arg2, arg3);
    }

    fun init(arg0: REGULATED_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<REGULATED_COIN>(arg0, 9, b"RUSD", b"Regulated USD", b"Regulated closed-loop coin for exchange deposit detection testing", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REGULATED_COIN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<REGULATED_COIN>>(v1, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGULATED_COIN>>(v2);
    }

    public entry fun mint_to(arg0: &mut 0x2::coin::TreasuryCap<REGULATED_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGULATED_COIN>>(0x2::coin::mint<REGULATED_COIN>(arg0, arg1, arg3), arg2);
    }

    public entry fun undeny(arg0: &mut 0x2::coin::DenyCapV2<REGULATED_COIN>, arg1: &mut 0x2::deny_list::DenyList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<REGULATED_COIN>(arg1, arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

