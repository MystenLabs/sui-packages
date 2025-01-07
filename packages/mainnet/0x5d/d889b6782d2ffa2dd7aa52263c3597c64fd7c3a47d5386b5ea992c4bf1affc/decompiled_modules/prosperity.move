module 0x5dd889b6782d2ffa2dd7aa52263c3597c64fd7c3a47d5386b5ea992c4bf1affc::prosperity {
    struct PROSPERITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PROSPERITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROSPERITY>(arg0, 9, b"PROSPERITY", b"Kil_T_Pain", b"This token was inspired by the need to eradicate the pain inflicted on Nigerian by the tinubu administration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b632b67-01bc-4ebc-8524-f93b25b4c14b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROSPERITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROSPERITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

