module 0x7004108910cfa881ed96b3aab1b0b8216c0316a2302b0ad45b505012bdae7693::ccd {
    struct CCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCD>(arg0, 9, b"CCD", b"CAR", b"THIS CAR MAKES NOISE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/055debd5-7c96-4bb7-9d61-fa5114682299.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

