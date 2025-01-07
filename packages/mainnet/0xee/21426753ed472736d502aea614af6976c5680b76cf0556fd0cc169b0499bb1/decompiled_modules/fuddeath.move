module 0xee21426753ed472736d502aea614af6976c5680b76cf0556fd0cc169b0499bb1::fuddeath {
    struct FUDDEATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDEATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDEATH>(arg0, 6, b"FUDDEATH", b"FudDeath onSui", x"68747470733a2f2f782e636f6d2f623161636b6430672f7374617475732f313834303837363138393239343231353332350a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yv_D8_Ho_XUA_An66_T_878b8a7ad7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDEATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDDEATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

