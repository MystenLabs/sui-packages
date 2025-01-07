module 0x4c2996759def78498f344fcc4fad28112e5a654c807fbb8b341407ffe4489d8e::tonwave {
    struct TONWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONWAVE>(arg0, 9, b"TONWAVE", b"TON", b"Ton on wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/208a5c80-fa65-489d-98e2-b700a22d194f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

