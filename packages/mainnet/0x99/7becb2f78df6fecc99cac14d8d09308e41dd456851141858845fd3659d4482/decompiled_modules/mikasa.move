module 0x997becb2f78df6fecc99cac14d8d09308e41dd456851141858845fd3659d4482::mikasa {
    struct MIKASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKASA>(arg0, 9, b"MIKASA", b"Mikasa.sui", b"mikas on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/61e3b01f-fee3-4671-8e7d-22a19d71ae68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

