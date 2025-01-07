module 0xe94ad4e4c6874eea8918fe18f6d1458a6df0708433164db2cfaaae613611e58::fvgs {
    struct FVGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FVGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FVGS>(arg0, 9, b"FVGS", b"WSRTW", b"SFFSD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/899788a3-a88e-4117-8892-9babf51ff206.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FVGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FVGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

