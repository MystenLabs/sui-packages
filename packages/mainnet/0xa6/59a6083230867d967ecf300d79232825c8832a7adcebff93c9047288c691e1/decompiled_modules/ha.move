module 0xa659a6083230867d967ecf300d79232825c8832a7adcebff93c9047288c691e1::ha {
    struct HA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HA>(arg0, 6, b"Ha", b"Hahaha", b"Please don't buy....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731644538824.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

