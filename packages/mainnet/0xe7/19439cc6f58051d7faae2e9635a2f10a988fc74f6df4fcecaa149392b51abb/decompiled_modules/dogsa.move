module 0xe719439cc6f58051d7faae2e9635a2f10a988fc74f6df4fcecaa149392b51abb::dogsa {
    struct DOGSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSA>(arg0, 9, b"DOGSA", b"DOGSACTION", b"Good token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6316754e-4b06-4142-bb52-03be04727912.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

