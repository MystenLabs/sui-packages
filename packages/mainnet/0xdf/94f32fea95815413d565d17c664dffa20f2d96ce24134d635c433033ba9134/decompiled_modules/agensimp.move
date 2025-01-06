module 0xdf94f32fea95815413d565d17c664dffa20f2d96ce24134d635c433033ba9134::agensimp {
    struct AGENSIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENSIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENSIMP>(arg0, 6, b"AGENSIMP", b"AGENT SIMP ", b"Welcome to The Simpsons Quote Generator! This bot is designed to capture the essence of the most iconic yellow family on television. With a touch of humor, sarcasm, and Springfield-style philosophy, the bot generates memorable quotes from characters ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736172242473.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENSIMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENSIMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

