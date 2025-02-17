module 0x7653f11e275ee87d17c5cbf1a4828152f06229ed73716dca877e70626c140722::sign {
    struct SIGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGN>(arg0, 6, b"SIGN", b"SIGNSUI", b"SIGN NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Fupkb_AC_2_Uvnq_FY_Zp69y_J2_S3_B_Yo1_Va8_V9j_Tho9w_Jpump_fa2d2438bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

