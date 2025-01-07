module 0xf45743fcafc9fa0bec247bfe56ebe5a9cb794f5075a7052bed028955a0ca1938::flm {
    struct FLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLM>(arg0, 9, b"FLM", b"Flame", b"Let's burnnn!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a20c46b-b71c-4aa4-b2da-0d0bdd4d6f30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

