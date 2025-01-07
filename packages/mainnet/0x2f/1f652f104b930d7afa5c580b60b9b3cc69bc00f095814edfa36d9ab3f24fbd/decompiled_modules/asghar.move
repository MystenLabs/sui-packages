module 0x2f1f652f104b930d7afa5c580b60b9b3cc69bc00f095814edfa36d9ab3f24fbd::asghar {
    struct ASGHAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASGHAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASGHAR>(arg0, 9, b"ASGHAR", b"Sumbal ", b"This is nice coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42f2c60d-4831-46b0-9571-207d4666de5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASGHAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASGHAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

