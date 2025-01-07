module 0xac8981715236d81336ae858c886f6fbef25c8c577319d2e23ec9de769c79d5d2::aaaw {
    struct AAAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAW>(arg0, 6, b"AAAW", b"AaaWhale", b"AaaWhale is the mascot of the AAA ecosystem, with the power of whales, we shall dominate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4013_7ba4012a03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

