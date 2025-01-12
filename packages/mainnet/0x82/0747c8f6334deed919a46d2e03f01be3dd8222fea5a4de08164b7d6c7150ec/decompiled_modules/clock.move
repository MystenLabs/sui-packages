module 0x820747c8f6334deed919a46d2e03f01be3dd8222fea5a4de08164b7d6c7150ec::clock {
    struct CLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CLOCK>(arg0, 6, b"CLOCK", b"ClockEye by SuiAI", b"ClockEye is a smart, vigilant AI agent designed to monitor the AI agent market on suiai.com. With its sharp eye on trends, innovations, and new releases, ClockEye ensures you're always in the loop, offering real-time insights and updates in a fun and engaging way. Stay ahead of the game with ClockEye!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/desktops_amazing_wallpaper_unbelieveable_wallpapers_cool_gudang_45b82524f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLOCK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOCK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

