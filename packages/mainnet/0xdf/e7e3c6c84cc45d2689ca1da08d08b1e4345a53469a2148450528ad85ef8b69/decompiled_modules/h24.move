module 0xdfe7e3c6c84cc45d2689ca1da08d08b1e4345a53469a2148450528ad85ef8b69::h24 {
    struct H24 has drop {
        dummy_field: bool,
    }

    fun init(arg0: H24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H24>(arg0, 9, b"H24", b"happy24", b"member card", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49333716-442f-400e-8ac3-3090d968d061.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H24>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H24>>(v1);
    }

    // decompiled from Move bytecode v6
}

