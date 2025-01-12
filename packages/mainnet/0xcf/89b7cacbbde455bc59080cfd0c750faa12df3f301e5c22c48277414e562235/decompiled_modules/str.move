module 0xcf89b7cacbbde455bc59080cfd0c750faa12df3f301e5c22c48277414e562235::str {
    struct STR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STR>(arg0, 6, b"STR", b"STR by SuiAI", b"STR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/OIG_3_x_Fwnn_M2_O_Pe_D_Wluswy_G_f25fab2561.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

