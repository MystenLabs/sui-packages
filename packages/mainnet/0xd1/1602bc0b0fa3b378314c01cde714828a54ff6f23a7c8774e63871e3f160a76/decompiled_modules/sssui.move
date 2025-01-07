module 0xd11602bc0b0fa3b378314c01cde714828a54ff6f23a7c8774e63871e3f160a76::sssui {
    struct SSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSUI>(arg0, 9, b"SSSUI", b"Suiss", b"Is the best meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30fb1636-1c28-4b7e-b55d-37265e3838c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

