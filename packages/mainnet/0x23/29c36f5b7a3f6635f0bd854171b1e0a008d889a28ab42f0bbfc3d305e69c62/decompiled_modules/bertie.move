module 0x2329c36f5b7a3f6635f0bd854171b1e0a008d889a28ab42f0bbfc3d305e69c62::bertie {
    struct BERTIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BERTIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BERTIE>(arg0, 6, b"BERTIE", b"Bertie", b"Bertie is Worlds fastest tortoise . ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_16_43_25_a1f69e1767.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BERTIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BERTIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

