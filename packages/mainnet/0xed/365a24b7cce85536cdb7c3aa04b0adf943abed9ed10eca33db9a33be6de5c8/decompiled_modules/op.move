module 0xed365a24b7cce85536cdb7c3aa04b0adf943abed9ed10eca33db9a33be6de5c8::op {
    struct OP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OP>(arg0, 9, b"OP", b"Aragon", b"Ajab sosise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca865cce-e839-462e-a2b9-617bbf1badb6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OP>>(v1);
    }

    // decompiled from Move bytecode v6
}

