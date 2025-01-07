module 0xde3dd82015118b883f683b214aa78906a400fc8f9907cf44fa141d96ed486ae::ambs {
    struct AMBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMBS>(arg0, 6, b"AMBS", b"AMBSUI", b"TOP TOP TOP TREND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suimeme_logo_9ef58ae12b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

