module 0x46002f3a80a640e7a35c07bfacdd353f3ce540cd27b03d5b479476053f205353::ad {
    struct AD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AD>(arg0, 9, b"AD", b"Aidoge ", b"ELON MUSK TOKEN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04c1fa74-1c6c-4f09-ac1b-529998190389.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AD>>(v1);
    }

    // decompiled from Move bytecode v6
}

