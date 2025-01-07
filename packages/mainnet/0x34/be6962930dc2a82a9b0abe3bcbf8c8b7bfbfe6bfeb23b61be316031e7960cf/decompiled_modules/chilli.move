module 0x34be6962930dc2a82a9b0abe3bcbf8c8b7bfbfe6bfeb23b61be316031e7960cf::chilli {
    struct CHILLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLI>(arg0, 6, b"CHILLI", b"CHILLIGUY ON SUI", b"Just chilling on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732211601165.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

