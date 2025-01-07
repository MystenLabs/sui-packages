module 0x3df86cdff963decd5d87e5b66cfbab5e24dd570b6d017b95a90f9d39b2ecf961::dog2 {
    struct DOG2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOG2>(arg0, 6, b"DOG2", b"DOG", b"SuiEmoji Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiemoji.fun/emojis/dog2.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOG2>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG2>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

