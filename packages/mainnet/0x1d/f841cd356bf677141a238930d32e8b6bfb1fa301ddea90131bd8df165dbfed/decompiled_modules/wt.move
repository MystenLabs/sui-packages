module 0x1df841cd356bf677141a238930d32e8b6bfb1fa301ddea90131bd8df165dbfed::wt {
    struct WT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WT>(arg0, 9, b"WT", b"Water", b"Waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5dd7b117-e0c3-4287-8769-1c88ad889f2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WT>>(v1);
    }

    // decompiled from Move bytecode v6
}

