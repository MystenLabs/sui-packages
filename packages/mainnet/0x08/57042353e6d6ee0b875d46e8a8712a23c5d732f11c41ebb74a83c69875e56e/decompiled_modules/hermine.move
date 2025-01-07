module 0x857042353e6d6ee0b875d46e8a8712a23c5d732f11c41ebb74a83c69875e56e::hermine {
    struct HERMINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERMINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERMINE>(arg0, 6, b"HERMINE", b"#1 TIKTOK CHINESE DOG", x"23312054494b544f4b204348494e45534520444f470a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmd_Y2i_Y_Qs_AY_Vi_Q1uz_MB_Rna_Cm_Ak5_Ladsqzmrq_Fzvo_PEP_Mpo_8a9fd6db17.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERMINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HERMINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

