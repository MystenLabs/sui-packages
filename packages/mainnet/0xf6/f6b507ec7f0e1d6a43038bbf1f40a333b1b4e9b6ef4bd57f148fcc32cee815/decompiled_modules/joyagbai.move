module 0xf6f6b507ec7f0e1d6a43038bbf1f40a333b1b4e9b6ef4bd57f148fcc32cee815::joyagbai {
    struct JOYAGBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOYAGBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOYAGBAI>(arg0, 9, b"JOYAGBAI", b"Joy", b"This is a mission to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf8d8867-962c-418b-8a5f-fd35f08c19f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOYAGBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOYAGBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

