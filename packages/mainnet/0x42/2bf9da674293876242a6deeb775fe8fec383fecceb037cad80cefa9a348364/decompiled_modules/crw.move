module 0x422bf9da674293876242a6deeb775fe8fec383fecceb037cad80cefa9a348364::crw {
    struct CRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRW>(arg0, 9, b"CRW", b"CROW", b"A crow is a bird of the genus Corvus, or more broadly, a synonym for all of Corvus. The word \"crow\" is used as part of the common name of many species.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc7ba91c-f6ab-41dc-958e-6c168c65dc78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRW>>(v1);
    }

    // decompiled from Move bytecode v6
}

