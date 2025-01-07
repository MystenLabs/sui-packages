module 0xf3e4c4cdc52444cae8b5412d44aebbb157707fb5f0ed09002ed23af6b4c0f2a1::chaos {
    struct CHAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOS>(arg0, 6, b"CHAOS", b"CHAOSUI", b"Sui is the hub where all meme coins thrive, making waves so big that even in real life, everyone's talking about them. All the viral memes come straight out of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_195153_650_f954a34103.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

