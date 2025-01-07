module 0x5da44d382745f21c0a9f33fbafb37362c0837da222c70317965357f327dacb24::wayfinder {
    struct WAYFINDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAYFINDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAYFINDER>(arg0, 6, b"Wayfinder", b"Wayfinder AI", b"AI tool specializing in finding and navigating blockchain pathways for optimal user experiences", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042028_69e5c2dec3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAYFINDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAYFINDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

