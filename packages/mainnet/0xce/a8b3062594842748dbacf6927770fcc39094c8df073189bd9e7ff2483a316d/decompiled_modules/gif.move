module 0xcea8b3062594842748dbacf6927770fcc39094c8df073189bd9e7ff2483a316d::gif {
    struct GIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIF>(arg0, 9, b"GIF", b"Girlfriend", b"My lover", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fef8c490-0402-4543-8530-b478d5310ffb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

