module 0x1ead2ae3a909aaf4f106258f412c5f8491a4d10542b3a8d8ee687005b90c3f12::helios {
    struct HELIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELIOS>(arg0, 6, b"Helios", b"Helios The Cat", x"54686520436174206f6620546f6b616e650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc63o_FHM_Dm_P2_Vei_FL_3_H6nrzt9v_WQ_7p_Df9_Br_T8_YX_Qq_Z_Br2_d753186641.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELIOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HELIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

