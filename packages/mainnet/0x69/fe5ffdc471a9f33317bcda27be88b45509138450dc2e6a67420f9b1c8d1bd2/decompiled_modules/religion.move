module 0x69fe5ffdc471a9f33317bcda27be88b45509138450dc2e6a67420f9b1c8d1bd2::religion {
    struct RELIGION has drop {
        dummy_field: bool,
    }

    fun init(arg0: RELIGION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RELIGION>(arg0, 6, b"Religion", b"religion", x"54686973206973206e6f74206120436f696e636964656e63650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdqa_UW_Nr9wn_Zdo_Js_N1a_DAXQQPL_9_Y4_EJ_Mj1_Qdhq_WF_16n3_S_00a73e504e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RELIGION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RELIGION>>(v1);
    }

    // decompiled from Move bytecode v6
}

