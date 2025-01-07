module 0x897b79f614d4132ba0d3f0b13ee8409dcfd7f617ef459ab472e694a2d48f708f::bond {
    struct BOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOND>(arg0, 6, b"BOND", b"Trust the Curve CTO", b"Trust the curve and let it run.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734909814105.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

