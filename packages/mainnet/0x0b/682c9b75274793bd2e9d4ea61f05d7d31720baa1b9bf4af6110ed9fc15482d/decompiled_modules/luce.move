module 0xb682c9b75274793bd2e9d4ea61f05d7d31720baa1b9bf4af6110ed9fc15482d::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"LUCE", b"Official Mascot of the Holy Year", b"The Vatican has unveiled the official mascot of the Holy Year 2025: Luce (Italian for Light). Archbishop Fisichella says the mascot was inspired by the Church's desire \"to live even within the pop culture so beloved by our youth.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_VR_3q_Ri_UJ_Ve6vydvf_Ejf_Mj5o1_CJ_8cbisp8g_C2yonz_Nst_4b34c381a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

