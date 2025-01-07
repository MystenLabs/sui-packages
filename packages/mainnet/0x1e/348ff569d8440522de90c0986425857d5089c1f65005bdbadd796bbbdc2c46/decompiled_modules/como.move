module 0x1e348ff569d8440522de90c0986425857d5089c1f65005bdbadd796bbbdc2c46::como {
    struct COMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMO>(arg0, 6, b"COMO", b"Como Como", b"$COMO is more than just a meme token. Its about combining fun with crypto, backed by a strong community and exciting opportunities. With $COMO, you're not just holding a token  youre joining a movement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QU_8a_Hk_QA_6_MS_25_Ltu_S_Mhfz_P1id_YD_Nd_Kn_QG_4k_J2_Gd_V97zp_1ca107fc77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

