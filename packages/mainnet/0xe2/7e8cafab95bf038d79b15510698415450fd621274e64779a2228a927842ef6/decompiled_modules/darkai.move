module 0xe27e8cafab95bf038d79b15510698415450fd621274e64779a2228a927842ef6::darkai {
    struct DARKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARKAI>(arg0, 6, b"DarkAI", b"Darkness AI", b"Knowing the darkness within yourself is the best way to deal with the darkness in others", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ai_generated_7931507_1280_25cd179ddb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARKAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

