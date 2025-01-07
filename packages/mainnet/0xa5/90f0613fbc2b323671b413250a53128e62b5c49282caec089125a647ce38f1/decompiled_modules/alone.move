module 0xa590f0613fbc2b323671b413250a53128e62b5c49282caec089125a647ce38f1::alone {
    struct ALONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALONE>(arg0, 9, b"ALONE", b"Lonely cat", b"lonely and forgotten", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfc38f77-2032-49c0-a4d4-e40432d90125.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

