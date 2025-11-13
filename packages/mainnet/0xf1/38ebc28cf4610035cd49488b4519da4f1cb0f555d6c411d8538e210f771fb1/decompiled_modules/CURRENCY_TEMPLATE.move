module 0xf138ebc28cf4610035cd49488b4519da4f1cb0f555d6c411d8538e210f771fb1::CURRENCY_TEMPLATE {
    struct CURRENCY_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURRENCY_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CURRENCY_TEMPLATE>(arg0, 9, 0x1::string::utf8(b"BREAD"), 0x1::string::utf8(b"Bread"), 0x1::string::utf8(b"A fixed-supply utility token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CURRENCY_TEMPLATE>>(0x2::coin_registry::finalize<CURRENCY_TEMPLATE>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CURRENCY_TEMPLATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

