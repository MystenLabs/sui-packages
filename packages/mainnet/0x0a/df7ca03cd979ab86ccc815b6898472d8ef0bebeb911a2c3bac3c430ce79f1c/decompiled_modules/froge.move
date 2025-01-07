module 0xadf7ca03cd979ab86ccc815b6898472d8ef0bebeb911a2c3bac3c430ce79f1c::froge {
    struct FROGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGE>(arg0, 6, b"FROGE", b"FrogE", b"FROGE ON ETH IS AT 100M, FROGE ON SUI LFG MINIMUN 10M.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Qkc_ZE_Dw_W_Qfy9h9_Deh_JK_6_EL_Uets_RK_8a_KZ_7_QJ_8_Ez_Akk_VTQ_84e0f4479b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

