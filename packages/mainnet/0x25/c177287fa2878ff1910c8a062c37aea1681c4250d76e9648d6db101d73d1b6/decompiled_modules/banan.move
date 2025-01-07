module 0x25c177287fa2878ff1910c8a062c37aea1681c4250d76e9648d6db101d73d1b6::banan {
    struct BANAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANAN>(arg0, 6, b"BANAN", b"Banan", b"GRAHH GRAHH GRAHH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rv_PJ_7w_Bi_KJ_2yik_P_Cw_EP_8hf23tnb_DGY_2_T232_BQ_Qx4kz_Hp_e4634b456c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

