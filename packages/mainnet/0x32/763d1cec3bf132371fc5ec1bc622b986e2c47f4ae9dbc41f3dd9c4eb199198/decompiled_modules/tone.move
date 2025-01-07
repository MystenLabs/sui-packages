module 0x32763d1cec3bf132371fc5ec1bc622b986e2c47f4ae9dbc41f3dd9c4eb199198::tone {
    struct TONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONE>(arg0, 6, b"TONE", b"Tone AI", b"Tone Al emerges as a pioneering force, revolutionizing how artificial intelligence integrates into our lives.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735983091913.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

