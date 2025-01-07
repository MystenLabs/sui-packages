module 0x7eb4374f4d2cf1fe084e93eea3f989e1534b9235d68d852dade703c60e71d485::dac {
    struct DAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAC>(arg0, 9, b"DAC", b"DANCE", b"DANCE IS HAPPY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a2b66ee-bc02-4c12-8b33-3fbda2a3aac2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

