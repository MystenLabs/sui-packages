module 0x71fe8ec62f960dc7dc0732a9c110a0e93f6058065eeaa392ac4cff21e5711b52::winner {
    struct WINNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINNER>(arg0, 9, b"WINNER", x"42616c6c6f6e2044e280996f", b"World Best Vini", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d86a573-7b52-45df-8fcb-784cd46f1885.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINNER>>(v1);
    }

    // decompiled from Move bytecode v6
}

