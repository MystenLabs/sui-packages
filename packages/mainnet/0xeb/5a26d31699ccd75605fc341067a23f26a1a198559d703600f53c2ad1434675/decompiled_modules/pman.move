module 0xeb5a26d31699ccd75605fc341067a23f26a1a198559d703600f53c2ad1434675::pman {
    struct PMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMAN>(arg0, 6, b"PMAN", b"Pregnant Man", b"Guys want to be pregnant too!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_20_22_20_49_e1f9917eff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

