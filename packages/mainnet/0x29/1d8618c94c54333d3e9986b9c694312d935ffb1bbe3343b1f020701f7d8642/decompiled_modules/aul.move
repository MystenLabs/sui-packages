module 0x291d8618c94c54333d3e9986b9c694312d935ffb1bbe3343b1f020701f7d8642::aul {
    struct AUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUL>(arg0, 9, b"AUL", b"Auwalu", b"Aultoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0d310f0-c5ce-4c6d-96b1-049a0a9dc825.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

