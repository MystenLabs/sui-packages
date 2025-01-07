module 0xbf18cd79aad45406dd75111ea296fdde648c9ef4ff0f40afc95ee623ce015d7f::glh {
    struct GLH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLH>(arg0, 9, b"GLH", b"FJH", b"Good morning I hope you ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/092094ff-9ee2-47f6-899c-845a74575482.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLH>>(v1);
    }

    // decompiled from Move bytecode v6
}

