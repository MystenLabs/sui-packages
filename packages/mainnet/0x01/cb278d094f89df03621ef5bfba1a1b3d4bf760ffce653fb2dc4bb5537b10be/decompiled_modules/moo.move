module 0x1cb278d094f89df03621ef5bfba1a1b3d4bf760ffce653fb2dc4bb5537b10be::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 9, b"MOO", b"MooDeng", b"1000000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f7cfaef-61bd-44b1-86e6-cc9dad3bcc92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

