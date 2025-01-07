module 0xe86d98b3ce01e33f0d2061fc75d55df27e1d63ff99fda6d6178a9f71c663e6d::wec {
    struct WEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEC>(arg0, 9, b"WEC", b"WeweCoin", b"Wewepump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7df7cc51-517f-4db0-8365-84f9b7ca1758.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

