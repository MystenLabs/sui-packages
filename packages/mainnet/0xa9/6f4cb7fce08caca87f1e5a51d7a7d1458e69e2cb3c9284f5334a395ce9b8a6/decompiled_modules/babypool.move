module 0xa96f4cb7fce08caca87f1e5a51d7a7d1458e69e2cb3c9284f5334a395ce9b8a6::babypool {
    struct BABYPOOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPOOL>(arg0, 9, b"BABYPOOL", b"Babypool", b"Deadpool variant which is baby cute pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbc4dfab-b907-495e-a70c-2887ce913a33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPOOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYPOOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

