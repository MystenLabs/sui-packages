module 0xc1a94cf46857c3f281e25ab5f16f1d4a0feee73d8bc4ae4a4b4db255789bcf13::sharkcat {
    struct SHARKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKCAT>(arg0, 6, b"SharkCat", b"sc", b"Shark Cat in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/Qm_Y_Znjijjto_H2_YDC_Px_Uc6adv_Su_Sbs_Cre4g_Djt_S2_YT_Ufw7_P_8fb0ed436f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

