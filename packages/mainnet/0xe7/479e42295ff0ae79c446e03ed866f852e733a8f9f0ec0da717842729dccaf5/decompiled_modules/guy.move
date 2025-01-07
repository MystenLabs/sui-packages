module 0xe7479e42295ff0ae79c446e03ed866f852e733a8f9f0ec0da717842729dccaf5::guy {
    struct GUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUY>(arg0, 6, b"GUY", b"SUI", b"https://t.me/suiguysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732317327341.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

