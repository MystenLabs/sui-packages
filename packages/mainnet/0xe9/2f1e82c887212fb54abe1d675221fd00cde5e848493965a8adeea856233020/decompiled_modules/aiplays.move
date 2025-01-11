module 0xe92f1e82c887212fb54abe1d675221fd00cde5e848493965a8adeea856233020::aiplays {
    struct AIPLAYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPLAYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPLAYS>(arg0, 6, b"AIplays", b"AI Prototyping For Gaming", x"46726f6d20636f6e6365707420746f2067616d65706c617920696e206d696e757465732c206c6574206f75722041492068616e646c6520746865206865617679206c696674696e6720736f20796f752063616e20666f637573206f6e20637265617469766974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Y1ed_T8k_S4_Wz1f4_Sg_D7_R9_Y_Wk_W_Dpf_V2a5_VQS_Jmjyj4_W_Cx_K_419f0410a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPLAYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIPLAYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

