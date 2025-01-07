module 0x6b2adacd239838c73502c8b71f420cedc88ab27b2dfec3e512eb23b90e7b6bcb::rss {
    struct RSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSS>(arg0, 6, b"Rss", b"Rasahsui2", b"Enjoy ride, to much ripe,here we fill save", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000035529_b869f4b957.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

