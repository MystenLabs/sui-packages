module 0x86fe922c91753954aabdc1469d8604c52fab7456cc6117546c46c2ce6e2d4415::suimon {
    struct SUIMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMON>(arg0, 6, b"Suimon", b"SuimonCoin", b"New meme top on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_24_17_27_33_3ff96a95a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

