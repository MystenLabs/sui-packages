module 0x1163f2eda75e660146972a54c01626db6ef44e21a282a38283eea804fad09553::snail {
    struct SNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAIL>(arg0, 6, b"SNAIL", b"SuiSnail", b"Sui Snail is The muscular snail who loves to work out and the strongest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730998058081.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

