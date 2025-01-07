module 0x61a80e753c1edd647cf3a2cb83a0c1fff80966c2651e675b8cd6166db4fbfc7d::sate {
    struct SATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATE>(arg0, 9, b"SATE", b"Sate Ayam", b"SATE AYAM bumbu kacang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac0a7891-5d4c-4252-aa24-ffc75586bc36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

