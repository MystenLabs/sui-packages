module 0x44afd19f8b1a20d75b4a0e21558c710dfcd553972135e89ba2324bc3a0c1372a::lofi {
    struct LOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFI>(arg0, 6, b"Lofi", b"Chill Lofi", b"Chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_07_23_40_18_c5a2f9c8ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

