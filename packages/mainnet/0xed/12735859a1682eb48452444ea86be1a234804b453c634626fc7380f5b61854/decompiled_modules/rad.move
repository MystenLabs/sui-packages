module 0xed12735859a1682eb48452444ea86be1a234804b453c634626fc7380f5b61854::rad {
    struct RAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAD>(arg0, 6, b"RAD", b"RADLEY", b"First $RAD on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6697_28b29db2e3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

