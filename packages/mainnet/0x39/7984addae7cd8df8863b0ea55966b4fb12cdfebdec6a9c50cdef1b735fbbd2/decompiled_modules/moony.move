module 0x397984addae7cd8df8863b0ea55966b4fb12cdfebdec6a9c50cdef1b735fbbd2::moony {
    struct MOONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONY>(arg0, 6, b"MOONY", b"Moony", x"4c6976696e206c612076696461204d6f6f6e792e205768657265204d454d452063756c7475726520616e6420414920656e74616e676c652c2063656c6562726174696e672074686f736520677265656e20676f6f642074696d657320746f676574686572210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_W_Pp_Z_Zq4q7_JSN_5_J_Zi_SV_8_S_Bkr8x_QP_Ht_Zj_M_Mq_M9_Ekxamh_Yt_d82c7148c7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

