module 0x6cfd4f3aa2797b3906d9ffe2f4625dcaf3618a4ac9d9b3857b35a4eb73fa1e24::babytrump {
    struct BABYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BABYTRUMP>(arg0, 6, b"BABYTRUMP", b"Baby Trump by SuiAI", b"$BabyTrump - The only official Trump coin meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2204_ddbc8cc14f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABYTRUMP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

