module 0x3128afb9d4488c75fa0c0c4d7b7f1261ed89fe3fdef403303a58280c10d30083::blinkhub {
    struct BLINKHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLINKHUB>(arg0, 6, b"BlinkHub", b"Blink Hub", b"BLINKHUB is a telegram bot powered by pornhub. Blinkhub Bot is a search engine of your desire categories on Pornhub , just Search,Click and Watch! ENJOY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019316_68ddbe3c96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLINKHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLINKHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

