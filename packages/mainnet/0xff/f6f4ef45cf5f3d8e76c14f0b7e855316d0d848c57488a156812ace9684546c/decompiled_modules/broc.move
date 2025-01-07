module 0xfff6f4ef45cf5f3d8e76c14f0b7e855316d0d848c57488a156812ace9684546c::broc {
    struct BROC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROC>(arg0, 6, b"BROC", b"Broc on Sui", b"BROC is a memecoin inspired by Broc, a whimsical character created by artist Ella May. Blending art, AI, and crypto culture, Broc spreads joy and creativity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZB_Pi_ZU_Ym_YM_Vhmt3f_VG_Xue_H92_Qdc_Cg_W_Xfdy_R_Qosmb_EG_5_82a4582037.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROC>>(v1);
    }

    // decompiled from Move bytecode v6
}

