module 0x647575a4258b5f2fca4f1688db892b1b86548c69bcf4dfaab6920552cdd937bc::legd {
    struct LEGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEGD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEGD>(arg0, 6, b"LEGD", b"LENGEND", b"Legends is a legend tokens which is going to moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_Pngtreea_game_time_neon_sign_vector_5993039_88b1dfd00f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEGD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEGD>>(v1);
    }

    // decompiled from Move bytecode v6
}

