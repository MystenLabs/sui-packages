module 0xaec9141572b06b848dcf1cabe2b0fbfcbd2c4e27ba71cfd157d04d4eab2845ae::joke {
    struct JOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKE>(arg0, 9, b"JOKE", b"A joke ", b"How much are you willing to pay to laugh HA Ha Ha Ha Ha Ha Ha Ha Ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0f0c4e3-7ab6-4c53-a0f7-c27c54168d3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

