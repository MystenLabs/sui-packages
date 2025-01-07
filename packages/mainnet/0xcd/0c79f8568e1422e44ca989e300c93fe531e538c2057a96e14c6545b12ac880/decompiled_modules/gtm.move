module 0xcd0c79f8568e1422e44ca989e300c93fe531e538c2057a96e14c6545b12ac880::gtm {
    struct GTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTM>(arg0, 9, b"GTM", b"Gintama", b"GINTAMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/28fe0d2b-0bc2-42f0-9e10-dae0b6038660.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

