module 0x9d2944626ffe01cd4293f04776586919c890e5ee71899fc0a2476a7995662acb::usm {
    struct USM has drop {
        dummy_field: bool,
    }

    fun init(arg0: USM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USM>(arg0, 9, b"USM", b"Utmen", b"USM token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd4eb9a6-48d2-45e2-a79c-53296564a223.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USM>>(v1);
    }

    // decompiled from Move bytecode v6
}

