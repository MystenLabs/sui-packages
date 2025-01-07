module 0x3abfacb41ad28c01850115135c3ba8e947048eb9872c09d7fd60b9d15f9bdfa1::feken {
    struct FEKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEKEN>(arg0, 9, b"FEKEN", b"heh", b"bdn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca77c2f7-aba8-4066-a094-2089369a3a36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

