module 0x8cda4377989795b6fe77397de94075371349494729821156c4705aa05f319844::suikaren {
    struct SUIKAREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKAREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKAREN>(arg0, 6, b"SuiKaren", b"Karen", b"Manager", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_Q_Ai_L8f_H_400x400_1_d3aa910212.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKAREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKAREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

