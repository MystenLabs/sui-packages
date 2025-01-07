module 0x244cb5f94b28b9d4763fa279fe6e59d7099461afdbf86561688fc7078a979a2b::tema {
    struct TEMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMA>(arg0, 6, b"TEMA", b"Tema the Raccoon", b"Tema is the world's most famous raccoon with 2,700,000 followers on tiktok, 1,700,000 on Youtube and 314,000 followers on IG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cnfshwmv_Dq_Lr_B1j_SLF_7b_LJ_3i_ZF_5u354_WRFGP_Bm_Gz4uyf_26fad3cb48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

