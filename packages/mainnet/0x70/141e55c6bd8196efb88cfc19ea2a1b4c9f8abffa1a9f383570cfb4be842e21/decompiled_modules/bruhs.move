module 0x70141e55c6bd8196efb88cfc19ea2a1b4c9f8abffa1a9f383570cfb4be842e21::bruhs {
    struct BRUHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUHS>(arg0, 6, b"BRUHS", b"Bruh on Sui", b"Meet Bruh, the lazy Green monster that doesn't give a damn about anything or anyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_03d588e38a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

