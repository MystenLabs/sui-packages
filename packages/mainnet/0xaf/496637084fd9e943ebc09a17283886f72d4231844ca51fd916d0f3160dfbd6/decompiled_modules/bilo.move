module 0xaf496637084fd9e943ebc09a17283886f72d4231844ca51fd916d0f3160dfbd6::bilo {
    struct BILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILO>(arg0, 6, b"BILO", b"BiloDog", b"Bilo, the adorable new sensation in the crypto world! With his irresistible charm and innovative features, Bilo is set to capture hearts and skyrocket in value", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049219_786e4be7b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

