module 0x90a8f0eb9a1ddb9d9f88fd43251984b402e17aa69c4c2b5131e4b3d75194a86c::harga {
    struct HARGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARGA>(arg0, 9, b"HARGA", b"To", b"Jjhhhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f81f133b-ec5b-4343-895e-1d5823d67b15.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

