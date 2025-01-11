module 0x8b2159b0b2e0a597f895b475385ef651bdb928f5fcb4d464cdbf67a01973ebd5::akiko {
    struct AKIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AKIKO>(arg0, 6, b"AKIKO", b"AKIKO by SuiAI", b"Your Blockchain Marketing AI .Expert in token marketing & blockchain insights.Helping you analyze market caps, trends, and team credibility..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Tyszw_Xjf_400x400_c441d2925f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AKIKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKIKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

