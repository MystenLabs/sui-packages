module 0x73be6b97b9b0f30939d39ae3fa216d82eb13fbd24ddbc9ed03685537987278b3::movementtt {
    struct MOVEMENTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEMENTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEMENTTT>(arg0, 9, b"MOVEMENTTT", b"Gmove", b"Gmove go to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d2acb1d-e03e-4796-a683-cbd2b961ea8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEMENTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVEMENTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

