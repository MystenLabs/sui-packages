module 0x7babf80c2b67ca2a94147906e8dd0a45cafddc2cda5deb95593626318bc9f866::hack {
    struct HACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACK>(arg0, 9, b"HACK", b"Hacker", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05a1c865-9528-4fb0-bc03-b7c2928f6bb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

