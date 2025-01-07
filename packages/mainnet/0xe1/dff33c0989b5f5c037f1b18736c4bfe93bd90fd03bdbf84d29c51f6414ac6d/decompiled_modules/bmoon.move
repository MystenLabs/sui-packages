module 0xe1dff33c0989b5f5c037f1b18736c4bfe93bd90fd03bdbf84d29c51f6414ac6d::bmoon {
    struct BMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOON>(arg0, 6, b"BMOON", b"Bluemoon", b"A blue moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9739_c74671ee62.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

