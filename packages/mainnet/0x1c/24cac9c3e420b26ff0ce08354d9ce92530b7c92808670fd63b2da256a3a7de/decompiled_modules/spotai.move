module 0x1c24cac9c3e420b26ff0ce08354d9ce92530b7c92808670fd63b2da256a3a7de::spotai {
    struct SPOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOTAI>(arg0, 6, b"Spotai", b"Spot AI", b"Introducing SPOT AI: Your SUI Network Trading Companion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1884_adc7859d5f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

