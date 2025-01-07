module 0xe2ff5772dbbd5a0e5f943571a4c51c230db77166927b0d9f6ce2911212a88d3b::sdgg {
    struct SDGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDGG>(arg0, 9, b"SDGG", b"GSG", b"HFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/574ce9b5-8f8d-4fac-867c-8a3a41cc7a52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

