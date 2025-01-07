module 0xb9cce3624f58225c0008ca824c5f3712d72119e48ed3c8115e83200707c9c0ab::meos {
    struct MEOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOS>(arg0, 9, b"MEOS", b"MEOMEO", b"Meomeo on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b212b4df-1cae-47fe-b208-bd47a782262f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

