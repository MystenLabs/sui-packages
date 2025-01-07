module 0x73c2d760c6daf6ecd90540eaed1af69b25bb14144df2817669e8e6e4e0fe542::deviloni {
    struct DEVILONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEVILONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVILONI>(arg0, 6, b"DEVILONI", b"DEVIL ONI", x"54686520666972737420646576696c206f6e207375690a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000521_9ef4c76ef2_3487c6cfb6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVILONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEVILONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

