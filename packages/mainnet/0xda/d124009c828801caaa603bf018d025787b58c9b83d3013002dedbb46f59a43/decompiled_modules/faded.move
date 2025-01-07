module 0xdad124009c828801caaa603bf018d025787b58c9b83d3013002dedbb46f59a43::faded {
    struct FADED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FADED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FADED>(arg0, 6, b"FADED", b"Faded", b"im faded", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pp8g3sgt_Xdayp_Tw_M_Kma_P6e_X8_GK_5_KE_Uq_H_Yn1z_Mrhfrw5g_efe0fc54b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FADED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FADED>>(v1);
    }

    // decompiled from Move bytecode v6
}

