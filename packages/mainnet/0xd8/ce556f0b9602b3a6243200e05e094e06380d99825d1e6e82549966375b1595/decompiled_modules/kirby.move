module 0xd8ce556f0b9602b3a6243200e05e094e06380d99825d1e6e82549966375b1595::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBY>(arg0, 6, b"KIRBY", b"New Baby Elephant Houston Zoo", b"Nov 18Th is my birthday! Cutest Elephant on Sui Chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AXTC_Lqqup_JN_3_Y_Wikg_Dt_A_Zx_RK_Wizsbe_P_Dy_V9_Xtk_Dtpump_632ca2cd6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

