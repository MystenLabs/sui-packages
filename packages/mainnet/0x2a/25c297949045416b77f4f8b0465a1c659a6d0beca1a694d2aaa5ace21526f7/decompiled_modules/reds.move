module 0x2a25c297949045416b77f4f8b0465a1c659a6d0beca1a694d2aaa5ace21526f7::reds {
    struct REDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDS>(arg0, 9, b"REDS", b"Reditus", b"Mining token. 1 Reds equal 1Th power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb2b6eac-35bb-403f-857a-61bbc515408d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

