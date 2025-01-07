module 0x14000cd4c713cbf9cc20e4ef69935bcb4154ea637f5126e46736e07b31ff6e25::brian {
    struct BRIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIAN>(arg0, 6, b"Brian", b"Brian Griffin", x"4d722e50726574656e74696f7573206f6e205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qma2srp_Q_Ya_H_Zhqjw_G36wd_Steou8y_F_Lr_Yk_RRKD_Bj_Ka_D_Hz4v_f65c5a86dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

