module 0x2c0228ad2d4f2bcce8edd31d78ed90bcd7bb3c38d9870a8641c0d2a4052161f0::ww {
    struct WW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WW>(arg0, 9, b"WW", b"Wew", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c817c6c-1526-4d24-9380-ad98b7805d79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WW>>(v1);
    }

    // decompiled from Move bytecode v6
}

