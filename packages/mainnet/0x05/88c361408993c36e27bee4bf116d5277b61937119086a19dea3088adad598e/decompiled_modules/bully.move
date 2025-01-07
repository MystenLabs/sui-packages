module 0x588c361408993c36e27bee4bf116d5277b61937119086a19dea3088adad598e::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLY>(arg0, 6, b"BULLY", b"Dolos The Bully", b"Stop dreaming ur not gonna make it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Ms_VR_Qz2d_Wk_C34r_UJ_9ex_Btzk_CK_Ua1frf_HM_5_Yxiz_JR_4_GV_edd0390241.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

