module 0xfa2fb99408999801d4f58d33cae7be252265bf9d321c41c7f6a6869937350943::seaking {
    struct SEAKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAKING>(arg0, 9, b"SEAKING", b"Sea King", x"f09f94b1417175616d616e206973204b696e67206f66205365612e20486520676f7665726e7320776174657220776f726c642e2048697320706f77657266756c20776561706f6d20697320476f6c642054726964656e742e20416e64206e6f772c204869732073746f727920626567696e732e2e2ef09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5018569-46a0-493a-99ce-9fa1d246b4dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

