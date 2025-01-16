module 0x33068abcd4341f8bbe274a0ea6841ccf2add1eea4d7e774a84701870650514c0::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOT>(arg0, 6, b"Bot", b"Black Orange Token", b"Black orange token created for community enhancement ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737015907942.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

