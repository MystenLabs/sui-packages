module 0x2abb005d8b260abdb5e16c335382a9eab0f4b881b3ee3236a59f9632b568004a::moonlite {
    struct MOONLITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONLITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONLITE>(arg0, 6, b"Moonlite", b"Moonlite Bot", b"First Sui Trading Bot, Meet Moonlite. A Telegram Trading Bot to Provide Sui Traders the resources to trade at the best of their ability. With Many Features and a soon to be added Rev Share Feature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/De_Q_3wf_B_400x400_0a7cfe5136.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONLITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONLITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

