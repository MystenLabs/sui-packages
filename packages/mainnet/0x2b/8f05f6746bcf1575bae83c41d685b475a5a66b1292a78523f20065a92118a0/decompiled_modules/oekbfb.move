module 0x2b8f05f6746bcf1575bae83c41d685b475a5a66b1292a78523f20065a92118a0::oekbfb {
    struct OEKBFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEKBFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEKBFB>(arg0, 9, b"OEKBFB", b"iekdn", b"hdbeb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1de0a9f4-ec5d-4535-b2a1-bf82d3f604a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEKBFB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEKBFB>>(v1);
    }

    // decompiled from Move bytecode v6
}

