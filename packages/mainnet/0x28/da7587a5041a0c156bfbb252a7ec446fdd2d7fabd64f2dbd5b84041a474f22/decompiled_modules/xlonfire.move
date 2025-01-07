module 0x28da7587a5041a0c156bfbb252a7ec446fdd2d7fabd64f2dbd5b84041a474f22::xlonfire {
    struct XLONFIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: XLONFIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XLONFIRE>(arg0, 9, b"XLONFIRE", b"XLON", b"MEME COIN DYOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c447646-efd2-4592-85b0-2fab94d3f22e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XLONFIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XLONFIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

