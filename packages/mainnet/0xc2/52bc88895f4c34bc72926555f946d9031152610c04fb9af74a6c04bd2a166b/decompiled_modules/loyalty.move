module 0xc252bc88895f4c34bc72926555f946d9031152610c04fb9af74a6c04bd2a166b::loyalty {
    struct LOYALTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOYALTY>(arg0, 0, b"LOY", b"Talus Loyalty Token", b"Token for Loyalty US holders", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOYALTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOYALTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

