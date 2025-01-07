module 0x7c7fc2d5f883cc9d7ea49e21803a08187c41205e998c442f638a24fd8b2d1e90::pigu {
    struct PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGU>(arg0, 6, b"PIGU", b"PIGU The Penguin", b"Navigating PIGU's world on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pigu_1cfde34827.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

