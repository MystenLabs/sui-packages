module 0x1d1d071acc234bb52c2046d53229c8cd110d4b90682e4540e75ccdc7fcaa7b11::asghar {
    struct ASGHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASGHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASGHAR>(arg0, 9, b"ASGHAR", b"Sumbal", b"This is nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c23dd99b-7b41-41c6-b295-da31976d5158.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASGHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASGHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

