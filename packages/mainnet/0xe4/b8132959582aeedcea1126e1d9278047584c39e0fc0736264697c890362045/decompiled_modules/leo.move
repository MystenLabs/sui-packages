module 0xe4b8132959582aeedcea1126e1d9278047584c39e0fc0736264697c890362045::leo {
    struct LEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEO>(arg0, 9, b"LEO", b"Leo", b"Leo is from the word Leopard ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f8afc80-6ade-4da6-8902-a7dcdc5451d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

