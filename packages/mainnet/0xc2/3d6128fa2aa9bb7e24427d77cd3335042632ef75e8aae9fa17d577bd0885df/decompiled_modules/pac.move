module 0xc23d6128fa2aa9bb7e24427d77cd3335042632ef75e8aae9fa17d577bd0885df::pac {
    struct PAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAC>(arg0, 6, b"PAC", b"AMERICA PAC", b" Join the America $PAC Movement! We support Trump and the billionaires backing him, like Elon Musk. Lets $MAGA and $FIGHT for $BTC dominance in the USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x4c44a8b7823b80161eb5e6d80c014024752607f2_7e492dca7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

