module 0x2bd493872d9028c0a1fcd9713b57288d596ce44631010690a7208f82497be2d::loppy {
    struct LOPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPPY>(arg0, 6, b"LOPPY", b"LOPPYSUI", b"LOPPY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zv_BEF_8owk_Zydn_J_Luyngs_Rm_Ud_Lf71f_Z_Ye_Fn_Bv_PWQZ_3_E_Yo_34f4357802.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

