module 0x33a8d334a50a970305650980c5298d4f9f34841fb17e029497dfb02976ddadf4::spai {
    struct SPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAI>(arg0, 6, b"SPAI", b"Sui Pacman AI", b"Sui Pacman is a latency-optimized trading bot using the OPENAI CHATGPT4 API. Its primary function is to identify trading opportunities across the Sui Network, enabling users to execute trades on identified pairs either automatically or manually.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1302_5852223791.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

