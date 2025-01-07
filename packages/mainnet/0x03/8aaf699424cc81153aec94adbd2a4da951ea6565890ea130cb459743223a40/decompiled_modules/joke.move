module 0x38aaf699424cc81153aec94adbd2a4da951ea6565890ea130cb459743223a40::joke {
    struct JOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKE>(arg0, 9, b"JOKE", b"A joke", b"How much are you willing to pay to laugh HA Ha Ha Ha Ha Ha Ha Ha Ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/043c3b94-5b5e-4a76-b10b-8148ae3612e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

