module 0xd3306d7935cf117533b982b19f59c765752b985b34a81d5c8c7d150f3ac2448::ai {
    struct AI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI>(arg0, 6, b"AI", b"Autistic Intelligenc", b"I'm AI , If you strike me down, I will become more powerful than you could possibly imagine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731790221429.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

