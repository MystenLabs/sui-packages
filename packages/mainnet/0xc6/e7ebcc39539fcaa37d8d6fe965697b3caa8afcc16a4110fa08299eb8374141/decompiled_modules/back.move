module 0xc6e7ebcc39539fcaa37d8d6fe965697b3caa8afcc16a4110fa08299eb8374141::back {
    struct BACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACK>(arg0, 6, b"Back", b"Adam Back", b"cypherpunk, cryptographer, privacy/ecash, inventor hashcash (used in Bitcoin mining)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QP_Xh_H_Vw9m4_CU_Kjpyk_Nogq9q_Qh_CA_Ai_M_Fr196yaeju97_WJ_fe75e0acec.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

