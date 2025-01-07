module 0x3cd8de7ad02a8f59fc22bfcd15ce6ac32b9fd017b6cc295f5a29bd000efc424a::ctnu {
    struct CTNU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTNU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTNU>(arg0, 9, b"CTNU", b"Cati-inu ", b"Cati finance ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/256d462e-26d0-45e9-a0fe-2854787dab74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTNU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTNU>>(v1);
    }

    // decompiled from Move bytecode v6
}

