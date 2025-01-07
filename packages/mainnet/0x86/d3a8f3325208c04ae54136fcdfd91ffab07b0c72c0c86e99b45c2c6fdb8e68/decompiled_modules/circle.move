module 0x86d3a8f3325208c04ae54136fcdfd91ffab07b0c72c0c86e99b45c2c6fdb8e68::circle {
    struct CIRCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIRCLE>(arg0, 6, b"CIRCLE", b"Circle", x"496e746f207468652062656175746966756c20436972636c650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Noxh_NUMZR_He_Rr_JEU_Em_Nm_G_Eyz_W_Ndcq11_W8_Whu4z7dy_Qr_R_369e82ee4c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIRCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIRCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

