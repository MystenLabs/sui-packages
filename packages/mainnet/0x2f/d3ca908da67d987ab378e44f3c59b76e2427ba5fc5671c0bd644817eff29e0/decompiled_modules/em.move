module 0x2fd3ca908da67d987ab378e44f3c59b76e2427ba5fc5671c0bd644817eff29e0::em {
    struct EM has drop {
        dummy_field: bool,
    }

    fun init(arg0: EM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EM>(arg0, 9, b"EM", b"Elon musk", x"456c6f6e206d75736b20636f696e20f09faa99205465736c61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fa3dbc5-999c-4627-a175-e8944cce06b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EM>>(v1);
    }

    // decompiled from Move bytecode v6
}

