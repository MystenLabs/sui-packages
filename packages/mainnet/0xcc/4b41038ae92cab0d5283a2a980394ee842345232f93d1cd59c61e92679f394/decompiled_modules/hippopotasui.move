module 0xcc4b41038ae92cab0d5283a2a980394ee842345232f93d1cd59c61e92679f394::hippopotasui {
    struct HIPPOPOTASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOPOTASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOPOTASUI>(arg0, 6, b"HIPPOPOTASUI", b"HippopotaSUI", b"Hippopotasui is sibling sudeng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_25_11_12_50_2c6ad92e53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOPOTASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOPOTASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

