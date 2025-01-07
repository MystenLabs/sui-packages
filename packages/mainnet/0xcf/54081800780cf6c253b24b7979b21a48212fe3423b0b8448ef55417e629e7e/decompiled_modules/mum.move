module 0xcf54081800780cf6c253b24b7979b21a48212fe3423b0b8448ef55417e629e7e::mum {
    struct MUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUM>(arg0, 9, b"MUM", b"Mummy ", b"Every mother deserves the best ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27d2a5b6-c47e-4da4-b963-9c3e4c02da77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

