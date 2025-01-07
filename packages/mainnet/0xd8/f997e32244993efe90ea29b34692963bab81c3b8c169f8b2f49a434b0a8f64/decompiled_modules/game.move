module 0xd8f997e32244993efe90ea29b34692963bab81c3b8c169f8b2f49a434b0a8f64::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAME>(arg0, 6, b"GAME", b"PUMPlNG GAME", x"58203a2068747470733a2f2f782e636f6d2f70756d7067616d6566756e2057454220262047414d45203a2068747470733a2f2f6465762d656c6f7073747564696f2e636f6d2f70756d7067616d652054656c656772616d203a2068747470733a2f2f742e6d652f70756d7067616d6566756e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_16_02_45_12_5f28c34435.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAME>>(v1);
    }

    // decompiled from Move bytecode v6
}

