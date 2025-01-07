module 0x78bc744c332e44d8ce47b696e8988f10e0220ed08ca0254159b3c3c3d5825316::apple {
    struct APPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPLE>(arg0, 6, b"APPLE", b"dog with apple in mouth on sui", b"the famous dog with apple in mouth on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2141_a204adbea7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

