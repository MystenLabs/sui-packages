module 0xb361946410c81de3b43f809d51bafdb08e814ead59ab807fea198d59ee75f484::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"DOG FACE", b"SuiEmoji Dog Face", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiemoji.fun/emojis/dog.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

