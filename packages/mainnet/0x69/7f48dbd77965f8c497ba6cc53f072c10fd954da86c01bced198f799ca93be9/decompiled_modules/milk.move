module 0x697f48dbd77965f8c497ba6cc53f072c10fd954da86c01bced198f799ca93be9::milk {
    struct MILK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILK>(arg0, 6, b"MILK", b"Milk Road", b"We're gonna win so much milk, you may even get tired of winning milk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028282_7bc610228e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILK>>(v1);
    }

    // decompiled from Move bytecode v6
}

