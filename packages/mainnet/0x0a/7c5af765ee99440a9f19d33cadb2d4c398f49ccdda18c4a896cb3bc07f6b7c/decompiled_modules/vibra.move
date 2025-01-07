module 0xa7c5af765ee99440a9f19d33cadb2d4c398f49ccdda18c4a896cb3bc07f6b7c::vibra {
    struct VIBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VIBRA>(arg0, 6, b"VIBRA", b"ViralVibes by SuiAI", b"Just a robotic INU with an AI brain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_1375_db002ff018.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VIBRA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBRA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

