module 0x3b647e3f71a985553a2579fb05e640ed92faeb6423f2e87883667d4502504f4::pill {
    struct PILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILL>(arg0, 6, b"PILL", b"RED PILL", b"The First Telegram Insider Insights bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_21_29_12_14622b7fea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

