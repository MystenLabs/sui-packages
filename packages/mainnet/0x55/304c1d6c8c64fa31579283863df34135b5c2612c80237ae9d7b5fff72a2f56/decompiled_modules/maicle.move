module 0x55304c1d6c8c64fa31579283863df34135b5c2612c80237ae9d7b5fff72a2f56::maicle {
    struct MAICLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAICLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAICLE>(arg0, 6, b"MAICLE", b"MAICLE SAILOR by SuiAI", b"AI SAYLOR FOR DEGENS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pngwing_com_3_3558df0443.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAICLE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAICLE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

