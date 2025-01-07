module 0xa5890bc2f85c918dc197d0e54d91b6bdf11b6313e1f4af78c546437b465f5dca::bwear {
    struct BWEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWEAR>(arg0, 6, b"BWEAR", b"BwearMeme", b"Here to take down all bwulls!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Q3k_Qm_A_Sast_Hk_K2z_Kzp_Fan_BA_Dpq_Ki4y1i_Vmmu_C38_G_Dq3_B_e11eaadb8d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

