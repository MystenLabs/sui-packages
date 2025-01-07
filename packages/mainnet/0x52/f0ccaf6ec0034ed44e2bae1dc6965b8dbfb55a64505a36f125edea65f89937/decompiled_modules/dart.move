module 0x52f0ccaf6ec0034ed44e2bae1dc6965b8dbfb55a64505a36f125edea65f89937::dart {
    struct DART has drop {
        dummy_field: bool,
    }

    fun init(arg0: DART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DART>(arg0, 9, b"DART", b"Dart dog", b"Dartdog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4562f3f-50b4-41ca-aa5a-88e69e699ec2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DART>>(v1);
    }

    // decompiled from Move bytecode v6
}

