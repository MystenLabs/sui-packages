module 0x6e988df3f73a168fd4bc82ade108673c909d20adc808c512db7520ecf4fd0b19::whale_1 {
    struct WHALE_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE_1>(arg0, 9, b"WHALE_1", b"Whale ", b"Whale Ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb1d89f9-6e06-4478-b752-2b6e3c5e1ba5-images.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHALE_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

