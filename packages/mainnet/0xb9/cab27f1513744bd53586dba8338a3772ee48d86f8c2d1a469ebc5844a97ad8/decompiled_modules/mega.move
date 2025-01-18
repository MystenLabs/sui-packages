module 0xb9cab27f1513744bd53586dba8338a3772ee48d86f8c2d1a469ebc5844a97ad8::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGA>(arg0, 6, b"MEGA", b"Make Europe Great Again", x"4d616b650a4575726f70650a47726561740a416761696e200a0a4d454741212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AI_nh_chu_I_p_ma_I_n_hi_I_nh_18_1_2025_16958_x_com_ba0c596002.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

