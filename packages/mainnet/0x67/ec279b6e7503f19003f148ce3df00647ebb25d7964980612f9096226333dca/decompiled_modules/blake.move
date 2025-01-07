module 0x67ec279b6e7503f19003f148ce3df00647ebb25d7964980612f9096226333dca::blake {
    struct BLAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAKE>(arg0, 6, b"BLAKE", b"BLAKE SUI", b"BLAKE  BLAKE BLAKE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zq_Tr_Ka_Ymu_VD_Le8_M5_Edj13w_Ahx_AJ_7x1_Uzhxc2_Ji_B_Qt_A_Pf_2a5a8f3a5b.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

