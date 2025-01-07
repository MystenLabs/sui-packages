module 0x2754991cc28156b994bf107c8ceac2b13d2868edd82943257aeda2ea1dccc9f5::bene {
    struct BENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENE>(arg0, 9, b"BENE", b"Benebuchi", b"Walking to earn with good slippers meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52ebf1b0-93d8-483b-aca7-ba1f85e3ecb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

