module 0x611f04c696d09f9e5a5afed9c3d77cf2a9fa49532d677be66c1ace28edd27f81::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOT>(arg0, 6, b"BOT", b"BOT by SuiAI", b"SUI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250110_225201_06351b17cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

