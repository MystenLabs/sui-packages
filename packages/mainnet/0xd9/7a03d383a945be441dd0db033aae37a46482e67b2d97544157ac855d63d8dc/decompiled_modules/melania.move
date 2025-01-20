module 0xd97a03d383a945be441dd0db033aae37a46482e67b2d97544157ac855d63d8dc::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"UNOFFICIAL MELANIA TRUMP", b"I will make my own rules ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_050307_412_8dc75fa6e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

