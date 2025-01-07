module 0xa4185dcab5041f05df15fe55c4e74db665a8866f804248477928329a8309b3b2::wpp {
    struct WPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPP>(arg0, 9, b"WPP", b"AYUD", b"WEWEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1e77dd68-5a63-4a2f-89c8-0dace509a4db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

