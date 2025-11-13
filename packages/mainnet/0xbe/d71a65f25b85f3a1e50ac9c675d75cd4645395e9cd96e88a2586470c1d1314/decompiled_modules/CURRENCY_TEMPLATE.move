module 0xbed71a65f25b85f3a1e50ac9c675d75cd4645395e9cd96e88a2586470c1d1314::CURRENCY_TEMPLATE {
    struct CURRENCY_TEMPLATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURRENCY_TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CURRENCY_TEMPLATE>(arg0, 9, 0x1::string::utf8(b"BRD2"), 0x1::string::utf8(b"bread2"), 0x1::string::utf8(b"Fixed supply token named Bread2"), 0x1::string::utf8(b""), arg1);
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

