module 0x32dac29af625dd6cdd7bb44c149741adafbddfd7d23f48b22329f2bc5e9f6db7::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"SNAKE", b"SnakeLite on sui", x"0a536e616b654c697465206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmejb_Aja_Yv_N_Lr5_Pun_Vp9r_Y_Pv_L1tt_A_Tds2_S_Hu_Cm2_C_Kv6_A_Yu_fa2837567c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

