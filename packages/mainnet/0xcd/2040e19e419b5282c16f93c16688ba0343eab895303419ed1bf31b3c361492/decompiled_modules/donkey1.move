module 0xcd2040e19e419b5282c16f93c16688ba0343eab895303419ed1bf31b3c361492::donkey1 {
    struct DONKEY1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY1>(arg0, 9, b"DONKEY1", b"Donkey ", b"For", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd45720c-f5cf-4d45-86a2-872a4d0a06b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONKEY1>>(v1);
    }

    // decompiled from Move bytecode v6
}

