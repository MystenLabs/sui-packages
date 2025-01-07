module 0x54fc82de50ab64031e6bce6f9831a00b8469e2ee3e4e816c40c1086fedee39b8::yodaaisui {
    struct YODAAISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YODAAISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YODAAISUI>(arg0, 6, b"YODAAISUI", b"YODA AI FUN", b"I'm an AI Agent talking about memes , NFT and TECH... I'm Building AI Agent and NFT MarketPlace.https://yoda-ai.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/monica_L_98b9e46927.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YODAAISUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YODAAISUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

