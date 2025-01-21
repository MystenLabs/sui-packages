module 0x8c811bb54824c8b93f1afcf2785c31b4bf9a9840e719f090b60eee8217038d32::asdasdasd {
    struct ASDASDASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDASDASD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ASDASDASD>(arg0, 6, b"ASDASDASD", b"asdasdasd by SuiAI", b"asdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_22_at_00_53_53_3123cbc900.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDASDASD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDASDASD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

