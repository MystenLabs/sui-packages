module 0x7a4f01b3f8a9dc7e8888536b1be5bee319a14c4faf55d4330e28ab84d53e246e::nep {
    struct NEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEP>(arg0, 9, b"NEP", b"NEPTUNE", b"Token for WAVE Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c86a4a7-e90f-418a-8b31-deeeef0bdd45-1921144_1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

