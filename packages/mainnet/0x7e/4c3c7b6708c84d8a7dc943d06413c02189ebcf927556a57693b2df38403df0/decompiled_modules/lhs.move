module 0x7e4c3c7b6708c84d8a7dc943d06413c02189ebcf927556a57693b2df38403df0::lhs {
    struct LHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LHS>(arg0, 6, b"LHS", b"Let Her Suck (Hannah)", x"68747470733a2f2f7777772e74696b746f6b2e636f6d2f646973636f7665722f68616e6e61682d7577752d6f6666696369616c2d6163636f756e743f6c616e673d656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Uq_Yh_Kj2_X_Qc3_PW_6pc47_XT_4v_Ffjm_Wu_BD_1_Pt_T31e_SZ_Toup_B_8637e8e420.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

