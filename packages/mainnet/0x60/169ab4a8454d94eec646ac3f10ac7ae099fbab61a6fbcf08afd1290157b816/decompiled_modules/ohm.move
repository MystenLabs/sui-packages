module 0x60169ab4a8454d94eec646ac3f10ac7ae099fbab61a6fbcf08afd1290157b816::ohm {
    struct OHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHM>(arg0, 9, b"OHM", b"Hinduism ", b"Embark on a journey of spiritual exploration and self-discovery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a8a3d9d-3c12-4ceb-abe4-18cbc12a56a6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

