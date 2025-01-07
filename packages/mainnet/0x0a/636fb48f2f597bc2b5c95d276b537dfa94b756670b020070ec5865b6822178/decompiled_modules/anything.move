module 0xa636fb48f2f597bc2b5c95d276b537dfa94b756670b020070ec5865b6822178::anything {
    struct ANYTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANYTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANYTHING>(arg0, 6, b"ANYTHING", b"Anything", b"This token can be Anything. It can be an animal, then it can be a person. You decide - you change. New concept.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Gohcg7_Y1_H2e2o_R8_PP_Vk_Y7_B_Aqc3_B8ir_ZPNG_Jqz6_Va_Djc_e8b94fe947.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANYTHING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANYTHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

