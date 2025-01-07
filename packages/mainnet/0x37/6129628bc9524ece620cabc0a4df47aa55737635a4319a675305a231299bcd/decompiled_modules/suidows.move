module 0x376129628bc9524ece620cabc0a4df47aa55737635a4319a675305a231299bcd::suidows {
    struct SUIDOWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOWS>(arg0, 6, b"Suidows", b"Suidows 94", b"Suidows 94 system. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vj_H22_Xr_S_Dw_EP_8iqg_S7_D_Sr_KQ_1oaqs_Qrkik_Ryj_G2_M_Nr_Xi_Q_d112918e08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

