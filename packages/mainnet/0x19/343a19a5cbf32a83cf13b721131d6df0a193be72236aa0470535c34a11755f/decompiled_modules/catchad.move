module 0x19343a19a5cbf32a83cf13b721131d6df0a193be72236aa0470535c34a11755f::catchad {
    struct CATCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCHAD>(arg0, 6, b"CATCHAD", b"Catchad", b"look at this catchad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xf_Fi_Lnw_Drr_Goab_K521_Qf1_L_Xt7_TQ_1_V_Kg_Q6wrc_M6_Jia_A1e_7a541b2f44.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATCHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

