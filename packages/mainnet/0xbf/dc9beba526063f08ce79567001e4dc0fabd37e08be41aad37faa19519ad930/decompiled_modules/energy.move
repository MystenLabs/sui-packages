module 0xbfdc9beba526063f08ce79567001e4dc0fabd37e08be41aad37faa19519ad930::energy {
    struct ENERGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENERGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENERGY>(arg0, 9, b"ENERGY", b"The Energy", b"Energy cannot be created and cannot be destroyed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/693fa489-593b-40f2-9524-1876e4b0ce72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENERGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENERGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

