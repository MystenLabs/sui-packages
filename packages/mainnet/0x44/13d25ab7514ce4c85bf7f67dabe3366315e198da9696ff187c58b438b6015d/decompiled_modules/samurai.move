module 0x4413d25ab7514ce4c85bf7f67dabe3366315e198da9696ff187c58b438b6015d::samurai {
    struct SAMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAMURAI>(arg0, 6, b"SAMURAI", b"SamUrAI by SuiAI", b"In the neon lit shadows of the cyberpunk city the lone samurai stood still his glowing katana humming with energy .He was the last guardian of an ancient code reborn in a world of steel and circuits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/samurai_d60629bd69_94625c0be6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAMURAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMURAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

