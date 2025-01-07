module 0x7c3878e392b11a4db95f485d538b520fddb80c6d38a35c2067db58b39b542af4::dalai {
    struct DALAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DALAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DALAI>(arg0, 6, b"DALAI", b"Dal-AI Agent by SuiAI", b"Dal-AI Lama became a Salvador Dali agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/create_this_surreal_Dali_inspired_image_of_the_Dalai_Lama_4_706af5c05b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DALAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DALAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

