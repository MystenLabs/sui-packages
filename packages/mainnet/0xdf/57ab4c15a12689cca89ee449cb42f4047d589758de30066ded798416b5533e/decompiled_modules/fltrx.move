module 0xdf57ab4c15a12689cca89ee449cb42f4047d589758de30066ded798416b5533e::fltrx {
    struct FLTRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLTRX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FLTRX>(arg0, 6, b"FLTRX", b"FLTRx by SuiAI", b"FLTRx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_20250111_005941_877dbd4384.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FLTRX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLTRX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

