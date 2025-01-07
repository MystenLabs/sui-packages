module 0x3a2de858c8b005d9bbe7597f779ba8c7579566a3cc004ec232ab3d656e86da08::tedb {
    struct TEDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEDB>(arg0, 6, b"TEDB", b"TEEN DIRT BAG", b"I 'm just a teen dirt bag baby like you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_17_59_17_66df95bea1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

