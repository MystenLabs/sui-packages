module 0xd3c936f1f963a8b9cdfd41d8e9958032c2142cd1abbcf7c65701111f3c1dde86::ml3 {
    struct ML3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ML3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ML3>(arg0, 9, b"ML3", b"melo3", b"tenis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/692e7672-53fc-4a0a-8b17-b29fbfac5453.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ML3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ML3>>(v1);
    }

    // decompiled from Move bytecode v6
}

