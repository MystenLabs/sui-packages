module 0x110d807e1fb5319d234e028e76666cc909f5fcbc63720730923c85b76e7a9610::slapcoin {
    struct SLAPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAPCOIN>(arg0, 6, b"SLAPCOIN", b"Slapcoin", x"536c61702069743f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Z4_BKEYG_Epm_P_Xch_Sh7r_Ywm_Q9_VB_4_PD_2he5_U7e3e_PAT_Uzp_S_2cfd3ecaf3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

