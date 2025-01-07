module 0x67060a0e8a62e72832c132043745ed7993d3089e29b6048225f591d61bc0a7e4::lily {
    struct LILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILY>(arg0, 6, b"LILY", b"Lily Dog Sui", b"Lily's Coin - A memecoin honoring my dog Lily, born on the same day as the #Bitcoin and will sail the sui sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018178_6d71bad858.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

