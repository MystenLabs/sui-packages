module 0x2c399ddf4a5a4f30a5b75d6dc97bdfc89a2d643c5e625c797cb9473840fd1426::axitek {
    struct AXITEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXITEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXITEK>(arg0, 9, b"AXITEK", x"205741564520f09f8c8a", x"5468652077617920796f7520617265206c6f6f6b696e6720617420f09f9180206973204920616d20646f6ee2809974207468696e6b206b6e6f772077686174207768617420796f7520796f752061726520617265206c6f6f6b696e67206c6f6f6b696e672075702071205175717571757571", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b06a0928-1815-4843-a41d-5db9bbf291a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXITEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AXITEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

