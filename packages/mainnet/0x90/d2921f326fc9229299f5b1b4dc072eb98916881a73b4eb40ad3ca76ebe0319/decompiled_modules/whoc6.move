module 0x90d2921f326fc9229299f5b1b4dc072eb98916881a73b4eb40ad3ca76ebe0319::whoc6 {
    struct WHOC6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOC6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOC6>(arg0, 9, b"WHOC6", b"WHO", b"Who c6 is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9204cd9-3e52-46d1-ab51-2eb0be3670c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOC6>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WHOC6>>(v1);
    }

    // decompiled from Move bytecode v6
}

