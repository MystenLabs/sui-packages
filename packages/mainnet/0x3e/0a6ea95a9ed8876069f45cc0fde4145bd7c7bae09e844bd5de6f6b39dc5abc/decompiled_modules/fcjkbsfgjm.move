module 0x3e0a6ea95a9ed8876069f45cc0fde4145bd7c7bae09e844bd5de6f6b39dc5abc::fcjkbsfgjm {
    struct FCJKBSFGJM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCJKBSFGJM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCJKBSFGJM>(arg0, 9, b"FCJKBSFGJM", b"Fhncdf", b"Cnkkddehjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d56c99e-2d16-48da-a976-7f96e8c44a78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCJKBSFGJM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCJKBSFGJM>>(v1);
    }

    // decompiled from Move bytecode v6
}

