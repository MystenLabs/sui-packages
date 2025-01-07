module 0x8db983ad138fa8267b15a4e2dcd548ee2e1baa77226485b1563b62d9211e8e54::phi {
    struct PHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHI>(arg0, 6, b"PHI", b"PHI SUI", b"A place to create, mint, and shape your onchain identity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Sr_C79_Ui_Gb_W7hvkq_N_Zne2_V_Bv9_Ftm_Z6_Lxud_Uv_K5_Ci_Sw_Y_Ft_67d7e52dc9.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

