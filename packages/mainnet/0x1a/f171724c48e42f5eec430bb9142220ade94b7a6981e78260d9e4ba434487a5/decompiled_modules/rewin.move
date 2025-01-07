module 0x1af171724c48e42f5eec430bb9142220ade94b7a6981e78260d9e4ba434487a5::rewin {
    struct REWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REWIN>(arg0, 6, b"REWIN", b"Trump Rewi", x"5472756d7020526577696e2e204d616b6520416d657269636120677265617420616761696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Eh_Htlw_F28j_Gg7_B0z_Z5_DJ_9_Ih_TZ_Rkc9xo_Ggl_C8_DE_4q_MM_cc4021de0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

