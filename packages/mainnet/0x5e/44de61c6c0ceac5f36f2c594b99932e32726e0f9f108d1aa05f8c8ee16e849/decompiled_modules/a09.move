module 0x5e44de61c6c0ceac5f36f2c594b99932e32726e0f9f108d1aa05f8c8ee16e849::a09 {
    struct A09 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A09, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A09>(arg0, 9, b"A09", b"Sumbal Asg", b"This is good coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9eae1eed-4cb5-4447-8f46-d840c5d14ccd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A09>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A09>>(v1);
    }

    // decompiled from Move bytecode v6
}

