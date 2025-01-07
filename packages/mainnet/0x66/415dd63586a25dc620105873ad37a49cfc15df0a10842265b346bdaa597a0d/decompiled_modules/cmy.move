module 0x66415dd63586a25dc620105873ad37a49cfc15df0a10842265b346bdaa597a0d::cmy {
    struct CMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMY>(arg0, 6, b"CMY", b"Cyber Monkey", b"Cyber Monkey is a next-generation meme token that combines the playful charm of monkey-themed culture. Is a community-driven project that embraces humor & creativity OHH OHH AHH AHH!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731914316967.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

