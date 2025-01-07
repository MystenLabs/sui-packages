module 0x4d58a6041209c6377676e6cf394956bc576292d583937323bd4a083415ca2b3b::afc {
    struct AFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFC>(arg0, 9, b"AFC", b"AFCMAFIA", b"REAL FOOTBALL MAFIA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7aea1e41-60c6-4e23-a03c-9bbf1eff31bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

