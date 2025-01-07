module 0x13ccdc4e8be74e656b3d283ee54118e23da959991d7aad5d956cec470ae887e4::pippi {
    struct PIPPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPI>(arg0, 9, b"PIPPI", b"pippi coin", b"Pippi is funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/00a65be2-b20d-4ade-a67a-ca06cf54a4e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

