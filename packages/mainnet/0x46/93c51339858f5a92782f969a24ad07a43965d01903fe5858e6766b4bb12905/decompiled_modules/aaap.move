module 0x4693c51339858f5a92782f969a24ad07a43965d01903fe5858e6766b4bb12905::aaap {
    struct AAAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAP>(arg0, 6, b"AAAP", b"AAAPEPE", b"also AAA and also Pepe. CTO to make my ex girlfriend mad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Euu_Nyv_Wr_Yga3_Y_Yr6y_E8_QH_Nc42_E_Ye7_ZM_5_ZRS_Ex_FW_2s_Ei_6690d87c05.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

