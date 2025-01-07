module 0x9cebd637ceb1eeabef78a9c735bd4423397506868927860f59ab50f44d671c48::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"Prgm. for Explr. & Plnt. Expns.", x"50726f6772616d20666f72204578706c6f726174696f6e20616e6420506c616e657461727920457870616e73696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Wgig_F96_ZH_Hqwdq_N2_N7u_Kjbz_TP_Abzg_Kh_KTP_Fz_Wughc_T63_3d560b0d04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

