module 0x120d23d64e60ae55bb4fe9757872815bb2160a05fb0ad987f4124f4accc16172::jpg {
    struct JPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPG>(arg0, 9, b"JPG", b"Df", b"A proactive coin that is projected for posterity beautification.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a41853b-6203-4b30-98a9-288313bfc11e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

