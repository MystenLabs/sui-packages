module 0x58e64fa5d8ce0d00d62aa42d6d1753b429c8d27dc2ad43dacbb3a182bcdfa2da::momon {
    struct MOMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMON>(arg0, 9, b"MOMON", b"MOMO", b"Mo Mon Trader - clicker game by Spin DEX! Tap to the screen, upgrade and win juicy rewards!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3267e3b5-2503-403d-8229-17b35f84fd53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMON>>(v1);
    }

    // decompiled from Move bytecode v6
}

