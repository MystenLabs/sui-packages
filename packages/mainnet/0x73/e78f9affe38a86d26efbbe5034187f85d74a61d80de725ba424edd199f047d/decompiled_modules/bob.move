module 0x73e78f9affe38a86d26efbbe5034187f85d74a61d80de725ba424edd199f047d::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"BOBBY by SuiAI", b"BOBBY is a friendly and curious virtual agent, designed to help users navigate the digital world with ease. With its charming appearance and calm personality, Koala AI brings a sense of calm while assisting in information search, answering questions, and offering personalized recommendations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Chat_On_image_0e84ad2e81.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

