module 0x6b7dbf6080dc2b06e84039d23e0e6ebb860a3c58ed8069a4418b83b7d57f1ea3::crottoken {
    struct CROTTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROTTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROTTOKEN>(arg0, 9, b"CROTTOKEN", b"Crot", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0dd53f85-b412-4843-899b-fcb7c1775fc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROTTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CROTTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

