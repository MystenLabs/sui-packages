module 0x98fce7e30eaca5f388695bd853cab1953dd5aca401000d17d89e4a32cac7436a::clocksui {
    struct CLOCKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOCKSUI>(arg0, 6, b"CLOCKSUI", b"CLOCKS", b"CLOCKSUI IS ON SUI CLOCKs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e8fe19a0a7bd86347b7e3a8300bafbf4_2695436820_c6a1d66919.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOCKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOCKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

