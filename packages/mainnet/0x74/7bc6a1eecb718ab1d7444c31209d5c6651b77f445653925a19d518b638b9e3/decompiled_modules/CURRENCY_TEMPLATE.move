module 0x747bc6a1eecb718ab1d7444c31209d5c6651b77f445653925a19d518b638b9e3::CURRENCY_TEMPLATE {
    struct CURRENCY_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURRENCY_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CURRENCY_TEMPLATE>(arg0, 9, 0x1::string::utf8(b"BREAD"), 0x1::string::utf8(b"Bread"), 0x1::string::utf8(b"Bread Token - A fixed-supply utility token for the Sui ecosystem."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CURRENCY_TEMPLATE>>(0x2::coin_registry::finalize<CURRENCY_TEMPLATE>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CURRENCY_TEMPLATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

