module 0xee7e4c7592c295fa8eab9cba90894644eec16a05acb8fa6c9f3b69e2ad06e6cc::hfd {
    struct HFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFD>(arg0, 9, b"HFD", b"F", b"FDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba632acf-5e8c-4d7e-a2c8-8c5a31cd2b49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

