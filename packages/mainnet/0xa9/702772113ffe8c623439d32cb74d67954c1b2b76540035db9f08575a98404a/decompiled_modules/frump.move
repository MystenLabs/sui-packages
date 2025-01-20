module 0xa9702772113ffe8c623439d32cb74d67954c1b2b76540035db9f08575a98404a::frump {
    struct FRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRUMP>(arg0, 6, b"FRUMP", b"DONAL FRUMP", b"Make Amphibians Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_060103_319_5c9c0ea277.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

