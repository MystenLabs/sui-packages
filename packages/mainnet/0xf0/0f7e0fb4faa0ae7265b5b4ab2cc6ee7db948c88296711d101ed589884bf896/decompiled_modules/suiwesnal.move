module 0xf00f7e0fb4faa0ae7265b5b4ab2cc6ee7db948c88296711d101ed589884bf896::suiwesnal {
    struct SUIWESNAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWESNAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWESNAL>(arg0, 6, b"SUIWESNAL", b"WESNAL", x"476f205765736e6161616c2e2e2e2e20427574206d6f737420696d706f7274616e746c792077697468206120736d6f6f6f6f6f6b79792e2e2e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbaq_Khuv_MXJTPL_Cj_AS_2_Zt_W3m_Nb_H_Fq7_D5_Xug_H_Rnjc_Npf_He_157044267a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWESNAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWESNAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

