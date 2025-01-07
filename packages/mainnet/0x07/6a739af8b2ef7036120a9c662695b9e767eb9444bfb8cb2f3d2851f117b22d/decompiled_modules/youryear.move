module 0x76a739af8b2ef7036120a9c662695b9e767eb9444bfb8cb2f3d2851f117b22d::youryear {
    struct YOURYEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOURYEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOURYEAR>(arg0, 6, b"YOURYEAR", b"Youryear", x"594f555259454152202d2061206d6f76656d656e74206f7574206f6620746865204d61747269782e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Yph_ZU_1zb9pda4_UQ_Ts_Hy_N17_Ze8_TT_2uws_Noh4_Wjw_LRJE_8_d651ad2f09.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOURYEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOURYEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

