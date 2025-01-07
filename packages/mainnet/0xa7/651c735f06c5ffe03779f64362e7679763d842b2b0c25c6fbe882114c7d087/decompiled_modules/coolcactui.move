module 0xa7651c735f06c5ffe03779f64362e7679763d842b2b0c25c6fbe882114c7d087::coolcactui {
    struct COOLCACTUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLCACTUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLCACTUI>(arg0, 6, b"COOLCACTUI", b"Cool Cactui", b"A prickly but chill vibe on Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cool_Cactui_faf5a7011f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLCACTUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLCACTUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

