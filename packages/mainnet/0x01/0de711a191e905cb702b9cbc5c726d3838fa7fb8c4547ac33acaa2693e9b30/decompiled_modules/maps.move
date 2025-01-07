module 0x10de711a191e905cb702b9cbc5c726d3838fa7fb8c4547ac33acaa2693e9b30::maps {
    struct MAPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAPS>(arg0, 6, b"MAPS", b"First AI Navigator", b"AI META", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_13_35_21_ef38a537b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

