module 0xad1a9ed33e451b293e941c25002277482f9875496ca95a7707ccb23ffcee2553::qntl {
    struct QNTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: QNTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QNTL>(arg0, 9, b"QNTL", b"Qontolodon", b"Token meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e6bc873-4bc5-4797-b498-da58f2bab89b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QNTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QNTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

