module 0xfada2823225e1d7efe932c889c285d7d9ac212c8eaadca7ca24e68fdfad50ad2::qha {
    struct QHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QHA>(arg0, 9, b"QHA", b"Abc", b"Ab ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ababa39-eafa-401a-b23b-e7a188388b3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

