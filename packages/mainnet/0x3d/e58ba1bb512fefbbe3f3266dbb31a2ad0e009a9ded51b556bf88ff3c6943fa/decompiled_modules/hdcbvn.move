module 0x3de58ba1bb512fefbbe3f3266dbb31a2ad0e009a9ded51b556bf88ff3c6943fa::hdcbvn {
    struct HDCBVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDCBVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDCBVN>(arg0, 9, b"HDCBVN", b"Hdcb", b"Hottoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb5331dc-9704-4440-b4c9-581c03941948.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDCBVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDCBVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

