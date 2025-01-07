module 0xd71b9b9835a1a1d30153022a1e1992cbfca1c2f1fc431934dd963a14b826c312::rif {
    struct RIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIF>(arg0, 6, b"RIF", b"rifampicin", b"Rifampicin is traditionally known as an antibiotic, but its been gaining attention for its surprising effects on aging. In tiny organisms like C. elegans (a model organism often used in aging research), Rifampicin has been shown to activate the cells natural defense mechanisms against stress and damage. Imagine it as a sort of \"cellular coach,\" encouraging cells to stay healthy and resilient by protecting against harmful oxidative stress and maintaining the quality of proteins within the cell. These protective effects help the worms live longer and healthier lives. While its still early days, and we dont yet know if Rifampicin can do the same in humans, its ability to promote cellular health makes it an exciting area of research in the quest for anti-aging therapies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Jt_Ju_WD_9q_Yc_Ckrw_M_Bmt_Y1tpap_V1s_Kf_B2z_Uv9_Q4aqpump_d1add33041.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

