module 0x3ce6fc6d883e7efe48443d9d67b04e6013673bcf9779a1b772b46b36f9c80ab5::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HI>(arg0, 9, b"HI", b"Ansar", b"Please invest ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47ae1659-ff2b-4b10-ad9e-d1f678a8c92a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HI>>(v1);
    }

    // decompiled from Move bytecode v6
}

