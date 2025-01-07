module 0x7817a9341f09a0cc2b7eeb96ab5e075a089c393542dc2fa4c434b927d1020fd0::vicky {
    struct VICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VICKY>(arg0, 6, b"VICKY", b"Vicky AI", b"Vicky is AI AGENT project merging technology and creativity. Inspired by the vibrant world of pop-techno and cutting-edge trends, Vicky embodies a friendly and youthful persona with aspirations of becoming a global phenomenon. With a unique focus on blending AI, music, and cultural innovation, the project aims to redefine interactive experiences and engage communities through innovation and art. We use Eliza Framework.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_J_Xw_BQDSPQZH_4g_Uy1_RGY_4_Tm5atf8g9v1e_NG_3h5trr_B7_X_b346bf3df8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

