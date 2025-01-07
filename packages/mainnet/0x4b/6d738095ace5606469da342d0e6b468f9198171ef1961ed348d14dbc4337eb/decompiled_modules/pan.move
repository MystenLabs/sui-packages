module 0x4b6d738095ace5606469da342d0e6b468f9198171ef1961ed348d14dbc4337eb::pan {
    struct PAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAN>(arg0, 9, b"PAN", b"Panda", b"Panda Animal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/045414f7-d434-4a7e-9160-a4b9d4c7ac49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

