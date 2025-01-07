module 0x9f7c1a4528b4a5a889871f80ec19640ec8b96f4f80f393a2576b865fc2564014::pvp {
    struct PVP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PVP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PVP>(arg0, 6, b"PVP", b"Potato Value Proposition", x"486572652773206120706f7461746f20796f75206469646e2774206b6e6f7720796f75206e65656465642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PN_Nc_E3_Wmzw7o4_M5_JQ_3_Fm_Dt_H_Sy3_Kp_TKF_1pb_T2_Stm_JBF_Vt_0a02be8a33.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PVP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PVP>>(v1);
    }

    // decompiled from Move bytecode v6
}

