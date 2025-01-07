module 0x3297389a666448a1fef23fd3498c602fee41836e7cb2a124f156e9d9d4da975b::meowd {
    struct MEOWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWD>(arg0, 6, b"MEOWD", b"meowdusa", x"4d656f7764757361207475726e7320736b65707469637320696e746f20737461747565732c207768696c652074686520747275652062656c6965766572732072697365210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Zvh1c4_YX_3g_N_Qr_FZ_8fw_Qpv_QP_1y_YNQ_Kd_DM_77_L5_Bjrum1_M_c979e423d4.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

