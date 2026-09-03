module 0x6ff4b6f7e548d20a7e95dd6f0088c02d17343cb5e9b76e0638a23000b327e258::lpgenital {
    struct LPGENITAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPGENITAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPGENITAL>(arg0, 6, b"LPGENITAL", b"Genital Wealth", b"yup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPGENITAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPGENITAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

