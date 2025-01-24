module 0x73746fead557b57700bda7f8651409ba622721bb79aaf17dbc30bbbd61480f05::alt {
    struct ALT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALT>(arg0, 9, b"ALT", b"TRUM PUM", b"Trump pump is a meme coin created by the trump loving team is the trend 2025-2029", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9542f80-48e8-45ed-b91e-73b2f9d6b71f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALT>>(v1);
    }

    // decompiled from Move bytecode v6
}

