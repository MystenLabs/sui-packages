module 0x20ee40b12fa72b44f04b79c9823d096a8e985bd6d8365743e6246a47a8739f91::nkg {
    struct NKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKG>(arg0, 9, b"NKG", b"NICEKING", b"MY WEWE MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1cf7d9e-13e8-4080-8d68-e78767c45fbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

