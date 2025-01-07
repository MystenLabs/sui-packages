module 0x6b57a39b306c83ae08a8bdd6faf19d1b978bf452d3616ba20a70db7ceacbbade::ui {
    struct UI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UI>(arg0, 9, b"UI", b"Ticker", b"Utility ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47b964cc-0331-4982-9914-cedf82d9cc0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UI>>(v1);
    }

    // decompiled from Move bytecode v6
}

