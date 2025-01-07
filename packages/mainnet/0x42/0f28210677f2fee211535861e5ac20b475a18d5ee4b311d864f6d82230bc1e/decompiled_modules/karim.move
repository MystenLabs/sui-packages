module 0x420f28210677f2fee211535861e5ac20b475a18d5ee4b311d864f6d82230bc1e::karim {
    struct KARIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARIM>(arg0, 6, b"KARIM", b"Uglysluagh", b"Uglysluagh (KARIM)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_SSE_8xvnb_G4iu_E3x_LXTD_Yo_Px_J9p_AB_5_BM_Fy_L7bbjf1n_ADV_2f90d97434.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KARIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

