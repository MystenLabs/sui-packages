module 0x13361d720f5e42fe1b93d84cd2715386a9d15f62250d4c3a82d14cb7180dcb83::ann {
    struct ANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANN>(arg0, 9, b"ANN", b"Ayoyinka H", b"Wave wallet meme culture Ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b0cc20b-fd0a-4811-b734-b35263c5a62c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

