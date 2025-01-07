module 0x6bf7c187f83d5df6607568b1a40993a93e7a75c701952c4f392bc335a8966646::kindi {
    struct KINDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINDI>(arg0, 6, b"KINDI", b"kindi on sui", b"$KINDI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z4hnb_UL_Rzjc_Yv_KV_8cqn_Cji3i_WGPC_1_Qy_L_Cs_Vgv_QE_16_Xqr_3f4a041327.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

