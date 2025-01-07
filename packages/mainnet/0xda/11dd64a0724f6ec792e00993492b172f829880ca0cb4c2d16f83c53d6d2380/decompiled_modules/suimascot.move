module 0xda11dd64a0724f6ec792e00993492b172f829880ca0cb4c2d16f83c53d6d2380::suimascot {
    struct SUIMASCOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMASCOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMASCOT>(arg0, 6, b"SUIMASCOT", b"Sui Santa Mascot", b"Meet $SUIMASCOT (Sui Santa Mascot) A cheerful water mascot donning an iconic Santa hat, spreading festive joy and warmth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GBBGMZ_Ftp_R4_NS_Yih_B5_D45gir_LR_25z_Pn_J1_Ahrz7_Ropump_fb71dfeafb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMASCOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMASCOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

