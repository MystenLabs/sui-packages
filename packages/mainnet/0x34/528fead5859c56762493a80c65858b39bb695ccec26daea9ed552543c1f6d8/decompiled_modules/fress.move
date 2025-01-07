module 0x34528fead5859c56762493a80c65858b39bb695ccec26daea9ed552543c1f6d8::fress {
    struct FRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRESS>(arg0, 6, b"FRESS", b"FRESS?", b"When fress?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_13_52_15_b0c6d89de6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

