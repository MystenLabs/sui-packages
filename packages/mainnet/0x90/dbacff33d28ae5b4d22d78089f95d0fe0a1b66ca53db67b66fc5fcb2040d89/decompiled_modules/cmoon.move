module 0x90dbacff33d28ae5b4d22d78089f95d0fe0a1b66ca53db67b66fc5fcb2040d89::cmoon {
    struct CMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMOON>(arg0, 9, b"CMOON", b"cmoon", x"436f696e20746f20746865206d6f6f6e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16572d9b-0b50-489c-b00d-f2fdda66bde3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

