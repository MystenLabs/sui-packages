module 0x154ded53c03b0c253b88ebc90cec32b685e1001d3b889c690b79bc800561096f::snag {
    struct SNAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAG>(arg0, 6, b"SNAG", b"Snag", b"Legendary snag.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731116815072.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

