module 0xa7dcab652e7310501eb402454f2dc152a87743655f250b651c104894f44bde8a::noppers {
    struct NOPPERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOPPERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOPPERS>(arg0, 6, b"NOPPERS", b"NOPPERS ON SUI", b"NONONONONONONONONONONONONONONONONONONONO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b6b7c37873b2fba85c948b51b65213b8_83533d9238.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOPPERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOPPERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

