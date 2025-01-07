module 0x96caa51cf5fc43f7adbceb95adac47774df13e9114a607ae550b689cd8122213::mnc {
    struct MNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNC>(arg0, 9, b"MNC", b"Monaco", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6d7351e-94e1-4409-a00d-48c1c1730c88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

