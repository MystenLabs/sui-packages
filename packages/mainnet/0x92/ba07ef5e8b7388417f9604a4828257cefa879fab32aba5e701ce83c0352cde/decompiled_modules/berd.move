module 0x92ba07ef5e8b7388417f9604a4828257cefa879fab32aba5e701ce83c0352cde::berd {
    struct BERD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERD>(arg0, 6, b"BERD", b"berd", x"69742773206120626572640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_LS_91g_Fc4t_Qv5vsw_Ma_Y_Hn7m_Wdw_C8_PZ_7d7mc3b_Qe_Au_DE_5_2fa08a8e96.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERD>>(v1);
    }

    // decompiled from Move bytecode v6
}

