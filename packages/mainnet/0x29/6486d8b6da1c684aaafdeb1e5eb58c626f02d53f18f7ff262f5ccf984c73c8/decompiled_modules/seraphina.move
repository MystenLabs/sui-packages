module 0x296486d8b6da1c684aaafdeb1e5eb58c626f02d53f18f7ff262f5ccf984c73c8::seraphina {
    struct SERAPHINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SERAPHINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SERAPHINA>(arg0, 6, b"SERAPHINA", b"Seraphina", x"536572617068696e612028536572617068696e61290a536572617068696e612c2074686520456e6368616e74726573732c207769746820636173636164696e672073696c7665722d626c7565206c6f636b732c20656d627261636564206279207477696e20617a7572652073657270656e747320746861742073796d626f6c697a6520686572206d7973746963616c20706f77657220616e6420636f6e6e656374696f6e20746f2074686520617263616e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X_Ye9kt_Pvr_Bj_Mkk7_APL_Ddj_V_Ycay5_Dh_Aupk_Ys1m_Q_Eqoa_Cq_5ac5afcfe6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SERAPHINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SERAPHINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

