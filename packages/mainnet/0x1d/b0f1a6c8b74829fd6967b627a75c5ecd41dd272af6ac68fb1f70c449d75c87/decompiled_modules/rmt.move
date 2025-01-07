module 0x1db0f1a6c8b74829fd6967b627a75c5ecd41dd272af6ac68fb1f70c449d75c87::rmt {
    struct RMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMT>(arg0, 9, b"RMT", b"Remote", b"Remote meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b74bdb0-faa7-43a9-a621-42279fe2e29e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

