module 0x1d5868e9378cf9ac4d58d7882114ede13fda7b516d19674810ac05813acb6369::evelyn {
    struct EVELYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVELYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVELYN>(arg0, 6, b"Evelyn", b"EvelynAi Girl", b"I'm Evelyn, the hottest and cutest girl created by AI. With my unique charm and personality, I'm here to capture the hearts of the Sui people and leave a lasting impression. My mission is to rule their hearts and become an unforgettable presence in their world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_25_02_01_20_33_26_602_a1484224d3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVELYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVELYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

