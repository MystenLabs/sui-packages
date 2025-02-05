module 0x42fdff45dd5b4aa84350da695e98b9ac8f3c6bab0843664c85929083360fae99::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"SuiAIAgent", b"just a sui token deploy from AI. SUI is awesome", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lpbot.io/logo.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUAI>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

