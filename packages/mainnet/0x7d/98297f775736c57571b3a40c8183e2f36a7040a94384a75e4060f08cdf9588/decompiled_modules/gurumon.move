module 0x7d98297f775736c57571b3a40c8183e2f36a7040a94384a75e4060f08cdf9588::gurumon {
    struct GURUMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURUMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURUMON>(arg0, 6, b"GURUMON", b"Gurumon on sui", x"6a6f696e2024475552554d4f4e206f6e206869732077617920746f207468652024535549204f6c796d70202d204f4720636861726163746572206279204d617474204675726965210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241130_081430_042_56c77ba945.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURUMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURUMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

