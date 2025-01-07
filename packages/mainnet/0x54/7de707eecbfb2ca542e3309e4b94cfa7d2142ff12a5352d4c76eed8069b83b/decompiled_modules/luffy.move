module 0x547de707eecbfb2ca542e3309e4b94cfa7d2142ff12a5352d4c76eed8069b83b::luffy {
    struct LUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUFFY>(arg0, 6, b"LUFFY", b"SuiOnePiece", b"SuiOnePiece (LUFFY)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731098236103.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUFFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUFFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

