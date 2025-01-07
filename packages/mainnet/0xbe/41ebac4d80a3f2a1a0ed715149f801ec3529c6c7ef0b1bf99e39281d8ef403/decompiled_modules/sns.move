module 0xbe41ebac4d80a3f2a1a0ed715149f801ec3529c6c7ef0b1bf99e39281d8ef403::sns {
    struct SNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNS>(arg0, 9, b"SNS", b"Sansa", b"scratch my belly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3e7e0fb-50e2-4ac6-bd9d-9d8353202201.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

