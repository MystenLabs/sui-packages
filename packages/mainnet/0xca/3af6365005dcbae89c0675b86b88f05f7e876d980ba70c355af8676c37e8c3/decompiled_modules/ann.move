module 0xca3af6365005dcbae89c0675b86b88f05f7e876d980ba70c355af8676c37e8c3::ann {
    struct ANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANN>(arg0, 9, b"ANN", b"Ayoyinka H", b"Meme culture @Ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cfe0d2a-5035-4263-b2df-ea0c39bc6f3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

