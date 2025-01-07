module 0x1c414641263d23a288e7c0b33ca7eb4975cd4d022c27e7274add7a0e9de3efef::uno {
    struct UNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNO>(arg0, 9, b"UNO", b"Uno card", b"Do something you don't like or draw 25 card", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d50e1b66-577b-407d-865d-cfc0c5a7270b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

