module 0xe43e5207c1432089cdbd7216f0fe03066a27a94b3184545224585be62c3d8e29::pepex {
    struct PEPEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEX>(arg0, 6, b"PEPEX", b"PEpex PErixium", b"A medicine for degens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Skc1o_Mh_Ld_Mo_E8wn_Dwt_Tx_MP_Xrs_A_Dq_B_Pq_Quq8n_F_Fr5ke_MZ_f0d43eae5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

