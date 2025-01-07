module 0xf33fc8396f53bafaaef0f9b8e1f2702eae4bbd3eead8dcdb70e24f2000672212::btccc {
    struct BTCCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCCC>(arg0, 6, b"Btccc", b"btccc", b"asfasfasf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_XQ_2_N_Feb_NVS_1_GQ_Gvd_Xpj8_PLM_8_H1_P96_A7p_RVXF_6ge_Mtrn_J_840261cbe8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

