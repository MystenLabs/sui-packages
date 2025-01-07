module 0xfdddedd3bb6cbca7bee4bcf76108163b01a0434355bd03e2222b43ae6e61fca3::kingdarius {
    struct KINGDARIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGDARIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGDARIUS>(arg0, 6, b"KingDarius", b"Potato Monster", b"King Darius Goes Wild fo da potatoes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5871_4df58184ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGDARIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGDARIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

