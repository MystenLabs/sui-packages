module 0x3e9f2a9feef201a26c3bfc8559d13762767e8751557d8c9495ed9fbd4d4c5489::mlts {
    struct MLTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLTS>(arg0, 6, b"MLTS", b"Milton.Sui", x"4d414b4520464c4f5249444120475245415420414741494e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MLTS_TD_Fc_YR_5_IX_37_Jc_OF_Pv_Y_611d3cf3b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MLTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

