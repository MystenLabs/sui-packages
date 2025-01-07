module 0xb39b7de9e240f20a0e3acdb3c2cdbc0f5e8592abae71e2bfc2f75d254e3a76fa::runner {
    struct RUNNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUNNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUNNER>(arg0, 6, b"RUNNER", b"Runner", x"4e617275746f20726163657320746f776172642068697320667269656e64732c2064657465726d696e6174696f6e206275726e696e6720696e2068697320657965732e2048652077696c6c206e657665722066616c7465722c206e657665722067697665207570686973207265736f6c766520697320756e7368616b61626c652c206869732073706972697420756e73746f707061626c652e2042656c69657665206974210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_R_Za_Bu_U4g_A7_D8v6_Vc_Tt9_DL_3cfq27_Mhn_SAK_5_Aerh_Zw7m_T_2fe870b2f7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUNNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUNNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

