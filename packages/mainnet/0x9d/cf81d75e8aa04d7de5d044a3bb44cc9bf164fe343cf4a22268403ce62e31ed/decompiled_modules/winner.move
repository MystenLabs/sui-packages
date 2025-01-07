module 0x9dcf81d75e8aa04d7de5d044a3bb44cc9bf164fe343cf4a22268403ce62e31ed::winner {
    struct WINNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINNER>(arg0, 9, b"WINNER", x"42616c6c6f6e2044e280996f", b"World Best Vini", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/946d5914-8f6b-4d80-b3f1-cde3fa37c9e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

