module 0xc3307afeb05df57d7e68d491ce53f1457ad3971640c60634ce84dbba00b21c59::CURRENCY_TEMPLATE {
    struct CURRENCY_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURRENCY_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CURRENCY_TEMPLATE>(arg0, 9, 0x1::string::utf8(b"BRD2"), 0x1::string::utf8(b"bread2"), 0x1::string::utf8(b"Template currency for deployment"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CURRENCY_TEMPLATE>>(0x2::coin_registry::finalize<CURRENCY_TEMPLATE>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CURRENCY_TEMPLATE>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURRENCY_TEMPLATE>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURRENCY_TEMPLATE>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

