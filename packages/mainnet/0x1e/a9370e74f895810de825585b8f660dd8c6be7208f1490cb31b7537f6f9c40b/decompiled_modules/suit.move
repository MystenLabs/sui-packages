module 0x1ea9370e74f895810de825585b8f660dd8c6be7208f1490cb31b7537f6f9c40b::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"SUIT on SUI", x"45766572792043686164206e6565647320612053554954210a0a5468657265206973206e6f20706c61636520666f722074656172732e2052656d656d6265722c20796f7520617265206120636861642e2054616b6520616e6420776561722074686973205355495421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4215_1a0c628d31.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

