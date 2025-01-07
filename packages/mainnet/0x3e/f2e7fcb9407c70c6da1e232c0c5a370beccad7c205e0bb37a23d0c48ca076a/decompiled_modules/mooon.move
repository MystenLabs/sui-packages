module 0x3ef2e7fcb9407c70c6da1e232c0c5a370beccad7c205e0bb37a23d0c48ca076a::mooon {
    struct MOOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOON>(arg0, 6, b"MOOON", b"TO THE MOOON", b"TO THE MOOON ..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeu1_UW_Xaev_Vf_Qq_P5ch_Ayo_Acp_UU_5a1p_Z4sxpt26_Ypxm_J8a_678f5107b4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

