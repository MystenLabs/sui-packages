module 0x6b5742c2b2296d31be18ba9a5706a8614937e6e6e7946ed8005b099822481579::fg {
    struct FG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FG>(arg0, 9, b"FG", b"SAF", b"Q", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5738b631-195d-4b0f-a791-222414a86367.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FG>>(v1);
    }

    // decompiled from Move bytecode v6
}

