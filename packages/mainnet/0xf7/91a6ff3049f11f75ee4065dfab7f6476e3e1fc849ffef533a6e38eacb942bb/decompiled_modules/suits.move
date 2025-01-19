module 0xf791a6ff3049f11f75ee4065dfab7f6476e3e1fc849ffef533a6e38eacb942bb::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 9, b"SUITS", b"$uit$", x"426c75652677686974652024756974242066726f6d207468652024746f636b206d61726b657420656e746572207468652053554920626c6f636b636861696e20746f206272696e67206d6f6e6579207072696e7465727320746f2074686520636f6d6d756e6974792120f09f9194", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89820087-448e-4b41-a724-86b48cd34367.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

