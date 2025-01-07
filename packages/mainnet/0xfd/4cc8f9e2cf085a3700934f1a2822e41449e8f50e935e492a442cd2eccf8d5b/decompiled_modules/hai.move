module 0xfd4cc8f9e2cf085a3700934f1a2822e41449e8f50e935e492a442cd2eccf8d5b::hai {
    struct HAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAI>(arg0, 6, b"HAI", b"Health AI", b"A personal assistant to your healthy lifestyle. Nutrition, water, sleep, and workout tracker. Track your goals and analyze your progress.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735547884795.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

